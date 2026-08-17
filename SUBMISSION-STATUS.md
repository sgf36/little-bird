# Wren — where the submission stands

Written overnight, 17 August 2026. Everything below was verified against App
Store Connect, not assumed.

## Not submitted. Two things need you, in a browser.

I got everything else to the line. The submission itself is blocked on two
steps that have **no API at all** — I probed every documented path and each
returns 404 under the App Manager key, including on Easy-Post, which has been
through review. These are not permissions problems and a stronger key will not
help.

### 1. App Privacy questionnaire — the actual blocker

Apple's exact words when I tried to submit:

> `STATE_ERROR.APP_DATA_USAGES_REQUIRED` — You must have published answers to
> your app's data usages.

App Store Connect → Wren → **App Privacy** → answer and **Publish**.

For Wren the honest answers are short. Nothing is collected, with one
exception you should declare rather than hide: entering a complimentary code
sends the code and a random device identifier to the Worker. That is not
linked to a person and is not used for tracking, so it is either "Data Not
Collected" or, if you want to be conservative, *Identifiers → Device ID*,
used for **App Functionality**, **not linked** to the user, **not** used for
tracking. Either is defensible; the second is safer and costs nothing.

The privacy page already describes this in full, so the two will agree:
https://wren.spencerfields.com/privacy.html

### 2. Paid Applications Agreement

`GET /v1/agreements` 404s — there is no API. Business → Agreements, signed by
the Account Holder. Nothing sells until it is in place, and the in-app
purchase cannot be reviewed without it.

## One decision I did not take for you

Apple also refused the submission for this:

> `STATE_ERROR.SCREENSHOT_REQUIRED.APP_IPAD_PRO_3GEN_129` — A screenshot with
> type ipadPro129 is required but was not provided.

That is because the Xcode project sets `TARGETED_DEVICE_FAMILY = "1,2"`, so
the app claims iPad support and Apple wants iPad screenshots to match.

Two ways out, and it is genuinely your call:

- **Make it iPhone-only** — change to `"1"` and rebuild. Honest, since there
  is no iPad layout and the whole flow is designed one-handed. iPad owners can
  still install it under "iPhone Apps". One line, one rebuild, reversible in a
  later version.
- **Keep iPad support** and capture a set on an iPad Pro 12.9-inch.

I did not pick, because it changes which devices your app supports and takes
ten seconds to decide once you are awake.

## Done and verified tonight

| | |
|---|---|
| Build 48 | On TestFlight, `IN_BETA_TESTING`, export compliance answered. Contains the grammar fix. |
| Grammar | "1 need a look" → "1 needs a look", plus the same slip in 21 other languages. 20 were already correct and were left alone. |
| Screenshots | Six, uploaded to en-GB, all `COMPLETE`. The other 48 locales inherit them. Status bar cleaned. |
| Purchase | `READY_TO_SUBMIT` — the review screenshot was what was missing. |
| Listings | 49 locales, all pushed, privacy policy URL now set on every one. |
| Age rating | Complete. All 25 answerable attributes declared, everything `NONE`/false. |
| Category | Travel, with Navigation secondary. |
| Content rights | Declared: does not use third-party content. |
| Copyright | "2026 Spencer Fields". |
| Review detail | Contact and notes set, including the reviewer code `7QFG-7FVY-QXP6-2AT6`. |
| Comp codes | Worker live, single-use enforced, ten friend codes unused. |

A submission record already exists — `6169ed79-e6c5-4320-a87c-4b4931e11005`,
state `READY_FOR_REVIEW` with no items. Once the two browser steps are done,
`python store/submit.py` will add the version and push it through. It is
idempotent and safe to re-run.

## One thing that will bite whoever picks this up

`reviewSubmissionItems` has no `inAppPurchaseV2` relationship — the API
rejects it as unknown. The purchase is not added to the submission
separately; a first-submission IAP in `READY_TO_SUBMIT` goes with the app
version. `submit.py` still tries and reports the 409; that line is noise, not
a failure.
