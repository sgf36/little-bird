"""Push Wren's App Store listing from metadata_en_GB.json (plus translations).

Checks Apple's length limits before sending, because App Store Connect rejects
an over-length field with a generic error and no indication of which one.

    python store/push_metadata.py            # primary locale only
    python store/push_metadata.py --all      # every locale with a file
    python store/push_metadata.py --check    # lengths only, sends nothing

Fields that are the same in every language — the two URLs, the app's name —
live in common.json and are merged in, so a URL change is one edit rather than
fifty and the locale files hold only what a translator touched.

Reads the App Manager key from the signing folder. Creates nothing that cannot
be edited afterwards in App Store Connect.
"""
import argparse, json, pathlib, sys, time, urllib.error, urllib.request
import jwt

KEY_ID, ISSUER = "4CU796U485", "65aee88f-46c4-4daf-8238-5dc37263d06b"
KEY = (pathlib.Path(r"C:\Users\SpencerFields\OneDrive - Spencer Fields"
                    r"\Apps\Claude MacOS\signing") / "AuthKey_4CU796U485.p8")
APP = "6802053382"
PRODUCT_ID = "com.spencerfields.littlebird.unlimited"
HERE = pathlib.Path(__file__).resolve().parent

# Apple's caps. Exceeding one is rejected with a generic message.
LIMITS = {
    "name": 30, "subtitle": 30, "promotionalText": 170,
    "keywords": 100, "description": 4000, "whatsNew": 4000,
}

# The in-app purchase has its own, much tighter caps — 45 characters for the
# description, which is a third of what the App Store subtitle allows.
IAP_LIMITS = {"name": 30, "description": 45}

_token = {"value": None, "expires": 0}


def token():
    """Minted on demand and refreshed before it lapses.

    A single token minted at import was enough for one locale and not for
    fifty: Apple caps the lifetime at 20 minutes, a full run takes longer, and
    an expired token comes back as an ordinary empty response rather than an
    error. The symptom was one locale in forty-nine failing with "no editable
    version found" — which reads like missing data, not an expired credential.
    """
    now = int(time.time())
    if _token["value"] is None or now > _token["expires"] - 120:
        # iat is backdated a minute. If this machine's clock runs even a second
        # ahead of Apple's, a token issued "in the future" is rejected — which
        # is what made the first locale of the run fail while the other
        # forty-eight, minted from the same call, went through.
        _token["value"] = jwt.encode(
            {"iss": ISSUER, "iat": now - 60, "exp": now + 1200,
             "aud": "appstoreconnect-v1"},
            KEY.read_text(encoding="utf-8"), algorithm="ES256",
            headers={"kid": KEY_ID, "typ": "JWT"})
        _token["expires"] = now + 1200
    return _token["value"]


def call(method, path, body=None, version="v1", _retry=True):
    req = urllib.request.Request(
        f"https://api.appstoreconnect.apple.com/{version}/{path}",
        method=method,
        headers={"Authorization": f"Bearer {token()}",
                 "Content-Type": "application/json"},
        data=json.dumps(body).encode() if body else None)
    try:
        with urllib.request.urlopen(req, timeout=90) as r:
            raw = r.read()
            return r.status, (json.loads(raw) if raw else {})
    except urllib.error.HTTPError as e:
        raw = e.read().decode("utf-8", "replace")
        # A 401 is worth exactly one retry with a fresh token. Apple returns it
        # for skew and for expiry alike, and neither is a reason to abandon a
        # locale halfway through a fifty-locale run.
        if e.code == 401 and _retry:
            _token["value"] = None
            time.sleep(2)
            return call(method, path, body, version, _retry=False)
        try:
            return e.code, json.loads(raw)
        except ValueError:
            return e.code, {"_raw": raw[:300]}

def errs(payload):
    return "; ".join(f"{x.get('title')}: {x.get('detail')}"
                     for x in payload.get("errors", [])) or str(payload)[:200]

def check_limits(meta):
    """Returns a list of problems, so all of them are reported at once."""
    bad = []
    for field, cap in LIMITS.items():
        value = meta.get(field)
        if value and len(value) > cap:
            bad.append(f"{field} is {len(value)} characters, limit {cap}")
    for field, cap in IAP_LIMITS.items():
        value = (meta.get("inAppPurchase") or {}).get(field)
        if value and len(value) > cap:
            bad.append(
                f"inAppPurchase.{field} is {len(value)} characters, "
                f"limit {cap}")
    return bad


