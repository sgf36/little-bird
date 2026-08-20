# Wren on Google Play — handover

Everything needed to take the Android build from where it is now to a listing on
the Play Store. Written for somebody who has not seen this repository before.

Read the whole of §1 and §2 before touching anything. The rest is a work list.

---

## 1. What Wren-for-Android is, and what it is not

Wren on iPhone reads places off screenshots and writes them into an Apple Maps
guide. On Android it reads the screenshots too — that was fixed on 2026-08-20,
and this document used to say it could not — but there is no Apple Maps, so the
places go somewhere else.

* **Reading a screenshot works.** Apple's Vision framework is not available, but
  ML Kit's on-device recogniser is, and it returns text with the same geometry
  Vision does. `OcrPlugin.kt` is the Android half of `littlebird/ocr`, and every
  line of ranking logic in Dart is shared, unchanged.
* **Looking a place up works.** MapKit is not available; the platform geocoder
  is, and on a device with Google services it resolves business names rather
  than only addresses. `PlacesPlugin.kt` is the Android half of
  `littlebird/places`. It returns no Apple place id, because a geocoder issues
  none — which is why `PlaceMatch.id` is optional.
* **There is still no Apple Maps**, so there is no guide to write. That one
  absence is real and permanent, and it is the only thing `canMakeGuides`
  should ever gate.

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

## 2. The four things that used to block an upload

**All four are done, on `android/place-handoff`.** Kept here because each one
explains why the code looks the way it does, and because a later change could
undo any of them without a test noticing.

### 2.1 The purchase — resolved: Android is free, and sells nothing

`lib/src/store_unlock.dart` uses `in_app_purchase`, which on Android talks to
Play Billing and asks for `com.spencerfields.littlebird.unlimited` — a product
that exists in App Store Connect and not in Play Console. `price()` returned
null, the sheet fell back to a hardcoded figure and `buy()` could not succeed.

The unlock sells guides of any size. There are no guides here, so there is
nothing to sell, and Android is now free with no purchase at all: no paywall,
no restore item, no unlock item in the overflow menu, no complimentary-access
dialog, and **no free cap** — `freePlaceLimit` counts places in a guide, and
handing a list to another map app makes no guide.

One flag decides all of it: `CapturePage.canMakeGuides`, null meaning
"decide from the platform", which is `!Platform.isAndroid`. It also decides
which `UnlockStore` is built, so no `BillingClient` is ever constructed.

The old `canSendElsewhere` flag is folded into it. Two fields that must always
disagree is a bug waiting to be written.

**And the permission.** The app manifest asks for nothing and the APK shipped
`com.android.vending.BILLING` anyway, because the billing library's own
manifest declares it and Play reads the merged result. The same route brought
`INTERNET` and `ACCESS_NETWORK_STATE`, from the Google datatransport that
billing depends on. All three are removed with `tools:node="remove"`, so **the
released app declares no permissions at all** — which is true, and worth
saying on the listing. `android/app/src/debug/AndroidManifest.xml` adds
`INTERNET` back for debug and profile builds, where the Dart VM service needs
it.

### 2.2 "Make a guide" — resolved: the button is the hand-off

The publish flow built a `maps.apple.com` link and opened a browser. Where
`canMakeGuides` is false the main button opens the "Send places to" sheet
instead, which used to hang off the overflow menu and is the point of the
Android app. The menu item is gone, because it was the same action twice.

### 2.3 The branches — resolved: merged

`review/rejection-1` is merged into `android/place-handoff`. Its one conflict
was the item it adds to the overflow menu, "Guides of any size", gated only on
the entitlement: on Android that would have opened a paywall quoting a price
Play never set. Both purchase items now sit behind `canMakeGuides`. Fixing one
store's rejection must not manufacture another's.

### 2.4 Screenshots — resolved: four, shot on Android

`store/play/screenshots/en-GB/`, with `store/play/SCREENSHOTS.md` beside them.
Nothing from `store/screenshots/` is reused; those are iPhone captures and
several show Apple Maps.

### 2.5 What was found while doing the above — also resolved

The first screen still sold the iPhone app, and two of the three ways in were
dead ends. None of it could be screenshotted for Play.

* The empty state promised to read screenshots into Apple Maps. There is no
  text recognition here and no Apple Maps. It now describes reading a file,
  through two new strings, `emptyBodyAndroid` and `emptyNoteAndroid`.
* "Add screenshots" opened a photo picker and then answered "needs an iPhone".
* "From an existing guide" read the places and left the send button
  permanently disabled: Apple's payload carries no coordinates and there is no
  MapKit to fill them in. Proved in a test, not assumed.
