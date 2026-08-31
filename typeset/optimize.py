#!/usr/bin/env python3
"""Compact a PDF in place without altering the marks it makes on the page.

Four transforms, each a no-op for the rendered result. The text-showing
operators are rewritten (zero kerns dropped, adjacent kerns summed, adjacent
glyph strings joined, a lone string folded to Tj), a text font operator
repeating the one in force is dropped, positional operands are rounded to a
thousandth of a point, and every stream is re-deflated with zopfli. The font
programs, the text layer, the metadata and the annotations are carried over
untouched; the file stays ISO 32000-2.

Usage: optimize.py <file.pdf>. The original is kept where the result is not
smaller, and where pikepdf or zopfli is absent the file is left alone.
"""
import os
import re
import sys
import zlib

# A decimal operand: not part of a name, a key, or a longer token.
NUMBER = re.compile(rb'(?<![0-9A-Za-z_./#-])-?(?:\d+\.\d+|\.\d+)(?![0-9A-Za-z])')
# A text-showing array. Hex strings hold no ']', so the first one closes it.
ARRAY = re.compile(rb'\[([^\]]*)\]\s*TJ')
ELEMENT = re.compile(rb'<([0-9A-Fa-f]*)>|(-?[\d.]+)')
SETFONT = re.compile(rb'(/[^\s/]+)\s+([\d.]+)\s+Tf')
# Operators after which the font in force is no longer known.
BARRIER = (b'q', b'Q', b'BT', b'ET')


def shorten(token, places):
    value = round(float(token), places)
    text = f'{value:.{places}f}'.rstrip('0').rstrip('.')
    return (text if text not in ('', '-', '-0') else '0').encode()


def round_operands(buf, places):
    """Round decimal operands, leaving ( ) and < > strings as they are."""
    out, run, i, n = bytearray(), bytearray(), 0, len(buf)

    def flush():
        if run:
            out.extend(NUMBER.sub(lambda m: shorten(m.group(0), places), bytes(run)))
            run.clear()

    while i < n:
        c = buf[i:i + 1]
        if c == b'(':
            flush()
            j, depth = i + 1, 1
            while j < n and depth:
                if buf[j:j + 1] == b'\\':
                    j += 2
                    continue
                depth += (buf[j:j + 1] == b'(') - (buf[j:j + 1] == b')')
                j += 1
            out.extend(buf[i:j])
            i = j
        elif c == b'<' and buf[i + 1:i + 2] != b'<':
            flush()
            j = buf.find(b'>', i)
            j = n if j < 0 else j + 1
            out.extend(buf[i:j])
            i = j
        else:
            run.extend(c)
            i += 1
    flush()
    return bytes(out)


def fold_array(match):
    """Normalize one text-showing array. Kerns keep six significant digits:
    shorter ones perturb the word breaks a text extractor infers."""
    parts = []
    for hexstr, number in ELEMENT.findall(match.group(1)):
        if number:
            value = float(number)
            if not value:
                continue
            if parts and isinstance(parts[-1], float):
                parts[-1] += value
            else:
                parts.append(value)
        elif hexstr:
            if parts and isinstance(parts[-1], bytes):
                parts[-1] += hexstr
            else:
                parts.append(hexstr)
    while parts and isinstance(parts[-1], float):
        parts.pop()                       # A trailing kern moves nothing.
    if not parts:
        return b''
    if len(parts) == 1:
        return b'<' + parts[0] + b'>Tj'
    body = b''.join(b'<' + p + b'>' if isinstance(p, bytes) else b'%g' % p
                    for p in parts)
    return b'[' + body + b']TJ'


def drop_repeat_setfont(buf):
    lines, held = [], None
    for line in buf.split(b'\n'):
        token = line.strip()
        found = SETFONT.fullmatch(token)
        if found:
            if (found.group(1), found.group(2)) == held:
                continue
            held = (found.group(1), found.group(2))
        elif token in BARRIER or token.endswith((b' gs', b' cm')):
            held = None
        lines.append(line)
    return b'\n'.join(lines)


def compact(buf, places=3):
    return drop_repeat_setfont(ARRAY.sub(fold_array, round_operands(buf, places)))


def redeflate(pikepdf, path):
    """Re-deflate every flate stream with zopfli, in place."""
    import zopfli.zlib
    pdf = pikepdf.open(path, allow_overwriting_input=True)
    for obj in pdf.objects:
        if not isinstance(obj, pikepdf.Stream):
            continue
        if obj.get('/Filter') != pikepdf.Name('/FlateDecode'):
            continue
        raw = obj.read_raw_bytes()
        try:
            plain = zlib.decompress(raw)
        except zlib.error:
            continue
        packed = zopfli.zlib.compress(plain, numiterations=15)
        if len(packed) < len(raw):
            obj.write(packed, filter=pikepdf.Name('/FlateDecode'))
    pdf.save(path, object_stream_mode=pikepdf.ObjectStreamMode.preserve)
    pdf.close()


def main(path):
    try:
        import pikepdf
        import zopfli.zlib                                            # noqa: F401
    except ImportError as absent:
        print(f'   note: {absent.name} is absent; {path} left uncompacted.')
        return 0

    before = os.path.getsize(path)
    work = path + '.opt'
    pdf = pikepdf.open(path)
    for page in pdf.pages:
        contents = page.obj.get('/Contents')
        streams = contents if isinstance(contents, pikepdf.Array) else [contents]
        for stream in streams:
            stream.write(compact(stream.read_bytes()))
    pdf.save(work, compress_streams=True, recompress_flate=True,
             object_stream_mode=pikepdf.ObjectStreamMode.generate)
    pdf.close()
    redeflate(pikepdf, work)

    after = os.path.getsize(work)
    if after < before:
        os.replace(work, path)
        print(f'   compacted: {before:,} -> {after:,} bytes '
              f'({(after - before) / before:+.1%})')
    else:
        os.remove(work)
        print(f'   note: compaction gained nothing; {path} left as built.')
    return 0


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print(f'usage: {os.path.basename(sys.argv[0])} <file.pdf>', file=sys.stderr)
        sys.exit(2)
    sys.exit(main(sys.argv[1]))
