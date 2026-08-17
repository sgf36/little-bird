# Wren — where the submission stands

Last updated 17 August 2026, after the file and guide importers landed.
Everything below was verified against App Store Connect or CI, not assumed.

## Not submitted. One thing needs you, in a browser.

### App Privacy questionnaire — the only remaining blocker

Apple's exact words when the submission was attempted:

> `STATE_ERROR.APP_DATA_USAGES_REQUIRED` — You must have published answers to
> your app's data usages.

App Store Connect → Wren → **App Privacy** → answer and **Publish**.

`appDataUsages` and every sibling endpoint 404 under the App Manager key,
including on Easy-Post, which has been through review. That is the API's shape,
not a permissions problem, and a stronger key will not help.

For Wren the honest answers are short. Nothing is collected, with one exception
worth declaring rather than hiding: entering a complimentary code sends the code
and a random device identifier to the Worker. That is not linked to a person and
is not used for tracking, so it is either "Data Not Collected" or, conservatively,
*Identifiers → Device ID*, used for **App Functionality**, **not linked** to the
user, **not** used for tracking. Either is defensible; the second is safer and
costs nothing.

Two things that were **not** true when this file was first written and are worth
knowing before answering:

- The app now reads **files the user chooses** through the document picker. They
  are read on the device and never uploaded, so nothing changes in the answers —
  but the reviewer sees a file picker now, and the review notes explain it.
- The app now decodes a **shared Apple Maps guide link** the user pastes. That is
  a string the user supplies; nothing is fetched and no Apple account is touched.

The privacy page already describes all of this, so the two will agree:
https://wren.spencerfields.com/privacy.html

## Settled since the last version of this file

| | |
|---|---|
| Paid Applications Agreement | **Done** — executed for Easy-Post, which covers the account. `GET /v1/agreements` still 404s; there is no API, and there did not need to be. |
| iPad | **iPhone-only.** `TARGETED_DEVICE_FAMILY = "1"`. There is no iPad layout and the input is screenshots taken on a phone. This also cleared `STATE_ERROR.SCREENSHOT_REQUIRED.APP_IPAD_PRO_3GEN_129`. Reversible in a later version. |
| Minimum iOS | **18.0**, raised from 13.0. Not a preference — `MKMapItem.identifier` is iOS 18+ and its `rawValue` is the muid a guide link needs, so below 18 every lookup returned nothing and the app installed, read screenshots correctly, then found no places at all. Apple asked for the same thing independently: **ITMS-90068** on build 48 flagged MinimumOSVersion 13.0 as under the 15.0 floor arriving Spring 2027. |

## What the app does now that the listing had to catch up with

Three ways in, not one — the **Add** button opens a menu:

1. **Screenshots**, as before.
2. **A file** — CSV, KML, KMZ, GPX, GeoJSON, Google Takeout. Read through a
   `UIDocumentPickerViewController` channel in `AppDelegate.swift` rather than a
   plugin, for the same reason OCR and place lookup are.
3. **An existing guide** — paste a shared link and Wren decodes the places
   already in it, shown as a collapsed group. Apple's share sheet gives a
   short `maps.apple/ug/…` link with no payload, so it is expanded via one
   request to Apple first; the app refused such links outright until
   17 August. Publishing uses `guide?_col=`, which creates a guide;
   `guides?user=`, which Apple emits for sharing, decodes identically but
   **arrives empty** when synthesised — that cost a build.

**The purchase now unlocks two things**, and Apple reviews the in-app-purchase
description against actual behaviour, so both had to be named in all 49 locales:
guides over three places, and combining with a guide you already have.

Three rules in that flow are counter-intuitive, and each was a bug first:

- Carried-over places **do not count** against the three-place cap. Counting
  them makes importing a guide of twenty trip a limit built for three.
- The paywall for combining **must not** offer "save the first three instead".
  That option trims what Wren found; applied here it publishes a guide missing
  places the user already had.
