# Test files for the "From a file" importer

Nine files, one per thing that can go wrong. Every one is checked by
`test/testdata_test.dart` through the same two functions the phone uses, so if
one of these misbehaves on the device the fault is in the app rather than in the
file — which is the point of checking them here.

These files are inside OneDrive, so they should already be on the phone: open the
**Files** app → **Browse** → OneDrive → `Apps/Claude/wren/testdata`. Wren's
picker reads from the same place.

All the London places are real, with real coordinates, so a wrong match is
obvious on the map rather than merely plausible in a list.

| File | What it is | What should happen |
|---|---|---|
| `1-google-my-maps.csv` | A Google My Maps export. One name contains a comma: `Nando's, Soho` | **6 places.** If quoting failed, every later column shifts and the coordinates come out wrong |
| `2-google-takeout.csv` | Google Takeout saved places: a Maps URL and **no coordinate columns at all** | **5 places**, each aimed correctly — the coordinate can only have come from inside the URL |
| `3-addresses-and-gaps.csv` | Addresses, no coordinates, then two rows with a street and no name, then one blank line | **5 places** and **"2 rows had no name"**. Three would be wrong: the blank line is a blank line, not a skipped row |
| `4-excel-utf16.csv` | UTF-16, which is what Excel writes as soon as a sheet holds a non-Latin-1 character | **2 places: Fuunji and Café Oto.** Fuunji is in **Tokyo** on purpose — it proves each row is aimed at its own coordinate rather than at one region for the whole file. If it resolves in London, that is a bug |
| `5-borough-market.kml` | KML, coordinates **longitude first**, one name wrapped in CDATA | **5 places around Borough Market.** If latitude and longitude were swapped they land in the Indian Ocean |
| `6-borough-market.kmz` | The same KML zipped, with a PNG alongside it, as Google Earth actually exports | **Identical to file 5.** The image must be ignored, not treated as the data |
| `7-walk.gpx` | GPX, where coordinates are XML **attributes** rather than element text | **5 places** |
| `8-places.geojson` | GeoJSON, also longitude first, with a collection name | **5 places**, and `London, October` offered as the guide name |
| `9-not-a-place-list.txt` | Prose | **Refused**, with a message naming the formats that do work. Not a crash, and not an empty list |

## Also worth trying

**Rename one.** Call `6-borough-market.kmz` something ending `.kml`, or
`8-places.geojson` something ending `.csv`. Both should still import — the
importer sniffs the content, because Takeout genuinely ships GeoJSON in files
named `.csv`.

**A file with nothing Wren can use.** Any photo or PDF should be refused the same
way as file 9.

**Back out of the picker.** Tap Cancel. Nothing should appear, no error message,
and the **Add** button should be usable again rather than stuck on "Reading…".

## Testing "From an existing guide"

Best done with one of your own guides: open it in Apple Maps → Share → Copy Link
→ in Wren, **Add** → **From an existing guide** → paste.

If you want a known-good link to start with, this one holds five Borough Market
places and is what the CI screenshot run uses:

```
https://maps.apple.com/guide?_col=Cg9Mb25kb24sIE9jdG9iZXISIwiuTRC1rNetnKaJ%2FUMaACoSRGlzaG9vbSBTaG9yZWRpdGNoEiAIrk0QkZCou9m6u69lGgAqD1dyaWdodCBCcm90aGVycxIaCK5NEOKh1v2l7pj%2FlAEaACoIRWxsaW90J3MSGAiuTRD2vP7rzMqx31IaACoHQXJhYmljYRIdCK5NEOC79q2J9ry9ExoAKgxCbGFjayAmIEJsdWU%3D
```

Regenerate it with `dart run tool/guide_link.dart` if the fixtures change. It is
generated rather than typed because it is a base64 protobuf — the first
hand-written one was plausible, wrong, and would have opened an empty guide.
