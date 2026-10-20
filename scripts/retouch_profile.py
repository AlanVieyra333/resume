#!/usr/bin/env python3
"""
Retoque profesional y recomposicion de la foto de perfil.

Entrada inmutable : profile-original.jpg
Salidas           : profile.jpg                  (1086x1086 -> la que usa el CV)
                    linkedin/profile-linkedin.jpg (1200x1200 -> subida a LinkedIn)

El pipeline no altera la geometria del rostro: solo toca exposicion, color,
textura, contorno del pelo y encuadre. Lo que exige un modelo generativo
(saco, corte de pelo, sonrisa) queda fuera y se documenta en
linkedin/foto-perfil.md.

Uso:  python3 scripts/retouch_profile.py [--debug]
"""

import os
import sys

from PIL import Image, ImageChops, ImageDraw, ImageEnhance, ImageFilter

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(ROOT, "profile-original.jpg")
OUT_CV = os.path.join(ROOT, "profile.jpg")
OUT_LI = os.path.join(ROOT, "linkedin", "profile-linkedin.jpg")
DEBUG_DIR = os.path.join(ROOT, "out")

DEBUG = "--debug" in sys.argv

# --- geometria medida sobre el original (px, 1086x1086) -------------------------
EYE_L = (388, 412, 478, 492)        # ojo izquierdo de la imagen
EYE_R = (608, 412, 706, 492)        # ojo derecho de la imagen
FOREHEAD = (360, 195, 720, 350)     # frente: brillo de zona T
NOSE = (492, 425, 600, 615)         # puente y punta de la nariz
CHEEK_L = (300, 545, 495, 715)      # mejilla izquierda de la imagen
CHEEK_R = (700, 545, 880, 715)      # mejilla derecha de la imagen
MOUSTACHE = (440, 645, 655, 725)    # sombra de bigote
CHIN = (420, 725, 700, 900)         # barba del menton
GOATEE = (455, 875, 660, 975)       # perilla
CREST = (300, 20, 800, 150)         # cresta superior del pelo (el "picor")

# lienzo y recomposicion
CANVAS_CV = 1086
CANVAS_LI = 1200
SCALE_CV = 0.88
SCALE_LI = 0.972
OFFSET_CV = (65, 130)
OFFSET_LI = (72, 144)

BG_TOP = (250, 250, 251)            # #FAFAFB
BG_BOTTOM = (233, 235, 238)         # #E9EBEE


# ---------------------------------------------------------------- utilidades
def ellipse_mask(size, box, feather=60):
    """Mascara suave (0-255) de una elipse con bordes difuminados."""
    m = Image.new("L", size, 0)
    ImageDraw.Draw(m).ellipse(box, fill=255)
    return m.filter(ImageFilter.GaussianBlur(feather))


def blend(base, layer, mask):
    """Combina dos imagenes con una mascara (255 = layer)."""
    return Image.composite(layer, base, mask)


def luma(img):
    return img.convert("L")


def debug_save(img, name):
    if not DEBUG:
        return
    os.makedirs(DEBUG_DIR, exist_ok=True)
    img.convert("RGB").save(os.path.join(DEBUG_DIR, name))


# ------------------------------------------------------------- 1. matte
def background_mask(im, thresh=10):
    """
    Mascara del fondo por inundacion desde las dos esquinas superiores.

    La camisa blanca es indistinguible del fondo por color, pero la sombra
    difusa de los hombros la separa: la inundacion se detiene ahi y la camisa
    queda dentro del sujeto. Verificado: la mascara no toca el interior de la
    camisa ni la cara.
    """
    masks = []
    for seed in [(0, 0), (im.width - 1, 0)]:
        t = im.copy()
        ImageDraw.floodfill(t, seed, (255, 0, 255), thresh=thresh)
        r, g, b = t.split()
        m = ImageChops.multiply(
            ImageChops.multiply(
                r.point(lambda v: 255 if v > 240 else 0),
                g.point(lambda v: 255 if v < 20 else 0),
            ),
            b.point(lambda v: 255 if v > 240 else 0),
        )
        masks.append(m)
    return ImageChops.lighter(masks[0], masks[1])