- "Nothing new to add" is checked **before** the purchase is offered. The
  original order took the money and then produced a duplicate guide. Pinned by a
  test asserting `buyCalls == 0`.

## Done and verified

| | |
|---|---|
| Build 53 | Signed and uploaded to TestFlight from CI run #53. First build containing the importers, the iOS 18 target and the new paywall. |
| Tests | 447, green. Includes 72 scene renders across twelve languages and 10 checks on the manual-test fixtures. |
| App UI | All 46 translated languages, plus English. 26 new strings this round. |
| Listings | 49 locales, all within Apple's caps. **Not yet re-pushed** — see below. |
| Test fixtures | `testdata/`, nine files, one per failure mode, each verified through the app's own reader. See `testdata/README.md`. |
| Screenshots | Pipeline built (`store/shoot.py`, `.github/workflows/screenshots.yml`), **not yet run** — deliberately waiting until device testing confirms nothing needs fixing. |
| Purchase | `READY_TO_SUBMIT`. |
| Age rating, category, copyright, content rights, review contact | All set. |
| Comp codes | Worker live, single-use enforced. Reviewer code `7QFG-7FVY-QXP6-2AT6` is deliberately **not** single-use. |

## The two steps left, in order

1. **You test build 53** on the phone, using `testdata/` and the guide-link
   instructions in `testdata/README.md`.
2. Then, in either order:
   - `gh workflow run screenshots.yml -f upload=true` — takes and uploads the
     ten localised sets. Roughly forty minutes of wall-clock. It waits for
     step 1 so the store page matches the build you approved, not because it
     costs anything: this repo is public, and the Actions timing API reports
     zero billable macOS milliseconds.
   - `python store/push_metadata.py --all` — pushes the updated listings.
   - Publish the App Privacy answers in the browser.
   - `python store/submit.py` — idempotent, safe to re-run.

## The guide-link ceiling, measured

The "50 places per link" figure this project carried for a day was wrong, and
worth recording properly because it changed a product decision.

maps.apple.com renders a guide link server-side and reports how many places it
parsed, so the limit was bisected against the live service on 17 August 2026
using real muids from a real 82-place guide:

| payload | URL chars | result |
|---|---|---|
| 159 places, lean | 3,504 | parsed all 159 |
| 160 places, lean | 3,534 | empty |
| 40 places, padded title | 3,420 | parsed all 40 |
| 40 places, padded title | 3,550 | empty |

**One limit, and it is the URL's length** — between 3,504 and 3,534 characters.
Forty places fails at the same length as a hundred and sixty, so it is not a
count. The old figure was measuring the cost of encoding a name and an empty
address with every place, fields Apple overwrites from its own record. Dropping
them takes a link from 50 places to about 150, so an 82-place guide is one guide.

Also probably the explanation for the original "60 places fails" observation:
sixty copies of one muid parses as sixty places but renders eight distinct ones
and a page a ninth the size. That test was measuring muid validity, not count.

**Still outstanding: one device check.** The server parses the lean payload; the
server is not the Maps app, and a coordinate-only payload renders fine on the web
and opens empty on a phone — which is how this project was misled once already.
Five tappable links are in the artifact handed to Spencer. If the lean encoding
misbehaves, `buildLegacyVerifiedLink` is the exact byte sequence confirmed on a
device, and the cap goes back to 50.

## Two things that will bite whoever picks this up

`reviewSubmissionItems` has no `inAppPurchaseV2` relationship — the API rejects
it as unknown. A first-submission IAP in `READY_TO_SUBMIT` goes with the app
version. `submit.py` still tries and reports the 409; that line is noise.

The Apple Maps payoff screenshot (`02-in-apple-maps.png`) is **English only and
should stay that way**. About twenty-five of its text labels are baked into the
raster map tiles, so translating the sheet alone leaves an English map, and
re-typesetting Apple's own interface on Apple's own store is both a review risk
and impossible to do correctly for Arabic or Devanagari shaping. `shoot.py`
attempts the real thing with a real guide link and skips it loudly, by name, if
a simulator's Maps will not open a guide.
