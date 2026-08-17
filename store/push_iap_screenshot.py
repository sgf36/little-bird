"""Upload the in-app purchase's App Review screenshot.

    python store/push_iap_screenshot.py

Separate from the app's screenshots: a different resource, a different upload,
and the thing keeping the purchase at MISSING_METADATA. Review needs one image
showing what the customer actually sees before paying.

Same three-step dance as appScreenshots, and the same trap: the PUT must not
carry the API token, and the commit needs an MD5.
"""
import hashlib
import json
import pathlib
import sys
import time
import urllib.error
import urllib.request

import jwt

KEY_ID, ISSUER = "4CU796U485", "65aee88f-46c4-4daf-8238-5dc37263d06b"
KEY = (pathlib.Path(r"C:\Users\SpencerFields\OneDrive - Spencer Fields"
                    r"\Apps\Claude MacOS\signing") / "AuthKey_4CU796U485.p8")
APP = "6802053382"
HERE = pathlib.Path(__file__).resolve().parent
SHOT = HERE / "screenshots" / "IAP" / "guides-of-any-size.png"

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


def call(method, path, body=None, version="v1", _left=3):
    req = urllib.request.Request(
        f"https://api.appstoreconnect.apple.com/{version}/{path}",
        method=method,
        headers={"Authorization": f"Bearer {token()}",
                 "Content-Type": "application/json"},
        data=json.dumps(body).encode() if body else None)
    try:
        with urllib.request.urlopen(req, timeout=120) as r:
            raw = r.read()
            return r.status, (json.loads(raw) if raw else {})
    except urllib.error.HTTPError as e:
        raw = e.read().decode("utf-8", "replace")
        if e.code == 401 and _left > 1:
            _tok["v"] = None
            time.sleep(4)
            return call(method, path, body, version, _left - 1)
        try:
            return e.code, json.loads(raw)
        except ValueError:
            return e.code, {"_raw": raw[:400]}


def errs(d):
    return "; ".join(f"{x.get('title')}: {x.get('detail')}"
                     for x in d.get("errors", []))[:300] or str(d)[:200]


if not SHOT.exists():
    sys.exit(f"missing {SHOT}")

st, iaps = call("GET", f"apps/{APP}/inAppPurchasesV2?limit=5")
if "data" not in iaps:
    sys.exit(f"inAppPurchases -> {st}: {errs(iaps)}")
iap = iaps["data"][0]
print(f"purchase {iap['attributes']['productId']} "
      f"({iap['attributes']['state']})")

# Replace any existing one rather than stacking a second.
st, cur = call("GET", f"inAppPurchases/{iap['id']}/appStoreReviewScreenshot",
               version="v2")
if st == 200 and cur.get("data"):
    call("DELETE", f"inAppPurchaseAppStoreReviewScreenshots/"
                   f"{cur['data']['id']}")
    print("removed the existing screenshot")

data = SHOT.read_bytes()
st, d = call("POST", "inAppPurchaseAppStoreReviewScreenshots", {
    "data": {"type": "inAppPurchaseAppStoreReviewScreenshots",
             "attributes": {"fileName": SHOT.name, "fileSize": len(data)},
             "relationships": {"inAppPurchaseV2": {"data": {
                 "type": "inAppPurchases", "id": iap["id"]}}}}})
if st != 201:
    sys.exit(f"reserve failed {st}: {errs(d)}")
shot_id = d["data"]["id"]

for op in d["data"]["attributes"]["uploadOperations"]:
    chunk = data[op["offset"]:op["offset"] + op["length"]]
    req = urllib.request.Request(op["url"], method=op["method"], data=chunk)
    for h in op["requestHeaders"]:
        req.add_header(h["name"], h["value"])
    urllib.request.urlopen(req, timeout=300).read()

st, d = call("PATCH", f"inAppPurchaseAppStoreReviewScreenshots/{shot_id}", {
    "data": {"type": "inAppPurchaseAppStoreReviewScreenshots", "id": shot_id,
             "attributes": {"uploaded": True,
                            "sourceFileChecksum":
                                hashlib.md5(data).hexdigest()}}})
if st != 200:
    sys.exit(f"commit failed {st}: {errs(d)}")

for _ in range(40):
    st, d = call("GET", f"inAppPurchaseAppStoreReviewScreenshots/{shot_id}")
    state = (d.get("data", {}).get("attributes", {})
             .get("assetDeliveryState") or {})
    if state.get("state") == "COMPLETE":
        print("screenshot COMPLETE")
        break
    if state.get("errors"):
        sys.exit(f"rejected: {json.dumps(state['errors'])[:300]}")
    time.sleep(3)
else:
    sys.exit("never reached COMPLETE")

st, iaps = call("GET", f"apps/{APP}/inAppPurchasesV2?limit=5")
print(f"purchase state now: {iaps['data'][0]['attributes']['state']}")