* An unmatched row offered a magnifying glass that opened a search sheet
  captioned "Search Apple Maps", which could only ever fail.

So on Android **a file is the only way in**, and "Add" opens the picker
directly rather than offering one working source beside two dead ones. A row
carries no search icon, and the "read as" caption is shown only where it
differs from the name above it — otherwise every row of an imported file was
captioned with its own name.

The list also now takes its title from the file: "Saved places.csv" arrives in
the other map app as "Saved places" rather than "Places", or "Places1" once a
second one lands.

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

## 4. Signing — done

Play App Signing holds the app signing key. What exists here is the **upload**
key, which is the reason losing it is recoverable through Play support.

| | |
|---|---|
| Keystore | `Apps/Claude/Wren-Android-upload-keystore.jks` — outside this repository, which is public |
| Alias | `upload` |
| Password | Windows Credential Manager: service `wren-android-upload-keystore`, account `upload`. Store password and key password are the same. |
| SHA-1 | `2C:08:1F:02:32:CD:C1:D0:A3:B7:C6:44:95:FC:18:42:7C:70:54:68` |
| Notes | `Apps/Claude/Wren-Android-upload-keystore.README.txt` |

`android/app/build.gradle.kts` reads `android/key.properties` (git-ignored),
falling back to `ANDROID_KEYSTORE_PATH`, `ANDROID_KEYSTORE_PASSWORD`,
`ANDROID_KEY_ALIAS` and `ANDROID_KEY_PASSWORD` in the environment, which is how
CI would read it out of GitHub Actions secrets.

**There is deliberately no fall back to the debug key.** A release signed with
it builds happily, uploads, and is refused by Play with a message about the
certificate, which reads like a Play fault and sends you looking in the wrong
place. Without the material the release is left unsigned, and Gradle says so at
configuration time.

Verified: `app-release.aab` is signed by the fingerprint above, compared
against the keystore, and not by `CN=Android Debug`.

**GitHub secrets are not set yet.** A release build in CI needs them; nothing
else does.

## 5. The build

```bash
flutter build appbundle --release --no-pub   # build/app/outputs/bundle/release/app-release.aab
flutter build apk --release --no-pub         # a fat APK, for installing on a device by hand
```

* `--no-pub` matters **in a git worktree**: without it the tool walks into a
  missing `ios/Flutter/ephemeral` SwiftPM path and dies before Gradle starts.
* `applicationId` is `com.spencerfields.littlebird` — the same as the iOS
  bundle, deliberately.
* `versionCode`/`versionName` come from `pubspec.yaml` (`version: 1.0.0+1`).
  Play refuses a reused `versionCode`, so bump `+N` for every upload.
* The AAB is about 50 MB; Play splits it per device.

CI builds a debug APK on every run and keeps it as `app-debug-apk`. It also
runs `:app:processReleaseMainManifest` and asserts the release asks for no
permissions. There is still **no signed release build in CI** — that needs the
GitHub secrets in §4.

### Gradle would not run on this machine, and the message was a lie

Every Gradle build failed with `java.io.IOException: Unable to establish
loopback connection`, which is not about loopback. An AF_UNIX socket **binds**
under `%LOCALAPPDATA%\Temp` on this machine and then cannot be **connected**
to — `SocketException: Invalid argument: connect` — while the identical code
one directory over works. Java's `Pipe` puts its socket in the AF_UNIX temp
directory, so `Selector.open()` throws and the daemon and its client never
meet.

The fix is one system property, in `~/.gradle/gradle.properties`:

```
org.gradle.jvmargs=... -Djdk.net.unixdomain.tmpdir=C:\Users\SpencerFields\gradle-tmp
```

It has to be on `org.gradle.jvmargs`. `GRADLE_OPTS` fixes the launcher JVM and
leaves the daemon dying on its own `Selector`; a project `gradle.properties`
overrides the home one for that key, so passing it through `JAVA_TOOL_OPTIONS`
also works and is what the builds here used. The note that used to sit in that
file blamed NordVPN and set `-Djava.net.preferIPv4Stack=true`, which makes no
difference to a fault that never reaches an IP socket.

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

**A permission you never asked for is invisible in the source tree.** The app
manifest declared nothing and the APK shipped `com.android.vending.BILLING`,
`INTERNET` and `ACCESS_NETWORK_STATE`, all three arriving through the billing
library and the Google datatransport under it. Read
`build/app/intermediates/merged_manifest/**/AndroidManifest.xml`, or
`adb shell dumpsys package` on a device. CI now reads the built manifest for
both variants, and the check was tried in both directions — a guard that
cannot go red proves nothing.

