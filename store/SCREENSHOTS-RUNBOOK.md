# Screenshots runbook — read this before changing `shoot.py`

Six failure modes have cost about three hours of runner time between them, on
17 August 2026. **Every single one reported success at the layer that was
checked.** That is the theme of this document, and the reason it is worth its
length: none of these were caught by the thing that was supposed to catch them.

    python store/shoot.py                     # all ten languages
    python store/shoot.py --locale en-GB      # one, ~12 minutes
    python store/shoot.py --verbose           # every simctl command and output
    gh workflow run screenshots.yml --ref main -f verbose=true

The artifact is the point of a default run. **A green job proves the checks ran,
not that the screenshots are good.** Open the images before any of them reaches a
public product page.

---

## 1. `SIMCTL_CHILD_WREN_SCENE` does not arrive. Use the file.

**Symptom.** All sixty-four screenshots were the app's "no scene called" screen
with an **empty** name.

**Why it was hard.** `simctl launch` is documented to pass `SIMCTL_CHILD_*`
variables to the app with the prefix stripped. It was passed correctly. It
arrived as nothing, on a freshly-created iOS 26 simulator.

**Proven, not assumed.** The app logs one line per launch, read back off the
device log by `app_log()`:

    WREN-SHOTS scene="01-the-list" env WREN_SCENE=not set | file /Users/…

`env WREN_SCENE=not set` while the file route delivered the scene. The
environment route is dead here; it is still passed in case a future Xcode
restores it, and the app reports which route fed it either way.

**The load-bearing route** is `store/shoot.py` writing the scene into the app's
own tmp directory, found on the host with `simctl get_app_container <udid>
<bundle> data`. `Directory.systemTemp` in Dart is `TMPDIR`, which iOS sets
itself, so this route depends on nothing being passed in.

**Do not "simplify" this back to one route.**

## 2. A frame can be the home screen, and it is not flat.

**Symptom.** Four zh-Hans frames byte-identical. Every launch had a fresh PID and
the app logged the correct scene each time; it had not come to *front* when the
shutter fired. Scenes 03 and 04 escaped because they open the keyboard.

**The trap.** All four measured **72% one colour** — comfortably inside the 0.92
flatness threshold, because a wallpaper is not flat. Flatness catches a white
pre-first-frame; it cannot catch a photograph of iOS.

**What caught it** was the byte-identical check, which ran at the *end* of the
locale, after six images were taken. Duplication now triggers a retake at capture
time, on the same ladder as flatness. A frame identical to an earlier one in the
same locale is not two scenes rendering alike; it is a photograph of something
that is not the app.

## 3. The Maps shot cannot be produced in a simulator. This is settled.

**Symptom.** `07-in-apple-maps.png` passed its check and was a photograph of
**Safari** — a location prompt over Safari's onboarding tooltip.

**Why the check passed.** It compared the frame against a baseline and concluded
"the guide opened" because the two differed. A difference test can only say two
frames are not the same. It cannot say what is in either of them.

**Measured, both forms, all ten languages:**

| URL form | Result |
| --- | --- |
| `maps://guide?_col=…` | Maps opens and **does not change**, delta 0.0 — the payload is ignored |
| `https://maps.apple.com/guide?_col=…` | Goes to **Safari**. Maps does not claim the domain in a simulator |

`running()` now asks launchd which app is up, so a Safari frame is rejected
whatever the pixels did. Each language gets **six** screenshots; Apple accepts
one to ten. The link itself works on a real device — that is device-verified and
unaffected. Do not spend another run trying to make this work in a simulator
without new evidence that Apple has changed the association.

## 4. Xcode 26 ships no 6.7-inch iPhone.

The App Store's largest iPhone slot is `APP_IPHONE_67` at 1290×2796. There is no
`APP_IPHONE_69` — confirmed against the live API. The macos-26 lineup measures
1320×2868, 1260×2736, 1206×2622 and 1170×2532, so **no available device satisfies
the slot natively**.

`boot_simulator()` has three routes: a device that already shoots an accepted
size; a 6.7-inch device *type* Xcode knows but has not instantiated (this is the
one that works — `simctl create` an **iPhone 16 Plus**, which shoots 1290×2796);
and failing both, the largest device with a LANCZOS downscale that refuses more
than 1% aspect drift. Never hardcode a device list: an earlier one named six
devices, none of which existed on macos-26.

## 5. Python buffers stdout into a pipe.

A thirty-one minute run emitted its entire output in one burst at the end, every
line stamped the same second. There was no watching it and no telling how far it
got. `say()` is line-buffered with an elapsed stamp, and the workflow runs
`python -u`. Keep both.

## 6. The paywall price must come from Apple, never from arithmetic.

**Symptom.** `Unlock for $4.99` in all ten languages. A simulator has no store
connection, so the app fell back to its advertised dollar figure — correct in the
United States and wrong on every other storefront the screenshot appears on.

**Do not convert.** Apple's price points are set per market. A dollar figure
times an exchange rate is a fabrication that looks like a fact.
`store/iap_prices.py` reads Apple's own price schedule and writes
`store/shot_prices.json`, committed so a run needs no credentials. Formatting is
CLDR via babel — symbol, placement, separators and digit count all differ across
this list.

    python store/iap_prices.py            # show them
    python store/iap_prices.py --write    # regenerate after a price change

**Regenerate this whenever the IAP price changes.** A locale with no price is
named in the log and again in the summary rather than quietly shipping dollars.

**The limit, stated plainly.** An App Store screenshot locale is a **language,
not a storefront**. The `hi` set is shown to every Hindi-language device — in
India, but equally in the UK or the UAE, where the price differs. So each
language is mapped to the storefront most of its buyers buy from: right for most
viewers, wrong for some, and better than a dollar figure that is wrong for all of
them. Apple states the true price on the product page and again in the purchase
sheet.

`bn-BD` is mapped to **India deliberately**. Apple sells no paid content in
Bangladesh and the API returns no price for BGD at all, so every Bengali-reading
viewer who can buy this is buying from another storefront. That is a decision,
not a fallback — do not "fix" it to BGD.

---

## Verified prices, 17 August 2026

| Locale | Price | Locale | Price |
| --- | --- | --- | --- |
| en-GB | £4.99 | ar-SA | 19.99 ر.س. |
| zh-Hans | ¥38.00 | bn-BD | ₹499.00 |
| hi | ₹499.00 | pt-BR | R$ 29,90 |
| es-ES | 5,99 € | ru | 449,00 ₽ |
| fr-FR | 5,99 € | id | Rp89.000,00 |

## Checking a run

1. `gh run download <id> -n screenshots` and **open the images**.
2. Every image 1290×2796, none above 0.92 one colour, no two identical within a
   locale. The workflow's "Measure every frame" step tabulates this.
3. Read the paywall shot in **every** language: a wrong currency, a fallback to
   dollars, or a truncated button is invisible to every automated check here.
   Cropping the button out of all ten and stacking them into one strip takes a
   few seconds and shows the lot at once.
4. Cross-check the price the log says it fed each locale against what the image
   shows.

## Timings

One locale is about twelve minutes, most of it the Flutter build. Ten is about
forty-six. The first bad frame of the first locale aborts the run, because the
alternative — measured — is thirty-one minutes to produce sixty-four copies of
one failure. Re-shooting a single failed locale and merging it into a good set is
legitimate **only** when the app code is unchanged between the two runs; check
`git diff` covers nothing but `store/`.
