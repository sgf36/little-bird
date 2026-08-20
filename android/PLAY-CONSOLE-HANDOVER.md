# Wren on Google Play — handover

Everything needed to take the Android build from where it is now to a listing on
the Play Store. Written for somebody who has not seen this repository before.

Read the whole of §1 and §2 before touching anything. The rest is a work list.

---

## 1. What Wren-for-Android is, and what it is not

Wren on iPhone reads places off screenshots and writes them into an Apple Maps
guide. **Neither half of that exists on Android**, and no amount of work on the
Play listing changes it:

* There is no Apple Maps on Android, so there is no guide to write.
* On-device text recognition is Apple's Vision framework. The Android build has
  no OCR at all.

What the Android build actually does, end to end:

1. Takes a list of places **from a file** (CSV, KML, KMZ, GPX, GeoJSON, Google
   Takeout) or **from a link**.
2. Looks each place up, shows what it read beside what it matched, and lets a
   wrong match be corrected by hand.
3. **Hands the finished list to another map app on the phone** — this is the
   Android product, and it is the part that was built and tested in August 2026.

That third step is the whole pitch on Android. Do not write a Play listing that
promises screenshots or guides.

### What was verified on a real Android system, and what was not

| Target | State |
|---|---|
| Organic Maps | **Full import verified** — five places arrived as a named list |
| OsmAnd | **Full import verified** — Favorites folder "Wren GPX check", 5 points |
| Locus Map | **Full import verified** — five saved points in My library |
| Gaia GPS | Intent resolves and launches the app; **blocked by its own account wall** |
| Mapy.com | Intent resolves; Mapy answers **"Log in or create an account"** |
| Google Maps | **Verified**: saves a CSV through the system save dialog, then opens Google My Maps in a Custom Tab already signed in |
| The system chooser | Works; needs no per-app knowledge |

Gaia and Mapy were not taken past their sign-in screens. Creating accounts was
out of scope for the session that did this work. Their behaviour after sign-in
is documented by their vendors but has **not** been seen here.

---

## 2. The four things that block an upload today

Do these before anything else. Each one is small; each one is a landmine.

### 2.1 The purchase does not exist on Play, and the app will try to use it

`lib/src/store_unlock.dart` uses the cross-platform `in_app_purchase` package.
On Android that talks to **Play Billing** and asks for product
`com.spencerfields.littlebird.unlimited`, which exists in App Store Connect and
**does not exist in Play Console**. So on Android:

* `price()` returns null and the sheet falls back to `unlimitedFallbackPrice` —
  a hardcoded price that is not a Play price.
* `buy()` cannot succeed.

Worse, the App Review fix on branch `review/rejection-1` adds a permanent
"Guides of any size" entry to the overflow menu, gated only on
`!_entitlement.unlimited`. **When that branch is merged, Android gets a menu
item that opens a paywall that cannot work.** Shipping that would be a Play
policy problem as well as a bad first impression.

Pick one before release:

* **Recommended for v1:** make Android free with no purchase. Gate the unlock
  entry and the paywall on a store being available — a platform check
  (`Platform.isIOS`) is the blunt version and is honest today, since the free
  tier's limits are about Apple Maps guides, which Android does not have.
* Or create the non-consumable in Play Console, price it, and test it through a
  closed track. More work, and it prices a feature Android does not yet have.

**Also check what the free-tier cap means on Android.** `freePlaceLimit = 3`
limits places *per guide*. Android makes no guides, so decide explicitly whether
sending places elsewhere is capped at all. Today it is not.

### 2.2 "Make a guide" opens an Apple URL

The publish flow builds a `maps.apple.com` guide link and calls `launchUrl`
(`lib/main.dart`, around line 1457). On Android that opens a browser to Apple's
site, which is useless. Either hide the publish button on Android, or repoint it
at the "Send places to" sheet, which is the Android equivalent.

### 2.3 The two branches have diverged and must be merged

* `android/place-handoff` — all the Android work. Last commit `21c7b4c`.
* `review/rejection-1` — the App Store rejection fixes (purchase reachable from
  the menu, subtitles, screenshot 06). Cut from `main` separately.

Neither is merged to `main`. Merge order does not matter, but the merge **must**
resolve §2.1, because the rejection branch is what introduces the unlock menu
item that Android cannot honour.

### 2.4 There are no Android screenshots

The screenshots in `store/screenshots/` are iPhone captures of the iOS app, and
several show Apple Maps. **None may be used on Play.** Play needs its own
phone screenshots of the Android build: minimum 2, maximum 8, 16:9 or 9:16,
each between 320px and 3840px on a side.

The emulator is set up for this (see §6). Shoot the flows that exist: the
imported list, correcting a place, the "Send places to" sheet with real map apps
installed, and an import landing in Organic Maps or OsmAnd.

---

## 3. Play Console account — the state of it

Recorded in memory `project-google-play-account`, and worth re-reading there
before acting:

* The account stays a **sole trader**, i.e. the **individual** developer route.
  The organisation route is a dead end for a UK sole trader: it wants a
  Certificate of Incorporation, and a D-U-N-S number alone is not enough.
  Incorporating would restart Apple, Paddle, ICO and D-U-N-S.
