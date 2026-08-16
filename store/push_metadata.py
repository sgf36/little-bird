"""Push Wren's App Store listing from metadata_en_GB.json (plus translations).

Checks Apple's length limits before sending, because App Store Connect rejects
an over-length field with a generic error and no indication of which one.

    python store/push_metadata.py            # primary locale only
    python store/push_metadata.py --all      # every locale with a file

Reads the App Manager key from the signing folder. Creates nothing that cannot
be edited afterwards in App Store Connect.
"""
import argparse, json, pathlib, sys, time, urllib.error, urllib.request
import jwt

KEY_ID, ISSUER = "4CU796U485", "65aee88f-46c4-4daf-8238-5dc37263d06b"
KEY = (pathlib.Path(r"C:\Users\SpencerFields\OneDrive - Spencer Fields"
                    r"\Apps\Claude MacOS\signing") / "AuthKey_4CU796U485.p8")
APP = "6802053382"
HERE = pathlib.Path(__file__).resolve().parent

# Apple's caps. Exceeding one is rejected with a generic message.
LIMITS = {
    "name": 30, "subtitle": 30, "promotionalText": 170,
    "keywords": 100, "description": 4000, "whatsNew": 4000,
}

def token():
    now = int(time.time())
    return jwt.encode({"iss": ISSUER, "iat": now, "exp": now + 1200,
                       "aud": "appstoreconnect-v1"},
                      KEY.read_text(encoding="utf-8"), algorithm="ES256",
                      headers={"kid": KEY_ID, "typ": "JWT"})

TOKEN = token()

def call(method, path, body=None):
    req = urllib.request.Request(
        f"https://api.appstoreconnect.apple.com/v1/{path}", method=method,
        headers={"Authorization": f"Bearer {TOKEN}",
                 "Content-Type": "application/json"},
        data=json.dumps(body).encode() if body else None)
    try:
        with urllib.request.urlopen(req, timeout=90) as r:
            raw = r.read()
            return r.status, (json.loads(raw) if raw else {})
    except urllib.error.HTTPError as e:
        raw = e.read().decode("utf-8", "replace")
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
    return bad

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
        print("  no editable version found")
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
    return ok

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--all", action="store_true",
                    help="push every metadata_*.json in this folder")
    args = ap.parse_args()

    files = sorted(HERE.glob("metadata_*.json")) if args.all \
        else [HERE / "metadata_en_GB.json"]
    if not files:
        sys.exit("no metadata files found")

    print(f"pushing {len(files)} locale(s)")
    failures = 0
    for f in files:
        meta = json.loads(f.read_text(encoding="utf-8"))
        if not push(meta):
            failures += 1
    print(f"\n{len(files) - failures} of {len(files)} succeeded")
    sys.exit(1 if failures else 0)

if __name__ == "__main__":
    main()
