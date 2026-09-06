# Kurt programming language

A low-level general-purpose programming language.

## Ethos

`ETHOS` states the fixed principles of the Kurt programming language.

## Scope

This specification defines the form of programmes written in the Kurt programming language and establishes the interpretation of such programmes.

It defines:

— the syntax and semantics of Kurt source text;

— the translation and execution of conforming programmes;

— the constraints imposed by a conforming implementation.

It does not specify:

— any programme written in the language it defines;

— the mechanism by which source text is obtained;

— the mechanism by which the opaque code produced by translation is combined for execution;

— the mechanism by which a translated programme is invoked;

— the capacity limits of any data-processing system.

## Document encoding

These documents are encoded as UTF-8 over the Universal Coded Character Set (ISO/IEC 10646), formatted as text/markdown; variant=CommonMark (IETF RFC 7763, RFC 7764).

## Conformance

A **programme** is Kurt source text composed of the constructs defined in this specification. A **conforming programme** is a programme that the grammar of this specification admits and that satisfies every requirement this specification imposes on the programme. A **source unit** is the text submitted for translation at one time.

A **conforming implementation** satisfies all of the following:

— It supports a mode of operation in which every conforming programme is accepted.

— For every conforming programme, every execution the implementation exhibits of it is an execution the programme admits. An implementation need not exhibit every such execution.

— It rejects every source unit that contains a translation failure, and issues a diagnostic that identifies the violated requirement.

— It documents every implementation-defined behaviour.

## Licence

This specification is licensed under [크리에이티브 커먼즈 저작자표시 4.0 국제 공중 라이선스](https://creativecommons.org/licenses/by/4.0/) (CC BY 4.0).

See `LICENCE` for the full text.
