"""Attach the build, fill in the review detail, and submit Wren for review.

    python store/submit.py --dry-run     # say what it would do
    python store/submit.py               # do it

Deliberately idempotent and ordered so that a failure leaves the version in a
sane state: everything that can be prepared is prepared before anything is
submitted, and the submission itself is last.
"""
import argparse
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

# Same contact as the Easy-Post submissions, read from those records rather
# than invented. A wrong phone number on a review detail is how a rejection
# becomes unanswerable.
CONTACT = {
    "contactFirstName": "Spencer",
    "contactLastName": "Fields",
    "contactEmail": "Apps@spencerfields.com",
    "contactPhone": "+44 20 8132 5790",
    "demoAccountRequired": False,
}

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
                     for x in d.get("errors", []))[:400] or str(d)[:250]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()
    say = (lambda *a: print("would:", *a)) if args.dry_run else print

    notes = json.loads((HERE / "metadata_en_GB.json")
                       .read_text(encoding="utf-8"))["reviewNotes"]

    st, vers = call("GET", f"apps/{APP}/appStoreVersions?limit=1")
    if "data" not in vers:
        sys.exit(f"appStoreVersions -> {st}: {errs(vers)}")
    ver = vers["data"][0]
    vid = ver["id"]
    print(f"version {ver['attributes']['versionString']} "
          f"({ver['attributes']['appStoreState']})")

    # --- 1. content rights -------------------------------------------
    st, app = call("GET", f"apps/{APP}")
    if app["data"]["attributes"].get("contentRightsDeclaration") is None:
        if args.dry_run:
            say("declare no third-party content")
        else:
            st, d = call("PATCH", f"apps/{APP}", {
                "data": {"type": "apps", "id": APP, "attributes": {
                    "contentRightsDeclaration":
                        "DOES_NOT_USE_THIRD_PARTY_CONTENT"}}})
            print(f"content rights -> {st}"
                  + ("" if st == 200 else f"  {errs(d)}"))
    else:
        print("content rights already declared")

    # --- 2. attach the newest build ----------------------------------
    st, builds = call("GET", f"builds?filter[app]={APP}"
                             "&limit=1&sort=-uploadedDate")
    build = builds["data"][0]
    bver = build["attributes"]["version"]
    st, cur = call("GET", f"appStoreVersions/{vid}/build")
    attached = (cur.get("data") or {}).get("id")
    if attached == build["id"]:
        print(f"build {bver} already attached")
    elif args.dry_run:
        say(f"attach build {bver}")
    else:
        st, d = call("PATCH", f"appStoreVersions/{vid}/relationships/build", {
            "data": {"type": "builds", "id": build["id"]}})
        print(f"attach build {bver} -> {st}"
              + ("" if st in (204, 200) else f"  {errs(d)}"))

    # --- 3. review detail --------------------------------------------
    st, rd = call("GET", f"appStoreVersions/{vid}/appStoreReviewDetail")
    body_attrs = {**CONTACT, "notes": notes}
    if st == 200 and rd.get("data"):
        rid = rd["data"]["id"]
        if args.dry_run:
            say("update the review detail")
        else:
            st, d = call("PATCH", f"appStoreReviewDetails/{rid}", {
                "data": {"type": "appStoreReviewDetails", "id": rid,
                         "attributes": body_attrs}})
            print(f"review detail updated -> {st}"
                  + ("" if st == 200 else f"  {errs(d)}"))
    elif args.dry_run:
        say("create the review detail")
    else:
        st, d = call("POST", "appStoreReviewDetails", {
            "data": {"type": "appStoreReviewDetails",
                     "attributes": body_attrs,
                     "relationships": {"appStoreVersion": {"data": {
                         "type": "appStoreVersions", "id": vid}}}}})
        print(f"review detail created -> {st}"
              + ("" if st == 201 else f"  {errs(d)}"))

    # --- 4. submit ----------------------------------------------------
    # The version and the purchase are separate items in one submission.
    st, iaps = call("GET", f"apps/{APP}/inAppPurchasesV2?limit=5")
    iap = iaps["data"][0]

    if args.dry_run:
        say(f"submit version {vid} and purchase "
            f"{iap['attributes']['productId']}")
        return

    st, subs = call("GET", f"reviewSubmissions?filter[app]={APP}"
                           "&filter[state]=READY_FOR_REVIEW,WAITING_FOR_REVIEW"
                           ",IN_REVIEW&limit=5")
    open_subs = subs.get("data", [])
    if open_subs:
        sub_id = open_subs[0]["id"]
        print(f"reusing open submission {sub_id}")
    else:
        st, d = call("POST", "reviewSubmissions", {
            "data": {"type": "reviewSubmissions",
                     "attributes": {"platform": "IOS"},
                     "relationships": {"app": {"data": {
                         "type": "apps", "id": APP}}}}})
        if st != 201:
            sys.exit(f"could not create a submission: {st} {errs(d)}")
        sub_id = d["data"]["id"]
        print(f"created submission {sub_id}")

    for kind, ident, label in (
            ("appStoreVersion", vid, "the version"),
            ("inAppPurchaseV2", iap["id"],
             iap["attributes"]["productId"])):
        st, d = call("POST", "reviewSubmissionItems", {
            "data": {"type": "reviewSubmissionItems",
                     "relationships": {
                         "reviewSubmission": {"data": {
                             "type": "reviewSubmissions", "id": sub_id}},
                         kind: {"data": {
                             "type": ("appStoreVersions"
                                      if kind == "appStoreVersion"
                                      else "inAppPurchases"),
                             "id": ident}}}}})
        print(f"add {label} -> {st}"
              + ("" if st == 201 else f"  {errs(d)}"))

    st, d = call("PATCH", f"reviewSubmissions/{sub_id}", {
        "data": {"type": "reviewSubmissions", "id": sub_id,
                 "attributes": {"submitted": True}}})
    print(f"\nSUBMIT -> {st}" + ("" if st == 200 else f"  {errs(d)}"))
    if st == 200:
        print(f"state: {d['data']['attributes'].get('state')}")


if __name__ == "__main__":
    main()
