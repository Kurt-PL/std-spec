#!/bin/sh
# Embed the fonts build.sh uses into ./fonts/.embed/, from the sources in ./fonts/.
# A variable source is instanced to a fixed weight; a static source is copied.
# build.sh runs this every build; a silent no-op once the instances exist.
set -eu

HERE=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SRC="$HERE/fonts"
OUT="$SRC/.embed"

# "<source> <wght> <instance> [scale] [rise]" per line. <wght> is "-" for a
# static source. <scale> shrinks the instance, <rise> lifts it in em units.
SPECS="EBGaramond-VF.ttf 400 EBGaramond-Regular
EBGaramond-VF.ttf 700 EBGaramond-Bold
EBGaramondItalic-VF.ttf 400 EBGaramond-Italic
EBGaramondItalic-VF.ttf 700 EBGaramond-BoldItalic
SourceCodePro-VF.ttf 400 SourceCodePro-Regular
SourceCodePro-VF.ttf 700 SourceCodePro-Bold
NotoSerif-VF.ttf 400 NotoSerif-Regular
NotoSerif-VF.ttf 700 NotoSerif-Bold
Garamond-Math.otf - Garamond-Math
GyeonggiBatang-Regular.otf - GyeonggiBatang-Regular 0.8 0.1
GyeonggiBatang-Bold.otf - GyeonggiBatang-Bold 0.8 0.1"

# An instance keeps its source's extension.
ext() { case "$1" in *.otf) echo otf ;; *) echo ttf ;; esac; }

# No-op when every instance is already present.
all=1
while read -r src wght out scale rise; do
  [ -n "${out:-}" ] || continue
  [ -f "$OUT/$out.$(ext "$src")" ] || all=0
done <<EOF
$SPECS
EOF
[ "$all" -eq 1 ] && exit 0

# Instancing needs Python and its fontTools; the cached run above reaches
# neither, so the probe stands here. Running the interpreter is the probe: a
# name that resolves to a launcher stub passes a mere lookup.
if python3 -c 'import sys' >/dev/null 2>&1; then
  python3 -c 'import fontTools' >/dev/null 2>&1 \
    || { echo "error: required tool 'Python fontTools' not found." >&2; exit 1; }
else
  echo "error: required tool 'Python' not found." >&2
  exit 1
fi

mkdir -p "$OUT"

echo "-> embedding fonts into $OUT"
while read -r src wght out scale rise; do
  [ -n "${out:-}" ] || continue
  dst="$OUT/$out.$(ext "$src")"
  [ -f "$dst" ] && continue
  [ -f "$SRC/$src" ] || { echo "error: font source '$src' is absent from $SRC." >&2; exit 1; }
  if [ "$wght" = "-" ]; then
    cp "$SRC/$src" "$dst"
  else
    python3 -m fontTools.varLib.instancer "$SRC/$src" "wght=$wght" -o "$dst" >/dev/null
  fi
  [ -z "${scale:-}" ] || python3 -c 'import sys
from fontTools.ttLib import TTFont
from fontTools.pens.t2CharStringPen import T2CharStringPen
from fontTools.pens.transformPen import TransformPen
from fontTools.pens.ttGlyphPen import TTGlyphPen
p,s,r=sys.argv[1],float(sys.argv[2]),float(sys.argv[3])
f=TTFont(p); u=f["head"].unitsPerEm; gs=f.getGlyphSet()
t=(s,0,0,s,0,r*u)
if "CFF " in f:
    td=f["CFF "].cff.topDictIndex[0]; cs=td.CharStrings; priv=td.FDArray[0].Private
    for gn in f.getGlyphOrder():
        adv=f["hmtx"][gn][0]
        pen=T2CharStringPen(round(adv*s), None)
        gs[gn].draw(TransformPen(pen, t))
        c=pen.getCharString(private=priv); c.private=priv; cs[gn]=c
        f["hmtx"][gn]=(round(adv*s), round(f["hmtx"][gn][1]*s))
else:
    glyf=f["glyf"]
    for gn in f.getGlyphOrder():
        adv=f["hmtx"][gn][0]
        pen=TTGlyphPen(gs)
        gs[gn].draw(TransformPen(pen, t))
        glyf[gn]=pen.glyph()
        f["hmtx"][gn]=(round(adv*s), round(f["hmtx"][gn][1]*s))
f.save(p)' "$dst" "$scale" "${rise:-0}"
  echo "   $out.$(ext "$src")"
done <<EOF
$SPECS
EOF
echo "-> done."