def push_iap(meta, product_id):
    """Localises the in-app purchase, which is a separate resource entirely.

    Skipped rather than failed when the product does not exist yet: the price
    and the review screenshot are set in App Store Connect by hand, and the
    listing should not wait on that.
    """
    iap = meta.get("inAppPurchase")
    if not iap:
        return True
    st, products = call("GET", f"apps/{APP}/inAppPurchasesV2?limit=20")
    product = next((p for p in products.get("data", [])
                    if p["attributes"].get("productId") == product_id), None)
    if not product:
        print(f"  {meta['locale']}: no in-app purchase {product_id} yet")
        return True

    # v2, not v1. The localisations relationship only exists on the v2
    # resource; against v1 it 404s, which reads as "none yet" and turns every
    # re-run into a POST that Apple rejects as a duplicate. The listing looks
    # like it failed when in fact it was already right.
    st, locs = call(
        "GET", f"inAppPurchases/{product['id']}/inAppPurchaseLocalizations"
               "?limit=200", version="v2")
    existing = next((l for l in locs.get("data", [])
                     if l["attributes"].get("locale") == meta["locale"]), None)
    attrs = {"name": iap["name"], "description": iap["description"]}
    if existing:
        st, d = call("PATCH", f"inAppPurchaseLocalizations/{existing['id']}",
                     {"data": {"type": "inAppPurchaseLocalizations",
                               "id": existing["id"], "attributes": attrs}})
    else:
        st, d = call("POST", "inAppPurchaseLocalizations",
                     {"data": {"type": "inAppPurchaseLocalizations",
                               "attributes": {**attrs,
                                              "locale": meta["locale"]},
                               "relationships": {"inAppPurchaseV2": {"data": {
                                   "id": product["id"],
                                   "type": "inAppPurchases"}}}}})
    if st in (200, 201):
        print(f"  {meta['locale']}: purchase set")
        return True
    print(f"  {meta['locale']}: purchase FAILED {st} — {errs(d)}")
    return False

