"""Upload App Store screenshots.

    python store/push_screenshots.py --check          # sizes only, uploads nothing
    python store/push_screenshots.py --locale en-GB   # one locale
    python store/push_screenshots.py --all            # every locale with a set

Screenshots live in store/screenshots/<slot>/NN-name.png and are uploaded in
filename order, which is the order they appear on the product page.

The upload is three steps and the middle one must NOT carry the API token:
reserve with POST /appScreenshots, PUT each chunk with only the headers Apple's
uploadOperations name, then PATCH uploaded=true with an **MD5** checksum. Poll
assetDeliveryState until COMPLETE — an asset left at UPLOAD_COMPLETE fails
submission later with no obvious cause, which is a miserable thing to debug
weeks after the fact.
"""
import argparse
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
SHOTS = HERE / "screenshots"

# The API's enum, which is not the same as the sizes App Store Connect shows in
# the browser. APP_IPHONE_69 does not exist here — 6.7-inch is the largest
# iPhone slot the API knows about, and it carries the tallest images.
SLOT = "APP_IPHONE_67"

_tok = {"v": None, "exp": 0}


def token():
    now = int(time.time())
    if not _tok["v"] or now > _tok["exp"] - 120:
        # exp is 1140, not 1200. Apple caps the token's lifetime at 20
        # minutes and measures it as exp - iat, so backdating iat by 60 to
        # dodge clock skew also has to pull exp back by 60. Getting this wrong
        # produced intermittent 401s that looked like Apple being flaky.
        _tok["v"] = jwt.encode(
            {"iss": ISSUER, "iat": now - 60, "exp": now + 1140,
             "aud": "appstoreconnect-v1"},
            KEY.read_text(), algorithm="ES256",
            headers={"kid": KEY_ID, "typ": "JWT"})
        _tok["exp"] = now + 1140
    return _tok["v"]