* The individual route requires a **physical, non-rooted Android device running
  Android 10 or later**. An emulator is rejected. A Galaxy A15 5G was ordered on
  2026-08-19 and shipped on 2026-08-19 (giffgaff).
* A new individual account must run **closed testing with at least 12 testers
  for 14 continuous days** before production access is granted. Start this as
  early as possible — it is the long pole, not the build.
* **Google publishes the payments-profile address on monetised listings**, and
  unlike Apple there is no separate trader-address field. The business address
  is Lytchett House, 13 Freeland Park, Wareham Road, Lytchett Matravers, Poole,
  BH16 6FA (UK Postbox, ref 171196). **The home address at 1A Wroughton Road
  must never be published.** Before going live, check what the listing actually
  shows — a free app with no purchases may not publish an address at all, which
  is another argument for §2.1's free-for-v1 option.

---

## 4. Signing

Nothing is set up. Play App Signing is the default and the right choice.

```bash
# Upload key. Keep the keystore OUT of the repo — sgf36/wren is public.
keytool -genkey -v -keystore wren-upload.jks -storetype JKS \
        -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Then `android/key.properties` (git-ignored) and a `signingConfigs` block in
`android/app/build.gradle.kts`, which currently signs release with the **debug**
key:

```kotlin
buildTypes {
    release {
        signingConfig = signingConfigs.getByName("debug")   // <- must change
    }
}
```

Store the keystore and its passwords in Windows Credential Manager alongside the
other secrets for this project, and record where in memory. Losing the upload
key is recoverable through Play support; losing it *and* not using Play App
Signing is not.

---

## 5. The build

```bash
flutter build appbundle --release     # produces build/app/outputs/bundle/release/app-release.aab
```

* `applicationId` is `com.spencerfields.littlebird` — the same id as the iOS
  bundle, which is fine and deliberate.
* `versionCode`/`versionName` come from `pubspec.yaml` (`version: 1.0.0+1`).
  Play rejects a re-used `versionCode`, so bump the `+N` for every upload.
* `namespace` is `com.spencerfields.littlebird` and the Kotlin now lives in the
  matching package. See §7 for why that matters.
* The manifest declares **no permissions at all**, which is true and worth
  keeping: the hand-off needs none.

CI already builds a debug APK on every run and keeps it as the `app-debug-apk`
artifact (`.github/workflows/ci.yml`, job `android`). There is **no release
build in CI** — add one only after signing exists, and never put the keystore in
the repo.

---

## 6. The emulator

`tools/emulator.sh` launches AVD `wren_play` with keyboard, GPU and clipboard
sharing forced on — all three default to off and fail silently. It is a Play
Store image and is signed in, so the five target map apps can be installed from
Play. All five were installed this way; none was blocked or incompatible
(`ro.product.cpu.abilist` is `x86_64,arm64-v8a`, so ARM-only builds install too).

```bash
bash tools/emulator.sh                  # boot it
adb install -r path/to/app-debug.apk    # CI artifact, or a local build
adb shell am start -n com.spencerfields.littlebird/.MainActivity
```

Note for anyone scripting adb from Git Bash on Windows: MSYS mangles `/sdcard`
paths. Prefix commands with `MSYS_NO_PATHCONV=1`.

---

## 7. Traps already paid for — do not rediscover these

Each of these cost real time and each fails *silently*.

**Manifest class names.** `android:name=".Foo"` means `<namespace>.Foo`. The
namespace was renamed to `com.spencerfields.littlebird` while the Kotlin still
declared `package com.spencerfields.reel_places`, so the APK built, installed,
and **died on launch** with "Activity class does not exist". CI now has a step,
*Prove every manifest class exists*, that catches it. Keep it.

**A `file://` URI grants the receiving app nothing.** The other app launches,
matches the MIME type, then dies with `EACCES`. Everything goes out as a
`content://` URI through a FileProvider with `FLAG_GRANT_READ_URI_PERMISSION`.

**The FileProvider must be the subclass.** Android's mime table has entries for
`kml` and `kmz` and **none for `gpx`**, so androidx's `FileProvider.getType()`
answers `application/octet-stream`. `PlaceFileProvider` hardcodes the map.

**Exports live in `filesDir/share`, not the cache.** The cache is reclaimable,
and a receiver that defers the import can find the bytes gone after the grant
succeeded.

**GPX, not KML.** KML is more widely registered and is fatal to two targets:
OsmAnd routes an arriving `.kml`/`.kmz` down its *track* path, which can never
reach favourites, and Mapy does not accept KML at all.

**One format, five different intents.** Organic Maps and OsmAnd take
`ACTION_SEND`; Gaia GPS, Locus Map and Mapy take `ACTION_VIEW` with
`setDataAndType` (never `setData` then `setType` — each clears the other). Locus
additionally needs the extra `locus.api.android.INTENT_EXTRA_CALL_IMPORT = true`,
without which the places draw as temporary map objects and vanish on restart.

