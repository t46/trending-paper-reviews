# /// script
# dependencies = ["pillow"]
# ///
from PIL import Image, ImageDraw, ImageFont
import os

W, H = 1200, 630
img = Image.new('RGB', (W, H), color='#fafafa')
draw = ImageDraw.Draw(img)

# Try macOS system fonts; fall back to default
def font(size, bold=False):
    candidates = [
        "/System/Library/Fonts/Helvetica.ttc",
        "/System/Library/Fonts/HelveticaNeue.ttc",
        "/Library/Fonts/Arial.ttf",
    ]
    for path in candidates:
        if os.path.exists(path):
            try:
                return ImageFont.truetype(path, size, index=1 if bold else 0)
            except Exception:
                try:
                    return ImageFont.truetype(path, size)
                except Exception:
                    pass
    return ImageFont.load_default()

title_f = font(72, bold=True)
sub_f = font(34)
desc_f = font(24)
foot_f = font(20)

def center_x(text, f):
    bbox = draw.textbbox((0, 0), text, font=f)
    return (W - (bbox[2] - bbox[0])) // 2

# Top accent bar
draw.rectangle([(0, 0), (W, 8)], fill='#0066cc')

# Title block
title = "Trending Paper Review Series"
subtitle = "Rigorous Constructive Criticism"
desc1 = "no numerical scores  ·  no accept/reject labels"
desc2 = "evidence-based analysis & actionable improvement suggestions"

draw.text((center_x(title, title_f), 200), title, fill='#1a1a1a', font=title_f)
# divider
draw.rectangle([(W//2 - 80, 305), (W//2 + 80, 308)], fill='#0066cc')
draw.text((center_x(subtitle, sub_f), 330), subtitle, fill='#444', font=sub_f)
draw.text((center_x(desc1, desc_f), 400), desc1, fill='#666', font=desc_f)
draw.text((center_x(desc2, desc_f), 432), desc2, fill='#666', font=desc_f)

# Footer attribution
foot = "t46.github.io/trending-paper-reviews"
draw.text((center_x(foot, foot_f), 560), foot, fill='#999', font=foot_f)

img.save('og-image.png', 'PNG', optimize=True)
print("WROTE og-image.png", os.path.getsize('og-image.png'), "bytes")
