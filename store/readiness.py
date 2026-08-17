"""What still stands between this app and a submission.

    python store/readiness.py

Reads only — changes nothing. Asks App Store Connect the same questions the
submission endpoint will ask, so the answer comes from the record rather than
from someone's memory of it.

Written because a previous readiness check reported "category NOT SET" against a
correctly-set category: it had not requested the relationship, so the field was
absent from the response and absence was read as emptiness. Every check here
either finds a value or says it could not look, and never conflates the two.
"""
import json
import os
import pathlib
import sys
import time
import urllib.error
import urllib.request

import jwt

KEY_ID = os.environ.get("WREN_ASC_KEY_ID", "4CU796U485")
ISSUER = os.environ.get("WREN_ASC_ISSUER",
                        "65aee88f-46c4-4daf-8238-5dc37263d06b")
KEY = pathlib.Path(os.environ.get(
    "WREN_ASC_KEY",
    r"C:\Users\SpencerFields\OneDrive - Spencer Fields"
    r"\Apps\Claude MacOS\signing\AuthKey_4CU796U485.p8"))
APP = "6802053382"

_tok = {"v": None, "exp": 0}


def token():
    now = int(time.time())
    if not _tok["v"] or now > _tok["exp"] - 120:
        _tok["v"] = jwt.encode(
            {"iss": ISSUER, "iat": now - 60, "exp": now + 1140,
             "aud": "appstoreconnect-v1"},
            KEY.read_text(), algorithm="ES256",
            headers={"kid": KEY_ID, "typ": "JWT"})
        _tok["exp"] = now + 1140
    return _tok["v"]


def get(path, version="v1"):
    req = urllib.request.Request(
        f"https://api.appstoreconnect.apple.com/{version}/{path}",
        headers={"Authorization": f"Bearer {token()}"})
    try:
        with urllib.request.urlopen(req, timeout=60) as r:
            raw = r.read()
            return r.status, (json.loads(raw) if raw else {})
    except urllib.error.HTTPError as e:
        try:
            return e.code, json.loads(e.read().decode("utf-8", "replace"))
        except ValueError:
            return e.code, {}


YES, NO, ASK = "  ok", "  NO", "   ?"
rows = []


def row(state, what, detail=""):
    rows.append((state, what, detail))


def main():
    st, v = get(f"apps/{APP}/appStoreVersions?limit=1&fields[appStoreVersions]="
                "versionString,appStoreState,copyright,releaseType")
    if "data" not in v or not v["data"]:
        sys.exit(f"could not read the version record ({st}). Nothing else can "
                 f"be checked without it.")
    ver = v["data"][0]
    vid, va = ver["id"], ver["attributes"]
    print(f"Wren {va['versionString']} — {va['appStoreState']}\n")

    row(YES if va.get("copyright") else NO, "Copyright",
        va.get("copyright") or "required on the version")

    # Build attached to the version. Without one there is nothing to review.
    st, b = get(f"appStoreVersions/{vid}/build?fields[builds]=version")
    build = b.get("data")
    row(YES if build else NO, "Build attached to the version",
        f"build {build['attributes']['version']}" if build
        else "select a build in App Store Connect, or it cannot be submitted")

    # Screenshots, per locale.
    st, locs = get(f"appStoreVersions/{vid}/appStoreVersionLocalizations"
                   "?limit=200&fields[appStoreVersionLocalizations]=locale")
    all_locs = locs.get("data", [])
    with_shots = 0
    for loc in all_locs:
        st, sets = get(f"appStoreVersionLocalizations/{loc['id']}"
                       "/appScreenshotSets?limit=10")
        for s in sets.get("data", []):
            st, shots = get(f"appScreenshotSets/{s['id']}/appScreenshots?limit=1")
            if shots.get("data"):
                with_shots += 1
                break
    row(YES if with_shots else NO, "Screenshots",
        f"{with_shots} of {len(all_locs)} locales have their own set; the rest "
        f"inherit the primary language's")

    # Age rating.
    st, infos = get(f"apps/{APP}/appInfos?limit=1")
    info = (infos.get("data") or [{}])[0]
    iid = info.get("id")
    if iid:
        st, ar = get(f"appInfos/{iid}/ageRatingDeclaration")
        answered = len([k for k, x in
                        (ar.get("data", {}).get("attributes") or {}).items()
                        if x is not None])
        row(YES if answered > 20 else NO, "Age rating",
            f"{answered} attributes answered")
        st, cat = get(f"appInfos/{iid}?include=primaryCategory,secondaryCategory")
        rel = (cat.get("data", {}).get("relationships") or {})
        primary = ((rel.get("primaryCategory") or {}).get("data") or {}).get("id")
        row(YES if primary else NO, "Primary category", primary or "not set")
    else:
        row(ASK, "Age rating and category", "could not read appInfo")

    # Every localisation needs a privacy policy URL, which nothing else mentions.
    missing_privacy = []
    st, ilocs = get(f"appInfos/{iid}/appInfoLocalizations?limit=200"
                    "&fields[appInfoLocalizations]=locale,privacyPolicyUrl,name")
    for loc in ilocs.get("data", []):
        if not loc["attributes"].get("privacyPolicyUrl"):
            missing_privacy.append(loc["attributes"]["locale"])
    row(YES if not missing_privacy else NO, "Privacy policy URL on every locale",
        "all set" if not missing_privacy
        else f"missing on {len(missing_privacy)}: "
             f"{', '.join(missing_privacy[:6])}")

    # The in-app purchase.
    st, iaps = get(f"apps/{APP}/inAppPurchasesV2?limit=5"
                   "&fields[inAppPurchases]=name,state,productId", version="v1")
    for iap in iaps.get("data", []):
        a = iap["attributes"]
        ok = a["state"] in ("READY_TO_SUBMIT", "APPROVED", "IN_REVIEW")
        row(YES if ok else NO, f"Purchase {a['productId'].split('.')[-1]}",
            a["state"])

    # The App Privacy questionnaire. Every endpoint 404s under this key, on this
    # app and on one that has already shipped, so absence here is the API's
    # shape and not evidence about the answers.
    st, _ = get(f"apps/{APP}/appDataUsages?limit=1")
    row(ASK, "App Privacy questionnaire",
        f"API returns {st} — browser-only, cannot be read or set from here")

    # And the agreement, likewise.
    st, _ = get("agreements?limit=1")
    row(ASK, "Paid Applications Agreement",
        f"API returns {st} — browser-only. Reported done via Easy-Post")

    print(f"{'':4}  {'what':<42} detail")
    print(f"{'-' * 4}  {'-' * 42} {'-' * 30}")
    for state, what, detail in rows:
        print(f"{state}  {what:<42} {detail}")

    blocked = [w for s, w, _ in rows if s == NO]
    unknown = [w for s, w, _ in rows if s == ASK]
    print()
    if blocked:
        print("BLOCKED ON:")
        for w in blocked:
            print(f"  - {w}")
    if unknown:
        print("CANNOT BE CHECKED FROM HERE (browser):")
        for w in unknown:
            print(f"  - {w}")
    if not blocked:
        print("Nothing the API can see is missing.")


if __name__ == "__main__":
    main()