**Never pre-flight with `resolveActivity`.** On API 30+ it returns null for a
package that is merely filtered by package visibility, so the button silently
disappears on a device that has the app. Catch `ActivityNotFoundException`.

**Never call `Context.grantUriPermission`.** It grants access revocable only by
an explicit revoke — an indefinite leak of the user's place list to another app.

**Every package offered by name must be in `<queries>`.** Otherwise
`getPackageInfo` throws exactly as if the app were not installed. A Dart test
(`test/map_targets_test.dart`) reads the real manifest to enforce this.

**A first launch swallows the intent.** Organic Maps, Locus and Mapy each
consumed the first hand-off during their own onboarding and worked on the
second. The UI should suggest trying again rather than reporting failure.

**A CSV wants saving, not sharing.** The Google Maps route used to share the CSV
and open the Custom Tab on top of the chooser; logcat showed the chooser opening
with `getDisplayResolveInfoCount() == 0`, because nothing on a plain Android
device volunteers to receive `text/csv`. It now uses `ACTION_CREATE_DOCUMENT`
and opens the tab only after the save succeeds.

**Working in a git worktree**, `flutter test` and `flutter analyze` fail on a
missing `ios/Flutter/ephemeral` SwiftPM path until `--no-pub` is passed.

---

## 8. Play Console work list

In the order that unblocks the most.

1. **Finish account verification** on the physical device (§3). Nothing else can
   be submitted until this is done.
2. **Resolve §2.1 and §2.2**, then merge both branches to `main`.
3. **Set up signing** (§4) and produce a signed AAB.
4. **Internal testing track**: upload the AAB, add yourself, install from Play,
   and confirm the hand-off still works when installed from Play rather than
   `adb install` — CI re-signs every debug APK, so uninstall before installing.
5. **Start closed testing with 12 testers immediately** (§3). Fourteen
   continuous days; the clock does not start until the track is running.
6. **Store listing** (§9) and **graphics** (§2.4).
7. **App content declarations** (§10).
8. Promote to production when the 14 days are served.

---

## 9. Store listing copy

Play's fields: app name (30), short description (80), full description (4000).

Say what the app does on Android. A truthful short description is along the
lines of *"Turn a list of places into pins in your map app"*. The full
description should cover: the file formats it reads; that it checks each place
with you before anything leaves; the five map apps it hands to, with the honest
note that Gaia GPS and Mapy.com need their own accounts; and the Google Maps
route via My Maps, including that it takes a few taps because Google exposes no
way for an app to write a saved list.

Two rules carried over from the App Store:

* **Do not name Apple products** anywhere in Play metadata. Wren was rejected
  under App Store guideline 5.2.5 for naming Apple in the subtitle; on Play the
  wording is irrelevant to the product anyway.
* Other companies' app names (Organic Maps, OsmAnd, Locus Map, Gaia GPS,
  Mapy.com, Google Maps) may be used **referentially** — "works with", "hands
  the list to" — never in the app's own name, icon, or in a way implying
  endorsement.

The iOS listing lives in `store/metadata_*.json` and is a useful source of
phrasing, but **its claims are about the iOS app** and most do not transfer.

---

## 10. App content declarations

Answer these from what the app actually does, which is verifiable in the code:

* **Data safety.** The app has no account and no analytics. Two things leave the
  device: a place name, sent to the map provider so it can be found; and, *only*
  if somebody enters a complimentary access code, that code plus a random device
  identifier, sent to `https://wren-codes.sgf36.workers.dev`
  (`lib/src/comp_unlock.dart`). The random identifier is not linked to a person
  and is not used for tracking. Nothing else is collected or shared.
* **Content rating.** IARC questionnaire. No violence, no user-generated
  content, no communication features, no gambling. It is a utility.
* **Target audience.** Not directed at children.
* **Ads.** None.
* **Government / news / COVID apps.** None of these.
* **Privacy policy URL.** <https://wren.spencerfields.com/privacy.html> — check
  it before submitting: it is written for the iOS app and describes Apple Maps
  lookups and the App Store privacy label.

---

## 11. Where things are

| Thing | Where |
|---|---|
| Android work | branch `android/place-handoff`, last commit `21c7b4c` |
| App Store rejection fixes | branch `review/rejection-1` |
| Kotlin | `android/app/src/main/kotlin/com/spencerfields/littlebird/` |
| Hand-off targets, per-app intents | `lib/src/map_targets.dart` |
| File writer (GPX/KML/KMZ/CSV/GeoJSON) | `lib/src/place_export.dart` |
| Share/save bridge | `lib/src/place_share.dart`, `ShareFilePlugin.kt` |
| Tests for all of the above | `test/place_export_test.dart`, `test/place_share_test.dart`, `test/map_targets_test.dart`, and the `sending places elsewhere` group in `test/import_flow_test.dart` |
| Emulator launcher | `tools/emulator.sh` |
| CI, including the Android job and its guards | `.github/workflows/ci.yml` |
| Google Play account facts | memory `project-google-play-account` |
| Everything learned about the hand-off | memory `project-reels-to-apple-maps` |

Suite is 560 tests. CI is green on both branches.
