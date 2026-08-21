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
Screenshot a place, and Wren puts it in the map app you already use
```

62 characters.

## Full description (4000 characters)

```
Wren reads the places off a screenshot and puts them into the map app on your phone.

FROM A SCREENSHOT

Somebody sends you a reel, a post, a message, a page of a guidebook. Screenshot it. Wren reads the names, works out which of them are places rather than buttons and captions, and asks which city before it looks anything up.

The reading happens on your phone. Nothing is uploaded, and no picture ever leaves.

OR FROM A FILE YOU ALREADY HAVE

A saved-places export from another map app, or a Google Takeout archive. Wren reads CSV, KML, KMZ, GPX and GeoJSON, and takes its name for the list from the file.

EVERY PLACE IS YOURS TO CHECK

Wren shows what it read beside what it matched, so a wrong match is obvious rather than silent, and you can search again for anything it got wrong. Nothing is sent anywhere until you have looked at the list and chosen what to keep.

THEN HAND IT TO YOUR MAP APP

Wren writes one file and passes it to whichever app you choose. Only the apps actually installed on your phone are offered.

• Organic Maps — arrives as a named list of saved places
• OsmAnd — arrives in Favorites, after tapping "Import as favorites"
• Locus Map — arrives in My library, once you confirm the import
• Gaia GPS — needs a Gaia account, and the Waypoints layer switched on
• Mapy.com — needs a Seznam account, and a few taps to save
• Anything else on your phone, through the standard share sheet

Google Maps works differently, because Google offers no way for an app to write into a saved list. Wren saves the places as a spreadsheet, then opens Google My Maps so you can import it there yourself.

WHAT LEAVES YOUR PHONE, AND WHAT DOES NOT

The screenshot does not. The reading is done on the device.

A place name does, when Wren looks it up, because finding where a place is means asking a map. That is the only thing sent, and it is sent to the map service your phone already uses.

There is no account, no advertising and no analytics. Wren asks for one permission, to reach the network for that lookup, and none at all for your location: it never asks where you are, only where a place named in a screenshot is.

Organic Maps, OsmAnd, Locus Map, Gaia GPS, Mapy.com and Google Maps are the trademarks of their respective owners. Wren works with them; it is not affiliated with, endorsed by or connected to any of them.
```

2,345 characters, against a 4,000 limit.

---

## App content declarations (§10 of the handover)

Answered from what the app does, all of it checkable in the code.

**Data safety — a place name, and nothing else.**

Two things changed on 2026-08-20, in opposite directions, and both are worth
stating precisely because this is the answer Play holds you to.

*One thing is collected, and only if you enter a code.* No account, no
analytics, no advertising identifier. But complimentary codes **do** work on
Android as of 2026-08-21: `littlebird/identity` is implemented, so entering a
code sends **the code and a random identifier for this installation** to Wren's
own Cloudflare Worker, which is how a code can be used once and not again. A
code that also grants administrative access is re-confirmed about once a day,
which is what makes such a code withdrawable.

Under Play's taxonomy that is *Device or other IDs*, **collected**, not shared
with anyone else, required for the feature rather than optional, and not used
for advertising or tracking. It is not collected at all for anybody who never
enters a code — which is almost everybody, since codes go to named people.

The identifier is random and derived from nothing: not `ANDROID_ID`, not the
advertising id, nothing about the hardware or the account. It also does **not**
survive reinstalling, unlike the iPhone version, which keeps it in the Keychain
— see `IdentityPlugin.kt`.

*One thing is shared.* Turning "Dishoom Shoreditch" into a coordinate means
asking a map, and the platform geocoder answers over the network. So a **place
name** is sent, to the map service the phone already uses, at the moment the
user asks for a lookup. Under Play's taxonomy this is closest to *App activity
— other user-generated content*, sent but not collected, and required for the
app to function rather than optional.

*The screenshot never leaves.* The text recognition runs on the device from a
model inside the bundle. Say this plainly on the listing; it is the question
anybody will actually have.

The app declares exactly one permission, INTERNET, and CI proves that against
the built manifest rather than the source. It is needed twice over now: the
geocoder, and the code server. There is deliberately **no location
permission**: Wren never asks where the phone is, only where a place named in a
screenshot is.

The Google Maps route is worth a note if the form allows one: the app saves a
file through the system's own save dialog, then asks Android to open
`https://www.google.com/maps/d/` in a browser. That request is the browser's,
in the user's own session, and Wren uploads nothing.

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
