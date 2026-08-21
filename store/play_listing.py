# -*- coding: utf-8 -*-
"""Fill Wren's Google Play store listing: text, contact details and screenshots.

    python store/play_listing.py --plan
    python store/play_listing.py --apply

Only what the API can set. The App content declarations — content rating, data
safety, target audience, ads, the privacy policy URL — have **no endpoint** in
androidpublisher v3 and stay in the Console. `store/play/LISTING.md` §10 holds
the answers to give them.

The text is not written here. It is read out of LISTING.md, which is the drafted
listing and the thing a person reviews; keeping a second copy in this file is
how the two come to disagree.

Credentials are the same service account Easy-Post uses — one Play account, one
key, and it already has access to this app. See that repo's PLAY-SETUP.md.
"""
import argparse
import json
import os
import re
import sys
import time

import requests

PACKAGE = "com.spencerfields.littlebird"
BASE = "https://androidpublisher.googleapis.com/androidpublisher/v3"
UPLOAD = "https://androidpublisher.googleapis.com/upload/androidpublisher/v3"
LANGUAGE = "en-GB"

CONTACT_EMAIL = "Apps@spencerfields.com"
CONTACT_WEBSITE = "https://wren.spencerfields.com/"

LIMITS = {"title": 30, "shortDescription": 80, "fullDescription": 4000}

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LISTING_MD = os.path.join(REPO, "store", "play", "LISTING.md")
SHOTS_DIR = os.path.join(REPO, "store", "play", "screenshots", "en-GB")


def key_path() -> str:
    base = os.environ.get("LOCALAPPDATA") or os.path.expanduser("~/.config")
    return os.path.join(base, "easypost", "play-ci.json")


def credentials() -> dict:
    raw = os.environ.get("PLAY_SERVICE_ACCOUNT_JSON", "").strip()
    if not raw and os.path.exists(key_path()):
        raw = open(key_path(), encoding="utf-8").read()
    if not raw:
        sys.exit("No credential. Set PLAY_SERVICE_ACCOUNT_JSON or put the key at "
                 + key_path())
    if not raw.startswith("{"):
        raw = open(raw, encoding="utf-8").read()
    return json.loads(raw)


def access_token(info: dict) -> str:
    import base64
    import hashlib

    from cryptography.hazmat.primitives import hashes, serialization
    from cryptography.hazmat.primitives.asymmetric import padding

    def b64(data: bytes) -> str:
        return base64.urlsafe_b64encode(data).rstrip(b"=").decode()

    now = int(time.time())
    header = b64(json.dumps({"alg": "RS256", "typ": "JWT"}).encode())
    claims = b64(json.dumps({
        "iss": info["client_email"],
        "scope": "https://www.googleapis.com/auth/androidpublisher",
        "aud": info["token_uri"],
        "iat": now - 60,
        "exp": now + 3600,
    }).encode())
    signing_input = ("%s.%s" % (header, claims)).encode()
    private = serialization.load_pem_private_key(info["private_key"].encode(), None)
    sig = private.sign(signing_input, padding.PKCS1v15(), hashes.SHA256())
    assertion = "%s.%s" % (signing_input.decode(), b64(sig))
    r = requests.post(info["token_uri"], timeout=60, data={
        "grant_type": "urn:ietf:params:oauth:grant-type:jwt-bearer",
        "assertion": assertion})
    r.raise_for_status()
    return r.json()["access_token"]


def listing_text() -> tuple:
    """Title, short and full description, out of LISTING.md's fenced blocks.

    The order there is name, short, full. Read rather than duplicated, so the
    reviewed document and what Play receives cannot drift apart.
    """
    md = open(LISTING_MD, encoding="utf-8").read()
    blocks = [b.strip() for b in re.findall(r"```\n(.*?)```", md, re.S)]
    if len(blocks) < 3:
        sys.exit("LISTING.md does not hold three fenced blocks (name, short, full)")
    return blocks[0], blocks[1], blocks[2]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true")
    ap.add_argument("--plan", action="store_true")
    args = ap.parse_args()

    title, short, full = listing_text()
    over = False
    for field, value in (("title", title), ("shortDescription", short),
                         ("fullDescription", full)):
        cap = LIMITS[field]
        state = "OK" if len(value) <= cap else "OVER"
        print("%-17s %4d/%-5d %s" % (field, len(value), cap, state))
        over |= len(value) > cap
    if over:
        sys.exit("something is over Play's limit")

    shots = sorted(os.path.join(SHOTS_DIR, n) for n in os.listdir(SHOTS_DIR)
                   if n.lower().endswith(".png"))
    if len(shots) < 2:
        sys.exit("Play requires at least two phone screenshots; found %d" % len(shots))
    print("screenshots       %4d  %s" % (len(shots), ", ".join(os.path.basename(s) for s in shots)))

    if not args.apply:
        print("\n--- short description ---\n%s" % short)
        print("\n--- full description ---\n%s" % full)
        print("\n[plan] nothing sent. Re-run with --apply.")
        return

    h = {"Authorization": "Bearer " + access_token(credentials())}
    edit = requests.post("%s/applications/%s/edits" % (BASE, PACKAGE),
                         headers=h, timeout=60).json()["id"]
    print("\nedit %s" % edit)

    def check(r, what):
        if r.status_code >= 400:
            requests.delete("%s/applications/%s/edits/%s" % (BASE, PACKAGE, edit),
                            headers=h, timeout=60)
            sys.exit("%s failed: %s\n%s" % (what, r.status_code, r.text[:1200]))
        return r.json() if r.content else {}

    check(requests.put(
        "%s/applications/%s/edits/%s/listings/%s" % (BASE, PACKAGE, edit, LANGUAGE),
        headers={**h, "Content-Type": "application/json"},
        json={"language": LANGUAGE, "title": title,
              "shortDescription": short, "fullDescription": full},
        timeout=120), "listing")
    print("  listing %s written" % LANGUAGE)

    check(requests.put(
        "%s/applications/%s/edits/%s/details" % (BASE, PACKAGE, edit),
        headers={**h, "Content-Type": "application/json"},
        json={"defaultLanguage": LANGUAGE, "contactEmail": CONTACT_EMAIL,
              "contactWebsite": CONTACT_WEBSITE},
        timeout=120), "details")
    print("  contact details written")

    # Screenshots hang off /listings/{language}/phoneScreenshots for upload,
    # listing and deletion alike. Replace rather than append: re-running should
    # leave four, not eight.
    check(requests.delete(
        "%s/applications/%s/edits/%s/listings/%s/phoneScreenshots"
        % (BASE, PACKAGE, edit, LANGUAGE), headers=h, timeout=120), "clear shots")
    for path in shots:
        with open(path, "rb") as fh:
            check(requests.post(
                "%s/applications/%s/edits/%s/listings/%s/phoneScreenshots"
                % (UPLOAD, PACKAGE, edit, LANGUAGE),
                headers=h, params={"uploadType": "media"},
                data=fh.read(), timeout=300), os.path.basename(path))
        print("  uploaded %s" % os.path.basename(path))

    check(requests.post("%s/applications/%s/edits/%s:commit" % (BASE, PACKAGE, edit),
                        headers=h, timeout=120), "commit")
    print("\ncommitted. The App content declarations are not part of this and "
          "remain in the Console — see store/play/LISTING.md.")


if __name__ == "__main__":
    main()
