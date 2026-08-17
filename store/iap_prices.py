"""Read the real per-territory price of the unlock out of App Store Connect.

    python store/iap_prices.py            # show them
    python store/iap_prices.py --write    # and update store/shot_prices.json

Why this exists. The paywall screenshot showed `Unlock for $4.99` in every
language, including en-GB, because a simulator has no store connection and the
app falls back to its advertised dollar price. A dollar figure on a British or
Brazilian storefront is simply wrong information.

The fix is not to convert the dollar price. **Apple's price points are not
currency conversions** — the UK price of a $4.99 tier is whatever Apple's table
says it is, and a plausible-looking arithmetic result would be a fabrication. So
the numbers come from the price schedule Apple actually holds, and the formatting
comes from CLDR via babel rather than from a hand-built "symbol + number" rule
that puts the symbol on the wrong side in half of Europe.

Regenerate when the price changes. The output is committed so that a screenshot
run needs no App Store Connect credentials.
"""
import argparse
import json
import pathlib
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
from submit import call, errs  # noqa: E402  same key, same token handling

IAP = "com.spencerfields.littlebird.unlimited"
HERE = pathlib.Path(__file__).resolve().parent
OUT = HERE / "shot_prices.json"

# The ten shot locales, as (App Store Connect locale, ASC territory, CLDR
# locale). The territory decides the price; the CLDR locale decides how it is
# written, and those are separate questions.
#
# Read this table honestly: **an App Store screenshot locale is a language, not a
# storefront.** The `hi` set is shown to every Hindi-language device, in India but
# equally in the UK or the UAE, where the price differs. So no single figure is
# right for every viewer of a language, and this maps each language to the
# storefront most of its buyers actually buy from. That is a real Apple price for
# most viewers and the wrong one for some; it beats a dollar figure that is wrong
# for all of them, and Apple states the true price on the product page and again
# in the purchase sheet.
#
# bn-BD is mapped to India deliberately. Apple sells no paid content in
# Bangladesh — the API returns no price for BGD at all — so every Bengali-reading
# viewer who *can* buy this is buying from a storefront, and overwhelmingly that
# is IND. Using the Indian price there is a decision, not a fallback.
SHOT_TERRITORIES = [
    ("en-GB", "GBR", "en_GB"),
    ("zh-Hans", "CHN", "zh_Hans_CN"),
    ("hi", "IND", "hi_IN"),
    ("es-ES", "ESP", "es_ES"),
    ("fr-FR", "FRA", "fr_FR"),
    ("ar-SA", "SAU", "ar_SA"),
    ("bn-BD", "IND", "bn_IN"),
    ("pt-BR", "BRA", "pt_BR"),
    ("ru", "RUS", "ru_RU"),
    ("id", "IDN", "id_ID"),
]


def iap_id():
    st, d = call(
        "GET",
        f"apps/6802053382/inAppPurchasesV2?filter[productId]={IAP}&limit=10",
        version="v1",
    )
    if st != 200:
        sys.exit(f"inAppPurchasesV2 -> {st}: {errs(d)}")
    for item in d.get("data", []):
        if item.get("attributes", {}).get("productId") == IAP:
            return item["id"]
    sys.exit(f"no in-app purchase with productId {IAP}")


def schedule_id(iap):
    st, d = call("GET", f"inAppPurchases/{iap}/iapPriceSchedule", version="v2")
    if st != 200:
        sys.exit(f"iapPriceSchedule -> {st}: {errs(d)}")
    sched = (d.get("data") or {}).get("id")
    if not sched:
        sys.exit("the in-app purchase has no price schedule — set a price first")
    return sched


def territory_prices(sched, territories):
    """customerPrice and currency per territory, from Apple's own table."""
    found = {}
    for relationship in ("manualPrices", "automaticPrices"):
        for chunk in _chunks(sorted(territories), 25):
            path = (
                f"inAppPurchasePriceSchedules/{sched}/{relationship}"
                f"?filter[territory]={','.join(chunk)}"
                f"&include=inAppPurchasePricePoint,territory&limit=200"
            )
            st, d = call("GET", path, version="v1")
            if st != 200:
                print(f"  ! {relationship} {','.join(chunk)} -> {st}: {errs(d)}")
                continue
            points, currencies = {}, {}
            for inc in d.get("included", []):
                if inc["type"] == "inAppPurchasePricePoints":
                    points[inc["id"]] = inc["attributes"].get("customerPrice")
                elif inc["type"] == "territories":
                    currencies[inc["id"]] = inc["attributes"].get("currency")
            for row in d.get("data", []):
                rel = row.get("relationships", {})
                pid = (rel.get("inAppPurchasePricePoint", {}).get("data") or {})
                tid = (rel.get("territory", {}).get("data") or {})
                price = points.get(pid.get("id"))
                terr = tid.get("id")
                if terr and price and terr not in found:
                    found[terr] = (price, currencies.get(terr))
    return found


def _chunks(items, n):
    for i in range(0, len(items), n):
        yield items[i:i + n]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--write", action="store_true",
                    help=f"write {OUT.name}")
    args = ap.parse_args()

    try:
        from babel.numbers import format_currency
    except ImportError:
        sys.exit("this needs babel for CLDR formatting: pip install babel")

    # Half of what this prints is outside cp1252, which is the default console
    # encoding on Windows. Printing a rupee sign should not end the run.
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except (AttributeError, OSError):
        pass

    sched = schedule_id(iap_id())
    prices = territory_prices(sched, [t for _, t, _ in SHOT_TERRITORIES])

    out, missing = {}, []
    print(f"{'locale':10} {'territory':10} {'amount':>10}  written as")
    for asc, terr, cldr in SHOT_TERRITORIES:
        got = prices.get(terr)
        if not got:
            missing.append(f"{asc} ({terr})")
            print(f"{asc:10} {terr:10} {'—':>10}  not returned by the API")
            continue
        amount, currency = got
        if not currency:
            missing.append(f"{asc} ({terr}, no currency)")
            continue
        # CLDR decides symbol, placement, separators and digits. Every one of
        # those differs somewhere in this list.
        text = format_currency(float(amount), currency, locale=cldr)
        out[asc] = text
        print(f"{asc:10} {terr:10} {amount:>10}  {text}")

    if missing:
        print(f"\nno price for: {', '.join(missing)}")
        print("Those locales keep the app's own fallback string, which is a "
              "dollar figure — so they should not be shot until this is fixed.")

    if args.write:
        OUT.write_text(
            json.dumps(out, ensure_ascii=False, indent=2, sort_keys=True) + "\n",
            encoding="utf-8")
        print(f"\nwrote {OUT} ({len(out)} locales)")
    return 1 if missing else 0


if __name__ == "__main__":
    sys.exit(main())
