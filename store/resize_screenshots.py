"""Resize device screenshots to a size App Store Connect accepts.

    python store/resize_screenshots.py

Reads store/screenshots/source/ and writes store/screenshots/APP_IPHONE_67/.

Why this exists: an iPhone 16 Pro shoots 1206x2622, and Apple rejects that with
`IMAGE_INCORRECT_DIMENSIONS`. The API's largest iPhone slot is APP_IPHONE_67 —
there is no APP_IPHONE_69 in the enum, whatever the browser shows — and it
wants 1290x2796.

Scaled rather than padded. The aspect ratios differ by 0.3% (0.4600 against
0.4614), which is invisible, whereas padding would put a green border around
the phone screen and look like a mistake. LANCZOS, because the images are flat
colour and text, where a cheaper filter shows.
"""
import pathlib
import sys

from PIL import Image

HERE = pathlib.Path(__file__).resolve().parent
# Prefer the status-bar-cleaned copies when they exist, so the pipeline is
# clean -> resize -> upload and the originals are never edited in place.
CLEANED = HERE / "screenshots" / "cleaned"
SRC = CLEANED if CLEANED.is_dir() else HERE / "screenshots" / "source"
OUT = HERE / "screenshots" / "APP_IPHONE_67"
TARGET = (1290, 2796)


def main():
    if not SRC.is_dir():
        sys.exit(f"put the originals in {SRC}")
    OUT.mkdir(parents=True, exist_ok=True)

    files = sorted(SRC.glob("*.png"))
    if not files:
        sys.exit(f"no PNGs in {SRC}")

    for f in files:
        with Image.open(f) as im:
            before = im.size
            if before == TARGET:
                im.save(OUT / f.name, "PNG")
                print(f"  {f.name:<28} already {TARGET[0]}x{TARGET[1]}")
                continue
            ratio_in = before[0] / before[1]
            ratio_out = TARGET[0] / TARGET[1]
            # Refuse anything that would visibly stretch. A landscape shot or
            # an iPad capture dropped in here should stop, not be squashed.
            if abs(ratio_in - ratio_out) / ratio_out > 0.02:
                print(f"  {f.name:<28} SKIPPED — aspect {ratio_in:.4f} is too "
                      f"far from {ratio_out:.4f} to rescale honestly")
                continue
            im.convert("RGB").resize(TARGET, Image.LANCZOS).save(
                OUT / f.name, "PNG", optimize=True)
            print(f"  {f.name:<28} {before[0]}x{before[1]} -> "
                  f"{TARGET[0]}x{TARGET[1]}")

    print(f"\nwritten to {OUT}")


if __name__ == "__main__":
    main()
