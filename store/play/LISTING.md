# Play store listing — draft

Not yet entered in Play Console. Every factual claim below is either verified
on a real Android system (see the handover, §1) or is what the app itself says
in the hand-off sheet, so the two cannot drift apart.

Two rules carried over from the App Store, and one from this repository:

* **No Apple product is named anywhere.** Wren was rejected under App Store
  guideline 5.2.5 for naming Apple in its subtitle. On Play the wording would
  be irrelevant to the product in any case: there is no Apple Maps here.
* **Other companies' app names are used referentially only** — "hands the list
  to", "works with" — never in the app's own name or icon, and never in a way
  implying endorsement.
* **The claims about the five map apps match `lib/src/map_targets.dart`.** If
  a note changes there it changes here. Gaia GPS and Mapy.com were never taken
  past their own sign-in screens, so nothing below says their import succeeds.

---

## App name (30 characters)

```
Wren
```

4 characters. Left as the bare name, as on the App Store. A qualifier such as
"Wren: places to your map app" would read as a description rather than a name,
and the short description is directly beneath it.

## Short description (80 characters)

```
Turn a list of places into pins in the map app you already use
```

62 characters.

## Full description (4000 characters)

```
Wren takes a list of places you already keep and puts it into the map app on your phone.

READ A FILE YOU ALREADY HAVE

Open a saved-places export from another map app, or a Google Takeout archive. Wren reads CSV, KML, KMZ, GPX and GeoJSON. Every place it finds is listed for you first, with its name and its address, and you decide what to keep. Nothing leaves until you have looked at it.

The list arrives under whatever name the file already had, rather than one Wren made up.

HAND IT TO YOUR MAP APP

Wren writes one file and passes it to whichever app you choose. Only the apps actually installed on the phone are offered.

• Organic Maps — arrives as a named list of saved places
• OsmAnd — arrives in Favorites, after tapping "Import as favorites"
• Locus Map — arrives in My library, once you confirm the import
• Gaia GPS — needs a Gaia account, and the Waypoints layer switched on
• Mapy.com — needs a Seznam account, and a few taps to save
• Anything else on the phone, through the standard share sheet

Google Maps works differently, because Google offers no way for an app to write into a saved list. Wren saves the places as a spreadsheet, then opens Google My Maps so you can import it there yourself. It takes a few more taps, and it is the route Google leaves open.

FREE, AND PRIVATE BECAUSE IT HAS TO BE

Wren is free. There is no account, no advertising and no analytics, and it collects nothing.

It also asks for no permissions at all, which you can check on this page. It needs none: the file you open, the list you edit and the file it writes never leave the phone until you hand them to another app yourself. The only thing that ever reaches the internet is your own browser, if you choose the Google Maps route and it opens My Maps for you.

Organic Maps, OsmAnd, Locus Map, Gaia GPS, Mapy.com and Google Maps are the trademarks of their respective owners. Wren works with them; it is not affiliated with, endorsed by or connected to any of them.
```

1,974 characters, against a 4,000 limit.

---

## App content declarations (§10 of the handover)

Answered from what the app does, all of it checkable in the code.

**Data safety — no data collected and no data shared.**

This is a stronger answer than the handover expected, and it changed on
2026-08-20. The handover said two things left the device: a place name sent to
the map provider, and a complimentary-access code with a random device
identifier. Neither happens on Android:

* There is no map lookup. Place search is MapKit, which is Apple's.
* The complimentary code cannot be redeemed. The device identifier it is issued
  against comes from the `littlebird/identity` channel, which has no Android
  implementation, so `comp.redeem` returns "unreachable" before it opens a
  socket. The entry point is hidden on Android in any case.
* Guide links are gone from the add menu, so nothing expands a link either.

The released app declares **no permissions**, which CI proves against the built
manifest rather than the source. Verified by installing the signed release APK
and reading `dumpsys package`.

The Google Maps route is worth declaring plainly if the form allows a note: the
app saves a file through the system's own save dialog, and then asks Android to
open `https://www.google.com/maps/d/` in a browser. The request is the
browser's, in the user's own session, and Wren uploads nothing.

**Content rating.** IARC questionnaire. No violence, no user-generated content,
no communication features, no gambling, no purchases. A utility.

**Target audience.** Not directed at children.

**Ads.** None.

**Government, news, financial or health app.** None of these.

**Privacy policy URL.** <https://wren.spencerfields.com/privacy.html> —
**this needs rewriting before submission.** It is written for the iOS app: it
describes Apple Maps lookups and the App Store privacy label, neither of which
applies here, and it does not say that the Android build collects nothing at
all. A page that under-describes the app is a smaller problem than one that
describes a different app.