def bg_level_field(im, bgmask):
    """
    Nivel de blanco real del fondo por fila (de 253 arriba a 240 abajo).
    Se usa para deshacer el halo JPEG: sin el, el pelo deja un aro claro
    sobre la banda oscura del CV.
    """
    l = luma(im)
    lp, mp = l.load(), bgmask.load()
    levels = []
    for y in range(im.height):
        total = count = 0
        for x in range(0, im.width, 3):
            if mp[x, y]:
                total += lp[x, y]
                count += 1
        levels.append(total // count if count else 250)
    col = Image.new("L", (1, im.height))
    col.putdata(levels)
    return col.resize(im.size, Image.BILINEAR)


def build_subject_layer(im, bgmask):
    """
    Devuelve (rgb, alpha) del sujeto con el halo disuelto.

    En la banda de 4 px alrededor de la silueta, el pixel es una mezcla
    (a * color_real + (1-a) * fondo). Se recupera el color real mezclando
    hacia el minimo local (el pelo) y se calcula la cobertura a para que el
    borde quede suave y sin halo.
    """
    w, h = im.size
    lp = luma(im).load()
    rp, gp, bp = im.split()
    rpx, gpx, bpx = rp.load(), gp.load(), bp.load()
    mp = bgmask.load()

    band = bgmask.filter(ImageFilter.MaxFilter(5))
    band = ImageChops.subtract(band, bgmask)
    bp_band = band.load()

    minf = ImageFilter.MinFilter(5)
    minr = rp.filter(minf).load()
    ming = gp.filter(minf).load()
    minb = bp.filter(minf).load()

    bgl = bg_level_field(im, bgmask).load()

    out_rgb = im.copy()
    orp = out_rgb.load()
    alpha = Image.new("L", (w, h), 0)
    ap = alpha.load()

    for y in range(h):
        for x in range(w):
            if mp[x, y]:               # pixel de fondo -> transparente
                continue
            if not bp_band[x, y]:    # interior del sujeto -> opaco
                ap[x, y] = 255
                continue
            # banda: fringe contra fondo
            lv = lp[x, y]
            ml = min(minr[x, y], ming[x, y], minb[x, y])
            bg = bgl[x, y]
            span = max(bg - ml, 1)
            a = (bg - lv) / span
            if a < 0:
                a = 0.0
            elif a > 1:
                a = 1.0
            # mezcla hacia el color real del sujeto (minimo local)
            wgt = (lv - ml - 40) / 60.0
            wgt = 0.0 if wgt < 0 else (1.0 if wgt > 1 else wgt)
            if wgt > 0:
                orp[x, y] = (
                    int(rpx[x, y] * (1 - wgt) + minr[x, y] * wgt),
                    int(gpx[x, y] * (1 - wgt) + ming[x, y] * wgt),
                    int(bpx[x, y] * (1 - wgt) + minb[x, y] * wgt),
                )
            ap[x, y] = int(a * 255)

    debug_save(alpha, "profile-alpha.png")
    return out_rgb, alpha


def drop_flyaways(alpha, keep_radius=13):
    """
    Elimina pelos sueltos aislados contra el fondo sin tocar los mechones
    que crecen de la cabeza: se conserva solo lo que esta a menos de
    `keep_radius` px del cuerpo solido del sujeto.
    """
    solid = alpha.filter(ImageFilter.MinFilter(7))          # erosion: nucleo
    keep = solid.filter(ImageFilter.MaxFilter(keep_radius))  # dilatacion
    return ImageChops.multiply(alpha, keep)


# ------------------------------------------------------------- 2. retoque
def retouch(im):
    """Retoque de piel, barba, pelo, ojos y camisa. Trabaja en RGB opaco."""
    w, h = im.size
    l = luma(im)

    # 2.1 brillo de zona T: se comprimen las altas luces de frente y nariz.
    #     El peso sigue a la propia alta luz (no a un parche), asi que no queda
    #     marca de mascara.
    lut = []
    for v in range(256):
        lut.append(v if v <= 195 else int(195 + (v - 195) * 0.45))
    compressed = im.point(lut * 3)
    tz = ImageChops.lighter(
        ellipse_mask(im.size, FOREHEAD, 150), ellipse_mask(im.size, NOSE, 110)
    )
    hot = l.point(lambda v: 0 if v <= 188 else min(255, int((v - 188) * 14)))
    im = blend(im, compressed, ImageChops.multiply(tz, hot).point(lambda v: int(v * 0.7)))

    l = luma(im)

    # 2.2 barba: menos contraste, pero sin borrarla (si se borra, sale mancha)
    beard = ImageChops.lighter(
        ellipse_mask(im.size, MOUSTACHE, 40),
        ImageChops.lighter(
            ellipse_mask(im.size, CHIN, 50), ellipse_mask(im.size, GOATEE, 35)
        ),
    )
    beard = beard.point(lambda v: int(v * 0.55))
    softened = im.filter(ImageFilter.MedianFilter(5))
    im = blend(im, softened, beard)

    # 2.3 piel de las mejillas: se iguala el tono sin borrar la textura
    even = im.filter(ImageFilter.MedianFilter(3))
    cheeks = ImageChops.lighter(
        ellipse_mask(im.size, CHEEK_L, 120), ellipse_mask(im.size, CHEEK_R, 120)
    )
    im = blend(im, even, cheeks.point(lambda v: int(v * 0.18)))

    # 2.4 modelado: dodge en pómulo y menton, burn en los laterales de la cara
    dodge = ImageChops.lighter(
        ellipse_mask(im.size, (330, 570, 470, 700), 70),
        ellipse_mask(im.size, (620, 570, 760, 700), 70),
    )
    dodge = ImageChops.lighter(dodge, ellipse_mask(im.size, (470, 790, 620, 900), 70))
    lift = dodge.point(lambda v: int(v * 4 / 255)).convert("RGB")
    im = ImageChops.add(im, lift)

    burn = ImageChops.lighter(
        ellipse_mask(im.size, (255, 330, 330, 700), 70),
        ellipse_mask(im.size, (790, 330, 870, 700), 70),
    )
    drop = burn.point(lambda v: int(v * 4 / 255)).convert("RGB")
    im = ImageChops.subtract(im, drop)

    # 2.5 pelo: definicion de mechones (unsharp solo sobre el pelo)
    hair = Image.new("L", im.size, 0)
    hp = hair.load()
    lp = l.load()
    for y in range(0, 900, 2):
        for x in range(0, w, 2):
            if lp[x, y] < 105 and 220 < x < 870:
                hp[x, y] = 255
    hair = hair.filter(ImageFilter.GaussianBlur(2))
    sharp = im.filter(ImageFilter.UnsharpMask(radius=2, percent=70, threshold=0))
    im = blend(im, sharp, hair.point(lambda v: int(v * 0.55)))

    # 2.6 cresta superior: se baja el contraste del "picor" (no la forma)
    crest = ellipse_mask(im.size, CREST, 60)
    soft = im.filter(ImageFilter.GaussianBlur(2))
    im = blend(im, soft, crest.point(lambda v: int(v * 0.12)))

    # 2.7 ojos: nitidez selectiva
    eyes = ImageChops.lighter(
        ellipse_mask(im.size, EYE_L, 18), ellipse_mask(im.size, EYE_R, 18)
    )
    eye_sharp = im.filter(ImageFilter.UnsharpMask(radius=1.4, percent=55, threshold=0))
    im = blend(im, eye_sharp, eyes.point(lambda v: int(v * 0.75)))

    # 2.8 camisa: menos arrugas, un punto mas de brillo
    shirt = Image.new("L", im.size, 0)
    sp = shirt.load()
    for y in range(900, h):
        for x in range(w):
            r, g, b = im.getpixel((x, y))
            if r > 215 and g > 215 and b > 215 and max(r, g, b) - min(r, g, b) < 14:
                sp[x, y] = 255
    shirt = shirt.filter(ImageFilter.GaussianBlur(2))
    pressed = im.filter(ImageFilter.MedianFilter(5))
    im = blend(im, pressed, shirt.point(lambda v: int(v * 0.35)))
    im = ImageChops.add(im, shirt.point(lambda v: int(v * 5 / 255)).convert("RGB"))

    # 2.9 color: un punto de saturacion (los neutros no se mueven)
    im = ImageEnhance.Color(im).enhance(1.035)
    im = ImageEnhance.Contrast(im).enhance(1.025)

    return im


# ------------------------------------------------------------- 3. composicion
def gradient_canvas(size):
    """Fondo de estudio: gris neutro con degradado vertical, sin horizonte."""
    top = Image.new("RGB", (1, 1), BG_TOP)
    bottom = Image.new("RGB", (1, 1), BG_BOTTOM)
    strip = Image.new("RGB", (1, size[1]))
    sp = strip.load()
    for y in range(size[1]):
        t = y / max(size[1] - 1, 1)
        sp[0, y] = (
            int(BG_TOP[0] + (BG_BOTTOM[0] - BG_TOP[0]) * t),
            int(BG_TOP[1] + (BG_BOTTOM[1] - BG_TOP[1]) * t),
            int(BG_TOP[2] + (BG_BOTTOM[2] - BG_TOP[2]) * t),
        )
    return strip.resize(size, Image.BILINEAR)


def compose(subject_rgb, alpha, canvas_size, scale, offset):
    """Pega el sujeto escalado sobre el degradado, pegado al borde inferior."""
    layer = subject_rgb.copy()
    layer.putalpha(alpha)
    new_size = (int(round(subject_rgb.width * scale)), int(round(subject_rgb.height * scale)))
    layer = layer.resize(new_size, Image.LANCZOS)
    canvas = gradient_canvas(canvas_size)
    canvas.paste(layer, offset, layer)
    return canvas


def export(img, path, quality=94):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    img.convert("RGB").save(
        path, "JPEG", quality=quality, subsampling=0, optimize=True, progressive=False
    )
    print(f"  {os.path.relpath(path, ROOT)}  {img.width}x{img.height}")


# ------------------------------------------------------------------- main
def main():
    if not os.path.exists(SRC):
        sys.exit(f"falta {SRC}")

    print("1. matte del sujeto")
    original = Image.open(SRC).convert("RGB")
    bgmask = background_mask(original)
    subject, alpha = build_subject_layer(original, bgmask)
    alpha = drop_flyaways(alpha)
    debug_save(subject, "profile-subject.png")

    print("2. retoque")
    retouched = retouch(subject)

    print("3. composicion")
    cv = compose(retouched, alpha, (CANVAS_CV, CANVAS_CV), SCALE_CV, OFFSET_CV)
    li = compose(retouched, alpha, (CANVAS_LI, CANVAS_LI), SCALE_LI, OFFSET_LI)

    print("4. exportacion")
    export(cv, OUT_CV)
    export(li, OUT_LI)


if __name__ == "__main__":
    main()
