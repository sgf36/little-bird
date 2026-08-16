"""Render the Wren mark to a 1024px master icon.

A wren is identifiable from two features and not much else: the tail held
cocked vertically, and a thin, slightly downcurved beak. Everything here serves
those two — a plump body, an alert raised head, no wing detail to muddy the
silhouette at thumbnail size, and a pale eyebrow stripe because a real wren has
a prominent one.

The mark is defined once on a 100x100 grid, and the same geometry is mirrored in
web/index.html. Drawn at 4x and downsampled so the curves stay clean.

No transparency, no rounded corners: iOS applies its own mask and a pre-rounded
icon gets rounded twice.
"""
from PIL import Image, ImageDraw
import pathlib

S = 1024
SS = 4
GRID = 100

TEAL = (30, 75, 69)         # #1E4B45  ground
GOLD = (242, 200, 121)      # #F2C879  bird
CLAY = (224, 138, 75)       # #E08A4B  beak
CREAM = (248, 238, 218)     # #F8EEDA  eyebrow stripe

# --- the mark, in grid units -------------------------------------------------
# The tail is SHORT and FANNED — about two thirds of the body's height, wider at
# the tip than the base. Parallel sides read as a plank; a fan reads as feathers.
# No eyebrow stripe: a real wren has a prominent one, but at 60px it turns into a
# bandage across the head, and the silhouette is doing the identifying anyway.
# Tail springs from the rump with a broad base, so it belongs to the bird rather
# than being propped against it. Body is an oval rather than a circle — longer
# than tall — and the head is smaller and held high, which is the alert posture
# wrens actually hold. Whole mark centred on the grid.
TAIL  = [(22, 62), (12, 29), (24, 23), (31, 50)]
BODY  = (42, 60, 23, 17)          # cx, cy, rx, ry
HEAD  = (63, 44, 12, 11.5)        # cx, cy, rx, ry — overlaps the body, no snowman gap
BEAK  = [(74, 42), (89, 46), (74, 48)]
EYE   = (67, 41, 2.3)

def draw(d, scale):
    def p(v):
        return scale(v)
    d.polygon([(p(x), p(y)) for x, y in TAIL], fill=GOLD)
    cx, cy, rx, ry = BODY
    d.ellipse([p(cx - rx), p(cy - ry), p(cx + rx), p(cy + ry)], fill=GOLD)
    hx, hy, hrx, hry = HEAD
    d.ellipse([p(hx - hrx), p(hy - hry), p(hx + hrx), p(hy + hry)], fill=GOLD)
    d.polygon([(p(x), p(y)) for x, y in BEAK], fill=CLAY)
    ex, ey, er = EYE
    d.ellipse([p(ex - er), p(ey - er), p(ex + er), p(ey + er)], fill=TEAL)

out = pathlib.Path(__file__).resolve().parent.parent / "assets" / "icon"
out.mkdir(parents=True, exist_ok=True)

# --- master icon ------------------------------------------------------------
img = Image.new("RGB", (S * SS, S * SS), TEAL)
draw(ImageDraw.Draw(img), lambda v: v * S * SS / GRID)
img = img.resize((S, S), Image.LANCZOS)
master = out / "app_icon.png"
img.save(master, "PNG")
print(f"wrote {master.name}  ({master.stat().st_size:,} bytes, {S}x{S})")

# --- Android adaptive foreground -------------------------------------------
# Adaptive icons get cropped to a circle, so the bird sits at 60% inside the
# safe zone on a transparent layer.
fg = Image.new("RGBA", (S * SS, S * SS), (0, 0, 0, 0))
draw(ImageDraw.Draw(fg), lambda v: (v - 50) * 0.60 * S * SS / GRID + S * SS / 2)
fg = fg.resize((S, S), Image.LANCZOS)
fgp = out / "app_icon_foreground.png"
fg.save(fgp, "PNG")
print(f"wrote {fgp.name}  ({fgp.stat().st_size:,} bytes)")

# --- thumbnail proof --------------------------------------------------------
# The silhouette has to survive 60px, which is where an unclear bird stops
# reading as any particular bird at all.
for size in (180, 120, 60):
    img.resize((size, size), Image.LANCZOS).save(out / f"preview_{size}.png", "PNG")
print("wrote preview_180.png, preview_120.png, preview_60.png")

# A contact sheet so all three sizes can be judged together.
sheet = Image.new("RGB", (420, 200), (245, 243, 240))
x = 20
for size in (180, 120, 60):
    sheet.paste(img.resize((size, size), Image.LANCZOS), (x, 20 + (180 - size) // 2))
    x += size + 20
sheet.save(out / "preview_sheet.png", "PNG")
print("wrote preview_sheet.png")
