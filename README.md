# Kurt programming language standard specification

Kurt is a low-level, general-purpose programming language.

KPLSS defines the form and semantics of Kurt programmes. It does not specify any particular programme, how source text is obtained, how opaque code is combined for execution, how a translated programme is invoked, or the capacity limits of a data-processing system.

Each edition is in its own `M.N/` directory.

## Document encoding

These documents are encoded as UTF-8 over the Universal Coded Character Set (ISO/IEC 10646), formatted as text/markdown; variant=CommonMark (IETF RFC 7763, RFC 7764).

## Build

    typeset/build.sh [-h] [-K M.N] [pdf] [paper] [html] [markdown]

Output goes to `dist/`. Without `-K`, every edition is built; without a manifestation, all four are.

Needs a POSIX (ISO/IEC/IEEE 9945:2026) shell, pandoc 3.8 or later, Python 3.14 or later, and WeasyPrint.

Optional: pikepdf and zopfli (PDF compaction), fontTools (HTML font subsetting).

## Licence

This specification is licensed under [크리에이티브 커먼즈 저작자표시 4.0 국제 공중 라이선스](https://creativecommons.org/licenses/by/4.0/) (CC BY 4.0).

See `LICENCE` for the full text.