**A screenshot can be the right size, ratio and colour depth and show
nothing.** A cleared app takes about fifteen seconds to draw: `pm clear`, a
cold start, and the splash gate. Shooting at ten seconds produced a 12 kB flat
green rectangle that passed every mechanical check. Open every image.

**The emulator is 1080×2400, which is 2.22:1 and over Play's 2:1 ceiling.**
`adb shell wm size 1080x1920` before shooting, and `wm size reset` after. The
refusal would come at upload, long after the shooting.

**`screencap` writes RGBA and Play refuses an alpha channel.** Convert before
uploading.

**`adb push` wants a Windows path for the source and `MSYS_NO_PATHCONV=1` for
the destination**, and the environment variable suppresses both conversions.
Give the local path as `C:\...` and prefix the command.

**Gradle's "Unable to establish loopback connection" is not about loopback.**
See §5. It cost most of an afternoon and the note that was already on the
machine blamed the wrong thing entirely.

---

## 8. Play Console work list

Everything in the repository is done. What is left needs the Play Console, a
physical device, or a decision.

1. **Finish account verification** on the Galaxy A15 (§3). Nothing can be
   submitted until this is done, and nothing here can do it — the individual
   developer route rejects an emulator.
2. **Start closed testing with twelve testers the moment there is a track.**
   Fourteen continuous days, and the clock does not start until the track is
   running. This is the long pole; it is not the build.
3. **Rewrite the privacy policy** at
   <https://wren.spencerfields.com/privacy.html>. It describes the iOS app —
   Apple Maps lookups and the App Store privacy label — and it does not say
   that this build collects nothing at all. See `store/play/LISTING.md`.
4. **Set the GitHub secrets** if CI is to build a signed release (§4).
5. **Enter the listing** from `store/play/LISTING.md` and upload the four
   screenshots from `store/play/screenshots/en-GB/`.
6. **Answer the content declarations**, also in `store/play/LISTING.md`. Data
   safety is now "nothing collected, nothing shared", which is stronger than
   this document originally expected and is why §10 was rewritten.
7. **Upload the AAB to an internal track**, install from Play rather than
   `adb install`, and confirm the hand-off still works. CI re-signs every debug
   APK, so uninstall before installing.
8. Promote to production when the fourteen days are served.

**Bump `versionCode` for every upload.** It comes from `pubspec.yaml`
(`version: 1.0.0+1`), and Play refuses a reused one.

## 9 and 10. Listing copy and content declarations

Both are drafted in **`store/play/LISTING.md`**, with the app name, the short
description, the full description and every content-declaration answer. They
live together because the listing's claims about the five map apps have to
match `lib/src/map_targets.dart`, and the data-safety answer has to match what
the code actually does.

Two things there are worth knowing without opening it:

* **Data safety is "no data collected, no data shared".** That is stronger than
  this document originally said, and it is true because of the work in §2: no
  map lookup (MapKit is Apple's), no guide link to expand, and a
  complimentary-access code that cannot be redeemed because the device
  identifier comes from a channel with no Android implementation. The released
  app declares no permissions, which CI proves against the built manifest.
* **The privacy policy still describes the iOS app** and must be rewritten
  before submission.

## 11. Where things are

| Thing | Where |
|---|---|
| Android work, and the merge | branch `android/place-handoff` |
| The one flag the Android product hangs off | `CapturePage.canMakeGuides` in `lib/main.dart` |
| Play listing copy and content declarations | `store/play/LISTING.md` |
| Play screenshots, and how to shoot them again | `store/play/screenshots/en-GB/`, `store/play/SCREENSHOTS.md` |
| Upload keystore | `Apps/Claude/Wren-Android-upload-keystore.jks`, password in Credential Manager |
| Signing configuration | `android/app/build.gradle.kts`, `android/key.properties` (git-ignored) |
| Hand-off targets, per-app intents | `lib/src/map_targets.dart` |
| File writer (GPX/KML/KMZ/CSV/GeoJSON) | `lib/src/place_export.dart` |
| Share/save bridge | `lib/src/place_share.dart`, `ShareFilePlugin.kt` |
| Everything the Android product promises, as tests | `test/android_product_test.dart` |
| The rest of the hand-off tests | `test/place_export_test.dart`, `test/place_share_test.dart`, `test/map_targets_test.dart`, and the `sending places elsewhere` group in `test/import_flow_test.dart` |
| Emulator launcher | `tools/emulator.sh` |
| CI, the Android job and its guards | `.github/workflows/ci.yml` |
| Google Play account facts | memory `project-google-play-account` |
| Everything learned about the hand-off | memory `project-reels-to-apple-maps` |

Suite is 578 tests.