def call(method, path, body=None, _left=3):
    """A 401 buys a fresh token and another go, up to three times.

    Apple rejects the occasional request from a perfectly good key, and it is
    not clock skew — measured against Apple's own Date header this machine is
    two seconds out, well inside tolerance. One retry was not always enough,
    and the failure surfaces as a response with no `data`, which reads as
    missing records rather than as an auth problem.
    """
    req = urllib.request.Request(
        f"https://api.appstoreconnect.apple.com/v1/{path}", method=method,
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
            return call(method, path, body, _left - 1)
        try:
            return e.code, json.loads(raw)
        except ValueError:
            return e.code, {"_raw": raw[:400]}


def expect(status, payload, what):
    """Fail loudly and specifically instead of raising KeyError on ['data']."""
    if "data" not in payload:
        sys.exit(f"{what} -> {status}: {errs(payload)}")
    return payload["data"]


def errs(d):
    return "; ".join(f"{x.get('title')}: {x.get('detail')}"
                     for x in d.get("errors", []))[:300] or str(d)[:200]


def png_size(path):
    """Width and height straight out of the IHDR, no image library needed."""
    with path.open("rb") as f:
        head = f.read(24)
    if head[:8] != b"\x89PNG\r\n\x1a\n":
        return None
    return (int.from_bytes(head[16:20], "big"),
            int.from_bytes(head[20:24], "big"))


def upload_one(set_id, path):
    """Reserve, PUT the bytes, commit, and wait for Apple to accept them."""
    data = path.read_bytes()
    st, d = call("POST", "appScreenshots", {
        "data": {"type": "appScreenshots",
                 "attributes": {"fileName": path.name,
                                "fileSize": len(data)},
                 "relationships": {"appScreenshotSet": {"data": {
                     "type": "appScreenshotSets", "id": set_id}}}}})
    if st != 201:
        return False, f"reserve failed {st}: {errs(d)}"
    shot = d["data"]
    shot_id = shot["id"]

    for op in shot["attributes"]["uploadOperations"]:
        chunk = data[op["offset"]:op["offset"] + op["length"]]
        req = urllib.request.Request(op["url"], method=op["method"],
                                     data=chunk)
        # Only the headers Apple names. An Authorization header here is
        # rejected by the storage endpoint.
        for h in op["requestHeaders"]:
            req.add_header(h["name"], h["value"])
        try:
            urllib.request.urlopen(req, timeout=300).read()
        except urllib.error.HTTPError as e:
            return False, f"chunk PUT failed {e.code}"

    st, d = call("PATCH", f"appScreenshots/{shot_id}", {
        "data": {"type": "appScreenshots", "id": shot_id,
                 "attributes": {"uploaded": True,
                                "sourceFileChecksum":
                                    hashlib.md5(data).hexdigest()}}})
    if st != 200:
        return False, f"commit failed {st}: {errs(d)}"

    for _ in range(40):
        st, d = call("GET", f"appScreenshots/{shot_id}")
        state = (d.get("data", {}).get("attributes", {})
                 .get("assetDeliveryState") or {})
        if state.get("state") == "COMPLETE":
            return True, "COMPLETE"
        if state.get("errors"):
            return False, json.dumps(state["errors"])[:300]
        time.sleep(3)
    return False, "still not COMPLETE after two minutes"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--locale", default="en-GB")
    ap.add_argument("--all", action="store_true")
    ap.add_argument("--check", action="store_true")
    ap.add_argument("--limit", type=int, default=0,
                    help="upload only the first N, for a trial run")
    args = ap.parse_args()

    files = sorted((SHOTS / SLOT).glob("*.png"))
    if not files:
        sys.exit(f"no screenshots in {SHOTS / SLOT}")

    print(f"{len(files)} screenshots in {SLOT}:")
    for f in files:
        print(f"  {f.name:<34} {png_size(f)}  {f.stat().st_size / 1024:,.0f} KB")
    if args.check:
        return

    if args.limit:
        files = files[:args.limit]

    st, vers = call("GET", f"apps/{APP}/appStoreVersions?limit=1")
    vid = expect(st, vers, "appStoreVersions")[0]["id"]
    st, locs = call("GET", f"appStoreVersions/{vid}"
                           "/appStoreVersionLocalizations?limit=200")
    every = expect(st, locs, "appStoreVersionLocalizations")
    wanted = (every if args.all else
              [l for l in every
               if l["attributes"]["locale"] == args.locale])
    if not wanted:
        sys.exit(f"locale {args.locale} not found on this version")

    failures = 0
    for loc in wanted:
        code = loc["attributes"]["locale"]
        st, sets = call("GET", f"appStoreVersionLocalizations/{loc['id']}"
                               "/appScreenshotSets")
        existing = next((s for s in sets.get("data", [])
                         if s["attributes"]["screenshotDisplayType"] == SLOT),
                        None)
        if existing:
            set_id = existing["id"]
            st, shots = call("GET", f"appScreenshotSets/{set_id}"
                                    "/appScreenshots")
            for s in shots.get("data", []):
                call("DELETE", f"appScreenshots/{s['id']}")
        else:
            st, d = call("POST", "appScreenshotSets", {
                "data": {"type": "appScreenshotSets",
                         "attributes": {"screenshotDisplayType": SLOT},
                         "relationships": {
                             "appStoreVersionLocalization": {"data": {
                                 "type": "appStoreVersionLocalizations",
                                 "id": loc["id"]}}}}})
            if st != 201:
                print(f"{code}: could not create set — {errs(d)}")
                failures += 1
                continue
            set_id = d["data"]["id"]

        for f in files:
            ok, why = upload_one(set_id, f)
            print(f"  {code} {f.name:<34} {'ok' if ok else 'FAILED — ' + why}")
            if not ok:
                failures += 1

    print(f"\n{'some uploads failed' if failures else 'all uploads complete'}")
    sys.exit(1 if failures else 0)


if __name__ == "__main__":
    main()
