"""Get the newest build to a TestFlight tester.

    python store/testflight.py                          # report only, changes nothing
    python store/testflight.py --distribute              # attach the newest build
    python store/testflight.py --distribute --tester a@b # and ensure that tester

Uploading a build is not the same as distributing one. Build 46 sat in
`READY_FOR_BETA_TESTING` with no group attached and simply never appeared on the
phone; attaching it to a group flipped it to `IN_BETA_TESTING` and it arrived.
So this script exists to do the second half, and to say plainly which half is
missing when a build does not turn up.

Reports before it changes anything, because the useful question is almost always
"why has this not arrived" rather than "please do something".
"""
import argparse
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
        # iat backdated 60s AND exp pulled back to match: Apple caps the
        # lifetime at 20 minutes measured as exp - iat, so now+1200 with a
        # backdated iat is 1260 and over the cap. That produced intermittent
        # 401s that looked like Apple being flaky.
        _tok["v"] = jwt.encode(
            {"iss": ISSUER, "iat": now - 60, "exp": now + 1140,
             "aud": "appstoreconnect-v1"},
            KEY.read_text(), algorithm="ES256",
            headers={"kid": KEY_ID, "typ": "JWT"})
        _tok["exp"] = now + 1140
    return _tok["v"]


def call(method, path, body=None, _left=3):
    req = urllib.request.Request(
        f"https://api.appstoreconnect.apple.com/v1/{path}", method=method,
        headers={"Authorization": f"Bearer {token()}",
                 "Content-Type": "application/json"},
        data=json.dumps(body).encode() if body else None)
    try:
        with urllib.request.urlopen(req, timeout=90) as r:
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


def errs(d):
    return "; ".join(f"{x.get('title')}: {x.get('detail')}"
                     for x in d.get("errors", []))[:400] or str(d)[:200]


def newest_build():
    st, d = call("GET", f"builds?filter[app]={APP}&limit=5"
                        "&sort=-version&fields[builds]="
                        "version,processingState,expired,usesNonExemptEncryption")
    builds = d.get("data")
    if not builds:
        sys.exit(f"could not list builds -> {st}: {errs(d)}")
    return builds[0], builds


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--distribute", action="store_true",
                    help="actually attach the build and add the tester")
    ap.add_argument("--tester", action="append", default=[],
                    help="email to ensure is a tester; repeatable")
    ap.add_argument("--wait", type=int, default=0,
                    help="minutes to wait for processing before giving up")
    args = ap.parse_args()

    build, recent = newest_build()
    print("recent builds:")
    for b in recent:
        a = b["attributes"]
        print(f"  {a['version']:>4}  {a['processingState']:<10} "
              f"expired={a['expired']}  encryption={a['usesNonExemptEncryption']}")

    bid, attrs = build["id"], build["attributes"]
    version = attrs["version"]

    # Processing can take several minutes and a build cannot be attached to a
    # group until it is VALID.
    deadline = time.time() + args.wait * 60
    while attrs["processingState"] == "PROCESSING" and time.time() < deadline:
        print(f"  build {version} still PROCESSING, waiting…")
        time.sleep(60)
        build, _ = newest_build()
        bid, attrs = build["id"], build["attributes"]
    if attrs["processingState"] != "VALID":
        print(f"\nbuild {version} is {attrs['processingState']}, not VALID. "
              f"It cannot be distributed yet"
              + (" — re-run with --wait 15." if not args.wait else "."))
        if attrs["processingState"] != "PROCESSING":
            sys.exit(1)
        return

    # Without this a build is stuck MISSING_EXPORT_COMPLIANCE and will not
    # install, with nothing on the build itself to say why.
    if attrs["usesNonExemptEncryption"] is None:
        print(f"\nbuild {version}: export compliance unanswered")
        if args.distribute:
            st, d = call("PATCH", f"builds/{bid}", {
                "data": {"type": "builds", "id": bid,
                         "attributes": {"usesNonExemptEncryption": False}}})
            print("  answered" if st == 200 else f"  FAILED {st}: {errs(d)}")

    st, d = call("GET", f"apps/{APP}/betaGroups"
                        "?fields[betaGroups]=name,isInternalGroup,publicLinkEnabled")
    groups = d.get("data", [])
    if not groups:
        sys.exit(f"no beta groups on this app -> {st}: {errs(d)}. Create one in "
                 f"App Store Connect; a build with no group never leaves the "
                 f"portal.")

    print("\nbeta groups:")
    for g in groups:
        ga = g["attributes"]
        st, t = call("GET", f"betaGroups/{g['id']}/betaTesters"
                            "?limit=50&fields[betaTesters]=email,state")
        testers = t.get("data", [])
        kind = "internal" if ga["isInternalGroup"] else "external"
        print(f"  {ga['name']!r} ({kind}) — {len(testers)} testers")
        for x in testers:
            print(f"      {x['attributes']['email']} "
                  f"({x['attributes'].get('state')})")
        g["_testers"] = testers

        st, bs = call("GET", f"betaGroups/{g['id']}/builds"
                             "?limit=10&fields[builds]=version")
        have = [b["attributes"]["version"] for b in bs.get("data", [])]
        print(f"      builds: {', '.join(have) if have else '(none)'}")
        g["_builds"] = have

    # Internal groups get builds immediately. External ones need Beta App
    # Review first, so for "put this on my phone now" internal is the only
    # answer, and saying which is which matters.
    internal = [g for g in groups if g["attributes"]["isInternalGroup"]]
    target = internal[0] if internal else groups[0]

    if not args.distribute:
        print(f"\nreport only. To distribute build {version} to "
              f"{target['attributes']['name']!r}:")
        print(f"  python store/testflight.py --distribute"
              + "".join(f" --tester {t}" for t in args.tester))
        return

    for email in args.tester:
        if any(x["attributes"]["email"].lower() == email.lower()
               for g in groups for x in g["_testers"]):
            print(f"\n{email}: already a tester")
            continue
        print(f"\n{email}: adding to {target['attributes']['name']!r}")
        st, d = call("POST", "betaTesters", {
            "data": {"type": "betaTesters",
                     "attributes": {"email": email},
                     "relationships": {"betaGroups": {"data": [
                         {"type": "betaGroups", "id": target["id"]}]}}}})
        if st == 201:
            print("  added")
        else:
            # An internal group only accepts App Store Connect users. If this
            # refuses, the address needs a Users and Access invitation first —
            # which is a different job and worth saying rather than retrying.
            print(f"  FAILED {st}: {errs(d)}")

    if version in target.get("_builds", []):
        print(f"\nbuild {version} is already in "
              f"{target['attributes']['name']!r}")
    else:
        st, d = call("POST", f"betaGroups/{target['id']}/relationships/builds",
                     {"data": [{"type": "builds", "id": bid}]})
        print(f"\nattaching build {version} to "
              f"{target['attributes']['name']!r}: "
              + ("done" if st in (201, 204) else f"FAILED {st}: {errs(d)}"))

    st, d = call("GET", f"builds/{bid}?fields[builds]=version,processingState")
    print("\nnow:", json.dumps(d.get("data", {}).get("attributes", {})))


if __name__ == "__main__":
    main()
