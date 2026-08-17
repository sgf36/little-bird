"""Remove the "◀ TestFlight" / "◀ Safari" label from captured screenshots.

    python store/clean_status_bar.py

That label is the iOS status bar's back-affordance, not part of Wren, and it
marks a shot as a beta capture. Removing it is tidying, not misrepresentation:
nothing the app draws is touched.

How, and why not something cleverer: the label sits in the top-left over the
app's flat background, so the honest fix is to sample the colour just below it
and fill the rectangle. No blur, no clone brush, no inpainting — on a flat
ground those all produce a smudge that is more obvious than the text was.

A shot whose top-left is *not* flat (the Apple Maps one, where a map is behind
it) is refused rather than fudged. Painting a fake patch over a map would be
visible and would be the kind of edit that misrepresents.
"""
import pathlib
import sys

from PIL import Image

HERE = pathlib.Path(__file__).resolve().parent
SRC = HERE / "screenshots" / "source"
OUT = HERE / "screenshots" / "cleaned"

# The label occupies roughly the left third of the second status-bar line on a
# 1206-wide capture. Generous on all sides; the fill is the background colour,
# so overshooting costs nothing on a flat ground.
BOX = (0, 96, 430, 148)

# Sampled from directly beneath the label, so a theme change cannot make this
# stale. Compared against every pixel in the box to decide whether it is flat.
FLATNESS = 12


def flat_enough(im, box):
    """Is the area under the label a single colour, within tolerance?"""
    patch = im.crop(box).convert("RGB")
    colours = patch.getcolors(maxcolors=1 << 20) or []
    if not colours:
        return False, None
    colours.sort(reverse=True)
    _, dominant = colours[0]
    for count, c in colours:
        if max(abs(a - b) for a, b in zip(c, dominant)) > FLATNESS:
            return False, dominant
    return True, dominant


def main():
    if not SRC.is_dir():
        sys.exit(f"no originals in {SRC}")
    OUT.mkdir(parents=True, exist_ok=True)

    for f in sorted(SRC.glob("*.png")):
        with Image.open(f) as im:
            im = im.convert("RGB")
            # Scale the box if the capture is a different width.
            scale = im.width / 1206
            box = tuple(round(v * scale) for v in BOX)
            # Sample a strip below the label rather than inside it.
            sample = (box[0] + 4, box[3] + 6, box[2], box[3] + 30)
            ok, colour = flat_enough(im, sample)
            if not ok:
                im.save(OUT / f.name, "PNG", optimize=True)
                print(f"  {f.name:<28} LEFT ALONE — not a flat background "
                      f"there, painting it would show")
                continue
            im.paste(colour, box)
            im.save(OUT / f.name, "PNG", optimize=True)
            print(f"  {f.name:<28} label removed, filled {colour}")

    print(f"\nwritten to {OUT}")


if __name__ == "__main__":
    main()
