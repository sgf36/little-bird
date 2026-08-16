# Little Bird

*A little bird told me.* Turns screenshots of Instagram reels into Apple Maps
guides — the places people tell you about, kept somewhere you'll find them.

> **This repository is public.** It is public deliberately, so GitHub Actions
> minutes are free. Nothing sensitive may exist as a file here — a commit is a
> disclosure.
>
> That is a narrower rule than it sounds. **CI secrets are fine**: repository
> secrets are encrypted, never printed in logs, and not exposed to pull requests
> from forks, so signing certificates and the App Store Connect key live there
> safely. The Maps Server API key does not belong here at all — it lives in the
> Cloudflare Worker, which is why `MapsServerResolver` calls an endpoint rather
> than signing a JWT in the app.
>
> Never commit: `.p8`, `.p12`, `.pem`, provisioning profiles, `.env` files, or
> personal reel screenshots. All are gitignored, and the **No credentials
> committed** CI job fails the build if one slips through anyway.

Scaffold only — the pipeline is wired end to end, but place resolution is a stub
until a Maps Server API key exists.

## Why Flutter, given the target is iOS

There is no Mac on this project. Flutter runs on Windows, so the list screens,
the picker and the confirmation flow all hot-reload locally; only the iOS build
needs a macOS CI runner. Native Swift would be the better choice with a Mac and
is the worse one without.

Exactly one Swift file exists — `ios/Runner/AppDelegate.swift`, which bridges
Vision for OCR. It has no interface, so it never needs a simulator.

## What is proven and what is not

| Piece | State |
|---|---|
| Guide-link encoding | **Verified.** Tests assert byte-for-byte against links opened on a physical iPhone that populated real guides. |
| OCR | **Measured** at 25/25 on graded synthetic frames using Vision `.accurate`. Real reel typography is untested. |
| Chrome filtering / place picking | Heuristic. Tested against a realistic line set, but the "largest text wins" rule comes from frames we authored. |
| Resolution | **Stubbed.** `StubResolver` returns real, device-verified place ids so the rest of the app runs. |
| Share extension | Not built. Deliberately deferred — it is the riskiest config item and cannot be debugged without a device. |

## The two rules that matter

Both were learned by getting them wrong:

1. **Every place must carry an Apple place ID** (`I` + 16 hex digits). A guide
   payload built from coordinates renders perfectly on `maps.apple.com` and
   opens with **zero places** in the Maps app. Browser testing gives a false
   pass.
2. **Guides cannot be merged or appended to.** A guide link always creates a new
   guide, even when the name matches one already saved, and there is no read
   access to what the user has. Treat Apple Maps as an output device, not as
   storage — and never build anything that claims to "sync".

One place therefore publishes as a place card, where *Add to Guide* can append
to an existing guide. Several places can only become a new guide.

## Layout

```
lib/src/guide_link.dart   protobuf encoder, base64, chunking at 50
lib/src/ocr.dart          method channel + chrome filtering
lib/src/resolver.dart     PlaceResolver interface, stub and Maps Server stub
ios/Runner/AppDelegate.swift   the Vision bridge, the only Swift here
```

## Running it

```bash
flutter test
```

Everything above the platform channel is pure Dart and runs on Windows. The app
itself needs an iOS device: OCR returns `OcrUnavailable` anywhere else.

## Next

1. Mint a Maps identifier and a `.p8` key, confirm `/v1/search` returns `I`+hex
   place ids, then implement `MapsServerResolver` against the Cloudflare Worker
   so the key never ships in the app.
2. Put ten real reel screenshots through Vision and see whether real typography
   behaves like the synthetic fixtures.
3. Add the share extension, once the loop above is trusted.
4. Turn on the TestFlight job in CI — without a Mac, that is the device-testing
   loop.

## A local annoyance

The project lives in OneDrive, which intermittently locks `build/` and
`ios/Flutter/ephemeral/` mid-build. If Flutter reports it "failed to delete a
directory", delete the folder and re-run. Excluding those two paths from
OneDrive sync avoids it.
