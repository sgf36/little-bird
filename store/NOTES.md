# Notes on the store listings

## There is no metadata_en_US.json

Apple refuses an en-US localisation for this app: another app already holds the
name "Wren" in that storefront, and the refusal covers the whole localisation,
not just the name. The US therefore falls back to the primary locale, en-GB —
the same language, so nothing is lost but a handful of spellings.

zh-Hans hit the same wall and is handled the other way, with a distinct name in
that file, because there the fallback would have served Simplified Chinese
readers an English page.

## Locales Apple does not have

Several near-misses look like they ought to exist and do not: no en-IE, no
de-AT, no fr-BE, no nl-BE, no es-AR. Dutch is one listing, nl-NL, and it serves
Belgium too.

The locales Apple accepts are exactly the metadata_*.json files beside this one,
plus the absent en-US above.

## The in-app-purchase strings are the tightest thing here

Name 30 characters, description 45. The purchase unlocks **two** things now —
guides over three places, and adding to a guide the user already has — and Apple
reviews the description against what the purchase actually does, so naming only
the size cap is not an option.

Thirty characters does not fit both ideas in every language. Where it does not,
the rule applied was: go **general and true** rather than specific and
incomplete. Russian is the clearest case — `путеводитель` alone is twelve
characters, so every two-part phrasing ran 31–33, and the name became
`Wren без ограничений` ("without limits") with the specifics carried by the
44-character description.

Two fields sit at exactly the cap and have zero headroom. `push_metadata.py`
tests `len(value) > cap`, so 30 passes, but anything added to them breaks the
push:

- `hu` → `inAppPurchase.name` (30/30)
- `sk` → `inAppPurchase.name` (30/30)
- `fi` and `th` → `subtitle` (30/30), both pre-existing

## Screenshots are per-locale now

`store/shoot.py` writes `screenshots/<locale>/APP_IPHONE_67/`, and
`push_screenshots.py` prefers that over the shared `screenshots/APP_IPHONE_67/`.

`--all` uploads only locales that have a set **of their own**. It deliberately
does not copy the shared set to every locale: a locale with no set inherits the
primary language's on Apple's side, so an explicit copy would just be forty more
things to keep in step.

## These files were reformatted

They used to carry a blank line between top-level keys. Re-serialising with
`indent=2` removed those, so the diff from the 2026-08-17 listing update touches
every line of most files even where the text did not change. Nothing was lost;
`subtitle` and `promotionalText` are byte-identical.
