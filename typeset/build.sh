#!/bin/sh
# Typeset the Kurt specification. Usage: ./build.sh [pdf] [paper] [html] [markdown] (default: all).
set -eu

HERE=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT=$(dirname "$HERE")
cd "$ROOT"

# Required external tools. Each one is probed by running it — a name that
# resolves to a launcher stub passes a mere lookup — and every absent one is
# named before the build aborts.
missing=""
lacking=""
absent() { missing="${missing:+$missing
}$1"; }
spare()  { lacking="${lacking:+$lacking
}$1"; }

# Name a newline-separated list of tools, agreeing the noun in number.
report() {
  printf '%s\n' "$2" | awk -v head="$1" -v tail="$3" '
    { name[NR] = $0 }
    END {
      for (i = 1; i <= NR; i++)
        list = list (i == 1 ? "" : (i == NR ? " and " : ", ")) "\047" name[i] "\047"
      printf "%s %s %s not found%s\n", head, (NR == 1 ? "tool" : "tools"), list, tail
    }'
}

pandoc --version     >/dev/null 2>&1 || absent "pandoc"
weasyprint --version >/dev/null 2>&1 || absent "weasyprint"
python3 -c 'import sys' >/dev/null 2>&1 || absent "Python"

if [ -n "$missing" ]; then
  report "error: required" "$missing" "." >&2
  exit 1
fi

# optimize.py compacts the PDF through these two, and passes the file through
# untouched without them. Their absence costs size alone, so it is a warning.
python3 -c 'import pikepdf'    >/dev/null 2>&1 || spare "pikepdf"
python3 -c 'import zopfli.zlib' >/dev/null 2>&1 || spare "zopfli"

[ -z "$lacking" ] || report "warning: optional" "$lacking" "; the PDF is left uncompacted." >&2

# --syntax-highlighting arrived in pandoc 3.8; the render below passes it.
pandoc --syntax-highlighting=none -f markdown -t html </dev/null >/dev/null 2>&1 \
  || { echo "error: pandoc 3.8 or later is required for '--syntax-highlighting'." >&2; exit 1; }

