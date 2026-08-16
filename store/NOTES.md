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
