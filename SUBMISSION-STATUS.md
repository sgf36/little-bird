# Wren — where the submission stands

Last updated 21 August 2026. Everything below was read back from App Store
Connect on that date, not assumed. The version of this file before it was four
days stale and said the opposite of the truth on its first line: it claimed the
app was not submitted, when 1.0 had been live for days.

## 1.0 is on the App Store. 1.1.0 is prepared and waiting for you to submit it.

| | |
|---|---|
| **1.0** | `READY_FOR_SALE` — live, build 105 |
| **1.1.0** | `PREPARE_FOR_SUBMISSION` — build **108** attached, VALID, minOS 18.0 |
| Release notes | All 49 locales, pushed from `store/metadata_*.json` |
| Reviewer notes | Updated for 1.1.0 and matching the repo byte for byte |
| Purchase `unlimited` | `APPROVED` |
| App Privacy questionnaire | Answered and published 17 August. Still correct — see below |
| Paid Applications Agreement | Executed via Easy-Post, which covers the account |
| Copyright, age rating, category, screenshots, privacy URLs | All set |

**The only step left is pressing Submit**, deliberately left to a person so the
build and the in-app purchase can be seen attached rather than reported so.

### Why the privacy answers did not need revisiting for 1.1.0

Administrative complimentary codes now re-confirm themselves daily. That changes
how *often* the device identifier is sent, not what is sent or why: it is the
same identifier, for the same purpose, and Apple's form has no field for
frequency. The label declares *Identifiers → Device ID, App Functionality, not
linked to the user, not used for tracking*, which is also what
https://wren.spencerfields.com/privacy.html says it declares, so the two agree.

### Two things the API cannot see, and one trap

`appDataUsages` and `agreements` both 404 under this key. That is the API's
shape, not a permissions problem, and a stronger key does not help.
`store/readiness.py` prints `?` for them, meaning **could not look** — not
"missing". Reading that `?` as a blocker is how the previous version of this
file came to name a satisfied requirement as the thing holding up a submission.

`store/push_metadata.py` reports `0 of 49 succeeded` whenever the in-app
purchase is live: Apple refuses to edit an `ACTIVE` InAppPurchaseLocalization,
and the script counts a locale as successful only if the listing *and* the
purchase both wrote. The listings do get written. Read the per-locale
`listing set` lines, not the summary.

## What 1.1.0 contains

A code console, reachable only on a device that has redeemed an administrative
complimentary code, and revocable administrators: an admin token is now good for
a fortnight and re-confirms daily, so withdrawing such a code ends the unlock it
granted. Ordinary unlock codes do not renew and are not revocable. A purchase is
untouched and is never re-checked.

The console is deliberately absent from the public release notes — describing it
there is the one thing that would make it discoverable — and deliberately
present in the reviewer notes, because guideline 2.3.1 asks that functionality
be clear to App Review rather than only to end users. The App Review code
`7QFG-7FVY-QXP6-2AT6` is an ordinary unlock code, so the console cannot be opened
during review, and unlock codes never renew, so nothing about renewal reaches a
reviewer either.

## Android

`Wren-android-1.1.0+2-internal.aab`, built from the branch tip and signed with
the upload key (`META-INF/UPLOAD.RSA`, fingerprint `B0:67:…:27:93`, checked
against the keystore). Waiting on the Play app record before it can go to the
internal testing track. Package name is `com.spencerfields.littlebird` — the id
predates the rename and is what the bundle is actually signed under.

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

**Confirmed on a device**, 17 August 2026. Five links were opened on an iPhone:
5 places lean opened with all five and every field filled in by Apple; 5 places
with our own names opened identically, so the names were doing nothing; 82 lean
opened as 80; 150 lean opened as 148; 160 gave Apple's "Coming Soon" page. The
device boundary is exactly where the bisection put it, so the cap stands at 150.

One thing that fell out of it: **Apple silently drops a place whose muid it no
longer serves.** Both large tests came back exactly two short, from a set drawn
from one real 82-place guide — so two of those places are dead records. Nothing
in this app can prevent that; the payload is right and Apple has nothing to
resolve. A republished guide can therefore be smaller than the one it replaces,
and the missing places were already unreachable in Maps.

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