# The version directory "M.N" is the sole identity input.
SRC=""
for d in [0-9]*.[0-9]*/; do [ -d "$d" ] && SRC="${d%/}"; done
[ -n "$SRC" ] || { echo "error: no version directory 'M.N' found." >&2; exit 1; }
ver=$SRC
M=${ver%%.*}; N=${ver#*.}
base="Kurt $ver"
OUT="dist"

maintitle="Kurt programming language standard specification"

# Spell a positive integer as an English ordinal (1 -> first, 111 -> one hundred eleventh).
ordinal() {
  awk -v n="$1" '
    function card(x,a){split("zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen",a," ");return a[x+1]}
    function tens_c(x,a){split("- - twenty thirty forty fifty sixty seventy eighty ninety",a," ");return a[x+1]}
    function ord1(x,a){split("zeroth first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth thirteenth fourteenth fifteenth sixteenth seventeenth eighteenth nineteenth",a," ");return a[x+1]}
    function tens_o(x,a){split("- - twentieth thirtieth fortieth fiftieth sixtieth seventieth eightieth ninetieth",a," ");return a[x+1]}
    function ord2(m){if(m<20)return ord1(m);if(m%10==0)return tens_o(int(m/10));return tens_c(int(m/10)) "-" ord1(m%10)}
    function ordn(x,h){if(x<100)return ord2(x);h=int(x/100);if(x%100==0)return card(h) " hundredth";return card(h) " hundred " ord2(x%100)}
    BEGIN{print ordn(n)}'
}

# Edition designation per §0. "refinement" mirrors §0 — rename in both if §0 changes it.
if [ "$M" -eq 0 ]; then
  ed_name="preliminary edition $N"
  ed_disp="Preliminary edition $N"
  ed_art="the preliminary edition $N"
else
  ord=$(ordinal "$M")
  if [ "$N" -eq 0 ]; then ed_name="the $ord edition"; else ed_name="the $ord edition, $(ordinal "$N") refinement"; fi
  ed_disp=$(printf '%s' "$ed_name" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')
  ed_art="$ed_name"
fi
edition="$ed_disp"

# Two-line cover break at the word nearest the midpoint.
maintitle_disp=$(printf '%s' "$maintitle" | awk '{n=length($0);half=n/2;cum=0;bi=NF-1;best=2*n;for(i=1;i<NF;i++){cum+=length($i)+1;d=cum-half;if(d<0)d=-d;if(d<best){best=d;bi=i}}out=$1;for(i=2;i<=NF;i++)out=out (i-1==bi?"<br>":" ") $i;print out}')

# Issue instant "$SRC/.issued": absent = not issued; malformed = build error.
ISS="$SRC/.issued"
today=$(date +%Y-%m-%d)
if [ -f "$ISS" ]; then
  iss=$(tr -d '\r\n' < "$ISS")
  printf '%s\n' "$iss" | grep -Eq \
    '^[0-9]{4}-[0-9]{2}-[0-9]{2} ([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]$' \
    || { echo "error: $ISS: malformed issue instant: '$iss'" >&2; exit 1; }
  date=${iss%% *}
  awk -v d="$date" 'BEGIN{
    split(d,a,"-"); y=a[1]+0; m=a[2]+0; dd=a[3]+0
    dm=(m==2) ? (y%4==0 && (y%100!=0 || y%400==0) ? 29 : 28) \
       : (m==4 || m==6 || m==9 || m==11) ? 30 : 31
    exit !(m>=1 && m<=12 && dd>=1 && dd<=dm)}' \
    || { echo "error: $ISS: invalid calendar date: '$date'" >&2; exit 1; }
  year=${date%%-*}
  # ISO 8601 sorts lexicographically.
  draft=$(awk -v a="$date" -v b="$today" 'BEGIN{print (a>b)?1:0}')
  if [ "$draft" -eq 1 ]; then
    kicker="Draft Standard"
    issline="To be issued $date"
    foreword="This document is a draft of $ed_art of the $maintitle (henceforth: this specification), to be issued $iss; the text herein is provisional and subject to change."
  else
    kicker="Normative Standard"
    issline="Issued $date"
    foreword="This document is $ed_art of the $maintitle (henceforth: this specification), issued $iss."
  fi
else
  kicker="Maintainer’s Draft"
  date=""
  year=${today%%-*}
  issline="Not issued"
  foreword="This document is the maintainer’s draft of $ed_art of the $maintitle (henceforth: this specification), not issued; it has no standing as a measure of conformance, and the text herein is provisional and subject to change."
fi

"$HERE/fonts.sh"

mkdir -p "$OUT"

if [ "$#" -eq 0 ]; then MEDIUMS="pdf paper html markdown"; else MEDIUMS="$*"; fi

# Introduction, body clauses, then lettered annexes. Headings are inside the files.
BODY="$SRC/#intro.md"
[ -f "$BODY" ] || { echo "error: introduction '$BODY' not found." >&2; exit 1; }
for f in "$SRC"/[0-9][0-9].md "$SRC"/[a-z].md; do [ -f "$f" ] && BODY="$BODY $f"; done

# -tex_math_dollars: '$' is a Kurt sigil, not TeX math.
PANDOC="-f markdown+ascii_identifiers-tex_math_dollars-smart-citations-markdown_in_html_blocks -t html4 --syntax-highlighting=none"
TPL="$HERE/template.html"

render() {
  pandoc $BODY $PANDOC --toc --toc-depth=2 --template="$TPL" \
    -V maintitle="$maintitle" -V maintitledisp="$maintitle_disp" -V edition="$edition" \
    -V kicker="$kicker" -V date="$date" -V year="$year" -V issline="$issline" \
    -V foreword="$foreword" -V colophon="$colophon" -o "$1"
}

for medium in $MEDIUMS; do
  echo "-> $medium"
  case "$medium" in
    paper)    label="Paper";    colophon="This document is printed on paper." ;;
    pdf)      label="PDF";      colophon="This document is formatted as ISO 32000-2:2020 (PDF 2.0), with embedded fonts conforming to ISO/IEC 14496-22 (Open Font Format)." ;;
    html)     label="HTML";     colophon="This document is formatted as HTML 4.01 Strict (W3C Recommendation REC-html401-19991224) and Cascading Style Sheets Level 2 Revision 1 (W3C Recommendation REC-CSS2-20110607), encoded as UTF-8 over the Universal Coded Character Set (ISO/IEC 10646), with embedded fonts conforming to ISO/IEC 14496-22 (Open Font Format)." ;;
    markdown) label="Markdown"; colophon="This document is encoded as UTF-8 over the Universal Coded Character Set (ISO/IEC 10646), formatted as text/markdown; variant=CommonMark (IETF RFC 7763, RFC 7764)." ;;
    *)        echo "error: unknown manifestation '$medium' (use paper|pdf|html|markdown)." >&2; exit 1 ;;
  esac

  case "$medium" in
    markdown)
      out="$OUT/$base $label.md"
      {
        printf '# %s — %s\n\n' "$maintitle" "$ed_name"
        printf '# Foreword\n\n%s\n\n' "$foreword"
        printf '**Colophon.** %s\n\n' "$colophon"
        for f in $BODY; do cat "$f"; printf '\n\n'; done
      } > "$out"
      echo "   ok: $out"
      ;;
    html)
      hdir="$OUT/$base $label"
      rm -rf "$hdir"; mkdir -p "$hdir/fonts"
      cp "$HERE/style.css" "$hdir/style.css"
      cp "$HERE"/fonts/.embed/* "$hdir/fonts/"
      render "$hdir/index.html"
      chars="$hdir/.chars"
      python3 -c 'import re,sys;open(sys.argv[2],"w",encoding="utf-8").write(re.sub(r"<[^>]+>"," ",open(sys.argv[1],encoding="utf-8").read()))' "$hdir/index.html" "$chars"
      for f in "$hdir"/fonts/*.ttf "$hdir"/fonts/*.otf; do
        python3 -m fontTools.subset "$f" --text-file="$chars" --output-file="$f" --layout-features='*' >/dev/null 2>&1 || true
      done
      rm -f "$chars"
      echo "   ok: $hdir/"
      ;;
    *)
      tmp="$HERE/.$medium.html"
      css="$HERE/.$medium.css"
      render "$tmp"
      # The stylesheet addresses the fonts as an HTML manifestation ships them;
      # here they are read from where fonts.sh embeds them.
      sed 's|url("fonts/|url("fonts/.embed/|g' "$HERE/style.css" > "$css"
      sed "s|\"./style.css\"|\"./.$medium.css\"|" "$tmp" > "$tmp.link" && mv "$tmp.link" "$tmp"
      pdf="$OUT/$base $label.pdf"
      weasyprint --pdf-version 2.0 "$tmp" "$pdf"
      rm -f "$tmp" "$css"
      # Compact the page streams, holding the text layer and ISO 32000-2.
      python3 "$HERE/optimize.py" "$pdf"
      echo "   ok: $pdf"
      ;;
  esac
done
