# -*- coding: utf-8 -*-
"""Send an App Bundle to a Google Play track, or to Internal app sharing.

    python store/play_upload.py --check
    python store/play_upload.py --aab <path>                  # internal track
    python store/play_upload.py --aab <path> --share          # install link

Four REST calls around an "edit": create, upload the bundle, assign it to a
track, commit. Talking to the API directly rather than through fastlane keeps
the one credential that can publish this app away from a third-party toolchain.

**A first release does not reach a phone on the day it is built.** A track
release on an app that has never been published goes to "Pending publication"
until Google reviews it, and the tester opt-in link does not exist until that
finishes. `--share` is the way round it: Internal app sharing has no track and
no review, and returns a URL that installs this exact bundle.

Production is not offered. Releasing to the public should be a deliberate act
in the Console, not a flag on the script that also does routine test uploads.

Credentials are Easy-Post's Play service account, which reaches this app too.
See that repo's PLAY-SETUP.md.
"""
import argparse
import os
import sys

import requests

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from play_listing import (BASE, PACKAGE, UPLOAD, access_token,  # noqa: E402
                          credentials)

TRACKS = ("internal", "alpha", "beta")
DEFAULT_AAB = os.path.join("build", "app", "outputs", "bundle", "release",
                           "app-release.aab")


def fail(edit, headers, what, r):
    if edit:
        requests.delete("%s/applications/%s/edits/%s" % (BASE, PACKAGE, edit),
                        headers=headers, timeout=60)
    sys.exit("%s failed: %s\n%s" % (what, r.status_code, r.text[:1000]))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--aab", default=DEFAULT_AAB)
    ap.add_argument("--track", default="internal", choices=TRACKS)
    ap.add_argument("--notes", default=None)
    ap.add_argument("--check", action="store_true",
                    help="prove the credential works and can see this app")
    ap.add_argument("--share", action="store_true",
                    help="Internal app sharing: an install link, no track, no review")
    args = ap.parse_args()

    h = {"Authorization": "Bearer " + access_token(credentials())}

    if args.check:
        r = requests.post("%s/applications/%s/edits" % (BASE, PACKAGE),
                          headers=h, timeout=60)
        if r.status_code >= 400:
            fail(None, h, "edits.insert", r)
        edit = r.json()["id"]
        requests.delete("%s/applications/%s/edits/%s" % (BASE, PACKAGE, edit),
                        headers=h, timeout=60)
        print("credential reaches %s" % PACKAGE)
        return

    if not os.path.exists(args.aab):
        sys.exit("no bundle at %s" % args.aab)
    size = os.path.getsize(args.aab)
    print("%s (%d MB)" % (os.path.basename(args.aab), size // (1024 * 1024)))

    if args.share:
        # Note the path: applications/internalappsharing/{package}, not
        # applications/{package}/internalappsharing, which is the ordering
        # everything else in this API uses.
        with open(args.aab, "rb") as fh:
            r = requests.post(
                "%s/applications/internalappsharing/%s/artifacts/bundle"
                % (UPLOAD, PACKAGE),
                headers={**h, "Content-Type": "application/octet-stream"},
                params={"uploadType": "media"}, data=fh, timeout=1800)
        if r.status_code >= 400:
            fail(None, h, "internal app sharing", r)
        d = r.json()
        print("\ninstall link: %s" % d.get("downloadUrl"))
        print("version code: %s" % d.get("certificateFingerprint", "")[:0] or d.get("sha256", "")[:0] or "")
        return

    r = requests.post("%s/applications/%s/edits" % (BASE, PACKAGE), headers=h, timeout=60)
    if r.status_code >= 400:
        fail(None, h, "edits.insert", r)
    edit = r.json()["id"]
    print("edit %s" % edit)

    with open(args.aab, "rb") as fh:
        # The media type has to be stated. Left to itself requests guesses
        # application/x-zip from the extension, and the API refuses that.
        r = requests.post("%s/applications/%s/edits/%s/bundles" % (UPLOAD, PACKAGE, edit),
                          headers={**h, "Content-Type": "application/octet-stream"},
                          params={"uploadType": "media"}, data=fh, timeout=1800)
    if r.status_code >= 400:
        fail(edit, h, "bundle upload", r)
    version_code = r.json()["versionCode"]
    print("  uploaded, versionCode %s" % version_code)

    release = {"status": "completed", "versionCodes": [str(version_code)]}
    if args.notes:
        release["releaseNotes"] = [{"language": "en-GB", "text": args.notes}]
    r = requests.put("%s/applications/%s/edits/%s/tracks/%s" % (BASE, PACKAGE, edit, args.track),
                     headers={**h, "Content-Type": "application/json"},
                     json={"track": args.track, "releases": [release]}, timeout=120)
    if r.status_code >= 400:
        fail(edit, h, "track assignment", r)
    print("  assigned to %s" % args.track)

    r = requests.post("%s/applications/%s/edits/%s:commit" % (BASE, PACKAGE, edit),
                      headers=h, timeout=300)
    if r.status_code >= 400:
        fail(edit, h, "commit", r)
    print("  committed")
    print("\nOn an app that has never been published this will read 'Pending "
          "publication' until Google reviews it, and the tester opt-in link "
          "will not exist until then. Use --share to install today.")


if __name__ == "__main__":
    main()