def push(meta):
    locale = meta["locale"]
    problems = check_limits(meta)
    if problems:
        for p in problems:
            print(f"  REFUSED {locale}: {p}")
        return False

    ok = True

    # --- name and subtitle live on appInfoLocalizations -------------------
    st, infos = call("GET", f"apps/{APP}/appInfos")
    # The editable one is whichever is not already on the store.
    editable = next(
        (i for i in infos.get("data", [])
         if i["attributes"].get("appStoreState") in
         (None, "PREPARE_FOR_SUBMISSION", "DEVELOPER_REJECTED",
          "REJECTED", "METADATA_REJECTED")),
        (infos.get("data") or [None])[0])
    if editable:
        st, locs = call(
            "GET", f"appInfos/{editable['id']}/appInfoLocalizations?limit=200")
        existing = next((l for l in locs.get("data", [])
                         if l["attributes"].get("locale") == locale), None)
        attrs = {"name": meta["name"], "subtitle": meta.get("subtitle")}
        if existing:
            st, d = call("PATCH", f"appInfoLocalizations/{existing['id']}",
                         {"data": {"type": "appInfoLocalizations",
                                   "id": existing["id"], "attributes": attrs}})
        else:
            st, d = call("POST", "appInfoLocalizations",
                         {"data": {"type": "appInfoLocalizations",
                                   "attributes": {**attrs, "locale": locale},
                                   "relationships": {"appInfo": {"data": {
                                       "id": editable["id"],
                                       "type": "appInfos"}}}}})
        if st not in (200, 201):
            print(f"  name/subtitle {locale}: FAILED {st} — {errs(d)}")
            ok = False

    # --- description and the rest live on the version ---------------------
    st, vers = call("GET", f"apps/{APP}/appStoreVersions?limit=5")
    version = next(
        (v for v in vers.get("data", [])
         if v["attributes"].get("appStoreState") in
         ("PREPARE_FOR_SUBMISSION", "DEVELOPER_REJECTED", "REJECTED",
          "METADATA_REJECTED", "WAITING_FOR_REVIEW")),
        (vers.get("data") or [None])[0])
    if not version:
        # Says which locale, because "no editable version" is app-wide state
        # and a bare line gives no clue that only one of fifty hit it.
        print(f"  {locale}: no editable version found — {errs(vers)}")
        return False

    st, locs = call(
        "GET", f"appStoreVersions/{version['id']}/appStoreVersionLocalizations"
               "?limit=200")
    existing = next((l for l in locs.get("data", [])
                     if l["attributes"].get("locale") == locale), None)
    attrs = {
        "description": meta["description"],
        "keywords": meta.get("keywords"),
        "promotionalText": meta.get("promotionalText"),
        "supportUrl": meta.get("supportUrl"),
        "marketingUrl": meta.get("marketingUrl"),
        "whatsNew": meta.get("whatsNew"),
    }
    if existing:
        st, d = call("PATCH",
                     f"appStoreVersionLocalizations/{existing['id']}",
                     {"data": {"type": "appStoreVersionLocalizations",
                               "id": existing["id"], "attributes": attrs}})
    else:
        st, d = call("POST", "appStoreVersionLocalizations",
                     {"data": {"type": "appStoreVersionLocalizations",
                               "attributes": {**attrs, "locale": locale},
                               "relationships": {"appStoreVersion": {"data": {
                                   "id": version["id"],
                                   "type": "appStoreVersions"}}}}})
    if st not in (200, 201):
        # whatsNew is rejected on an app that has never been released.
        if "whatsNew" in errs(d) or "WHATS_NEW" in errs(d):
            attrs.pop("whatsNew")
            st, d = call("PATCH" if existing else "POST",
                         f"appStoreVersionLocalizations/{existing['id']}"
                         if existing else "appStoreVersionLocalizations",
                         {"data": {"type": "appStoreVersionLocalizations",
                                   **({"id": existing["id"]} if existing else {}),
                                   "attributes": attrs if existing
                                   else {**attrs, "locale": locale},
                                   **({} if existing else {"relationships": {
                                       "appStoreVersion": {"data": {
                                           "id": version["id"],
                                           "type": "appStoreVersions"}}}})}})
    if st in (200, 201):
        print(f"  {locale}: listing set")
    else:
        print(f"  {locale}: FAILED {st} — {errs(d)}")
        ok = False

    if not push_iap(meta, PRODUCT_ID):
        ok = False
    return ok

def load(path):
    """A locale file merged over the shared fields, with comments dropped."""
    common = {}
    shared = HERE / "common.json"
    if shared.exists():
        common = json.loads(shared.read_text(encoding="utf-8"))
    meta = {**common, **json.loads(path.read_text(encoding="utf-8"))}
    # The locale is the filename, not a field, so the two cannot disagree.
    meta["locale"] = path.stem.removeprefix("metadata_").replace("_", "-")
    return {k: v for k, v in meta.items() if not k.startswith("_")}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--all", action="store_true",
                    help="push every metadata_*.json in this folder")
    ap.add_argument("--check", action="store_true",
                    help="report field lengths and send nothing")
    args = ap.parse_args()

    files = sorted(HERE.glob("metadata_*.json")) if (args.all or args.check) \
        else [HERE / "metadata_en_GB.json"]
    if not files:
        sys.exit("no metadata files found")

    if args.check:
        print(f"checking {len(files)} locale(s)")
        bad = 0
        for f in files:
            meta = load(f)
            missing = [k for k in ("name", "subtitle", "promotionalText",
                                   "description", "keywords")
                       if not meta.get(k)]
            problems = check_limits(meta) + [f"{k} is missing"
                                             for k in missing]
            for p in problems:
                print(f"  {meta['locale']}: {p}")
            bad += bool(problems)
        print(f"\n{len(files) - bad} of {len(files)} are ready to push")
        sys.exit(1 if bad else 0)

    print(f"pushing {len(files)} locale(s)")
    failures = 0
    for f in files:
        if not push(load(f)):
            failures += 1
    print(f"\n{len(files) - failures} of {len(files)} succeeded")
    sys.exit(1 if failures else 0)

if __name__ == "__main__":
    main()
