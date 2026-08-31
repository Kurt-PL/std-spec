# §E. Editorial rules

This annex is meta-normative. It governs the drafting of the body clauses of this specification — §1 through §10 — in this and in future editions; it does not constrain programmes or implementations. A violation of a meta-normative rule is an editorial defect, not a technical one. An editorial defect that does not alter the technical meaning of a normative clause is not grounds for an erratum.

## E.1 Principles

This specification is both a specification and a standard. The two words are not synonyms; they name different properties of the same document, and each property imposes its own discipline on the way the document is written.

***standard*** /ˈstændəd/ — a unit of measurement that is officially used; an official rule used when producing something *(Oxford Learner’s Dictionary)*

A standard is a **rule**. A rule does not explain itself; it applies. A rule that must be defended before it can be followed is not a rule but a proposal. Every sentence in this document that defends, softens, or qualifies a rule in response to an anticipated objection is treating the rule as a proposal.

A standard is **official** — it is the one authority in its domain. It does not share authority with other documents, other languages, or prior versions of itself. A standard that defers to another authority for part of its content has ceded that part of its domain. Where this specification depends on an external standard for a precise definition, that dependency is declared, bounded, and isolated; it does not propagate.

A standard is **a unit** — singular and consistent. The same concept has one name. The same kind of rule appears in the same form. Variation for stylistic purposes is not style; it is ambiguity.

A standard is used **when producing**. It is a reference consulted at the point of use, not a narrative read from beginning to end. It must be self-contained at every point of entry. A reader who arrives at any clause must find everything needed to apply that clause; what they knew before arriving is not part of the specification.

From these four properties:

— **Sovereignty** — this specification is the sole and self-sufficient authority on the Kurt programming language. No rule is left to be supplied by another document, language, or system.

— **Self-trust** — a rule stated here is complete where it is stated. It does not require defence, justification, or preemptive clarification. If a rule is unclear, it shall be rewritten, not annotated.

— **Consistency** — the same concept bears the same name throughout. The same kind of rule appears under the same heading. Variation for stylistic purposes is an editorial defect.

— **Non-redundancy** — each rule is stated once, at the point where it is defined. Subsequent clauses refer to it by description.

***specification*** /ˌspesɪfɪˈkeɪʃn/ — a detailed description of how something is, or should be, designed or made *(Oxford Learner’s Dictionary)*

A specification is a **description**. It does not argue, persuade, or justify; it describes. A description that argues is not describing more carefully — it is doing something else. Every sentence in this document that is not a description of the language is a foreign body.

A specification describes how something **is**. It is not a record of how the language came to be, how it differs from what it was, or how it compares to what it is not. The language exists; the specification describes it. What the specification does not describe does not exist. The absence of a description is itself a description — of absence.

A specification is **detailed**. A description that admits two readings is not detailed; it is incomplete. Precision is not a virtue here but a minimum condition of the description being a description at all.

From these three properties:

— **Declarativity** — normative text states what a construct is, what it does, or what an implementation shall do. Reason, advice, evaluation, and history are not descriptions of the language.

— **Precision** — a sentence that admits two interpretations describes two languages. It is a defect.

— **Economy** — every sentence that is not a description of the language is not part of the specification. It shall not be there.

— **Supersession by omission** — the specification does not enumerate what it has not described. Absence from the text is the description of absence.

— **Temporal closure** — the specification describes what the language is. It does not describe what changed, what was reconsidered, or what a future edition may address.

The principles above are not independent axioms to be weighed against one another. They are consequences of what this document is. An editor who finds a sentence that violates one of them has found a sentence that is, in the relevant respect, not part of the specification.

## E.2 Sentence discipline

Every normative sentence in this specification states what a construct is, what it does, or what an implementation shall do.

Prohibited patterns are organized under five categories. A sentence that falls under any category is prohibited, and a sentence may fall under more than one.

The prohibitions below apply to all text in the body clauses of this specification, except where a subclause below states otherwise. Informative text shall not contain a normative obligation unless that obligation is already stated explicitly in the normative body.

Code appearing in code form within an Example block is not subject to these prohibitions. Code is not prose; it demonstrates the language as it is used. Comment text within the code, and the prose surrounding it, may name whatever the example needs named and may take whatever form demonstrates the language best; it shall not take a term’s meaning from outside this specification.

### Extraneous concept

A sentence imports an extraneous concept when it relies on a definition, model, or vocabulary that originates outside this specification. The specification defines its terms; it does not borrow them.

**Borrowed definition.** A sentence that uses a technical term this specification has not defined is prohibited. Terms such as *calling convention*, *stack frame*, *byte*, *compilation*, *register* carry implicit implementation models not established by this specification. Where such a concept is required, it shall be derived and named from the Kurt machine. A term may coincide with a term used elsewhere after definition; the definition is the authority, not the coincidence. Editors should seek the most technically precise term derivable from the Kurt machine rather than adopting an established name; a term defined here and then given a familiar alias is preferable to a familiar term given a belated definition.

> *The ABI of an `extern` function follows the platform calling convention.* — prohibited four times over: *ABI* and *calling convention* name what this specification calls the invocation interface; *function* names what this specification calls a subroutine; *platform* names what this specification calls the execution environment.

> *Values are stored in eight-bit bytes.* — prohibited: *byte* carries an implicit model not established here. The Kurt machine’s storage unit shall be defined and named within this specification.

**Cultural attribution.** A sentence that names a concept by its origin outside this specification is prohibited. Phrases such as *RAII pattern* or *C-style string* define by attribution. The concept shall be defined on its own terms.

> *Kurt uses a RAII-like approach to resource management.* — prohibited.

**External versioning.** A sentence whose meaning depends on the current state or version of an external document is prohibited in normative text.

> *The representation follows current POSIX conventions for signal numbers.* — prohibited.

**External contrast.** A sentence that defines a construct by comparing or contrasting it with a construct from outside this specification is prohibited. The test is whether the compared predicate originates outside this specification.

> *An indeterminate state is not undefined behaviour.* — prohibited: *undefined behaviour* is not defined in this specification; invoking it to define *indeterminate* imports the concept in order to deny it.

> *`trap` is not an exception mechanism.* — prohibited.

*Permitted.* A sentence that places a property as belonging to a system outside this specification’s concern is permitted when it delimits scope rather than defines by contrast: *the representation of this value within an external interface is determined by the platform*. Such a sentence declines to define; it does not define by negation.

### Negative narration

A sentence narrates negatively when it enters the language from outside to declare the absence of something. Direction is the criterion: the specification may declare what it does not cover; it shall not declare what Kurt does not contain.

**Construct negation.** A sentence of the form *X does not exist in Kurt*, *Kurt has no X*, or *there is no X* is prohibited. If a construct is not defined, its absence from the text is the sole statement of its non-existence. Declaring the absence imports the concept into the language in order to deny it.

> *There is no indexing operator.* — prohibited.

> *Kurt does not have exceptions.* — prohibited.

> *No implicit type conversions exist.* — prohibited.

**Design residue.** A sentence that reports or denies a design this specification once had is prohibited. An amended rule shall read as though the amended semantics had been intended from the outset. The test is whether the sentence would have been written had the present design always been the design; a sentence that answers a question only a reader of the superseded text would ask is residue.

> *Earlier revisions required a lifetime annotation on a reference type; one is no longer written.* — prohibited: the history of a rule is recorded outside the body of this specification.

> *A reference type does not name an object lifetime.* — prohibited for the reason construct negation is prohibited: the sentence imports a concept in order to deny it. What it imports here is a construct this specification itself once carried, and denying it preserves it.

**Negative-identity enumeration.** A sentence whose principal function is to list what something is not — by accumulating negations — is prohibited. When a construct’s properties are fully stated in the positive, the reader can derive what it does not do.

> *Parenthesization does not create a temporary, does not copy the value, and does not alter the expression’s semantics in any way other than grouping.* — prohibited: the rule is that a parenthesized expression has the type and value of the enclosed expression; the three negations are redundant.

*Permitted.* A sentence in the scope clause or a clause preamble that delimits the boundary of this specification is permitted. *This specification does not specify any programme written in the language it defines* declares what the specification covers, not what the language contains. The direction is outward — from the specification towards its limits — not inward from an external concept into the language.

### Self-doubt

A sentence expresses self-doubt when it reacts to an anticipated reader response: a predicted misreading, a foreseen objection, or a presumed gap in understanding. The specification does not know its readers. It does not address them.

**Preemptive clarification.** A sentence that negates an interpretation no normative text has asserted is prohibited. If a misreading is predictable, the rule shall be rewritten to exclude it; it shall not be annotated to correct it after the fact.

> *Note that indeterminacy is not undefined behaviour.* — prohibited. If the two concepts are distinct, their definitions shall make this evident without annotation.

*This is not to be confused with type widening.* — prohibited.

**Rhetorical repetition.** A sentence that restates a fact already stated in the same clause — at increased emphasis or altered phrasing — is prohibited. Repetition does not strengthen a rule; it signals that the first statement was judged insufficient.

> *`trap` does not do I/O. `trap` does not format. `trap` does not carry a message. It is a pure termination signal.* — prohibited: the rule is that `trap` takes no arguments; the four sentences are rhetorical elaboration of that single fact.

**Defensive restatement.** A sentence that reproduces a rule defined in another clause, justified by local clarity, is prohibited. A rule is stated once, at the point of its definition.

> *This constraint is inherited from `numeric`; it is restated here for clarity.* — prohibited.

**Ritual qualification.** A sentence that accompanies a defined term with its defining conditions at each use site is prohibited. A defined term carries its full definition wherever it appears; restating the conditions at the point of use is boilerplate. Naming the term and, where a cross-reference is warranted, its defining clause is sufficient.

> *A conforming implementation may reorder the evaluation of operands if and only if it can statically prove, under worst-case assumptions, that doing so preserves all signals in Σ in the same order, as required by the uniformity rule.* — prohibited: “statically prove” and “the uniformity rule” are sufficient; the qualifying phrases unpack the definitions at the use site.

**Hedged assertion.** A normative sentence qualified with *generally*, *typically*, *usually*, *in most cases*, or equivalent is prohibited. A rule either holds or it has stated exceptions; if exceptions exist, they shall be enumerated.

> *In most cases, the result type of `+@` is indeterminate.* — prohibited.

**Transitional translation.** A sentence that restates the preceding sentence in simpler terms — introduced by *in other words*, *put differently*, or *that is to say* — is prohibited. If the first statement requires translation, the first statement shall be rewritten.

> *In other words, an unmanaged reference does not carry a derivation history.* — prohibited.

**Reader address.** A sentence that addresses a hypothetical reader is prohibited. The body of this specification states the rule and does not address questions about it. Questions are answered outside this specification — in commentary, errata, or instruction.

> *One might expect `contract` to behave like a boolean expression.* — prohibited.

**Justification.** A sentence whose function is to explain why a rule exists is prohibited in normative text. If the motivation behind a design decision warrants recording, it belongs in a Design rationale block, where it carries no normative force.

> *This mutual exclusivity is what permits `!` to serve two unambiguous purposes.* — prohibited: the rule is the mutual exclusivity; the sentence adds a reason.

**Advice.** A sentence that suggests how a programmer should respond to a rule is prohibited.

> *Bind the failure payload with `else.err` when recovery logic is needed.* — prohibited.

> *Landside code should prefer type-safe alternatives.* — prohibited.

### Self-congratulation

A sentence congratulates when it evaluates the specification’s own design — positively, or as implicit contrast to alternatives not taken.

**Design evaluation.** A sentence that asserts the merit, elegance, or superiority of a design choice is prohibited. The specification defines constructs; it does not assess them.

> *This design maximizes interoperability.* — prohibited.

> *This is the standard form for FFI wrappers.* — prohibited.

**Purpose statement.** A sentence that states the intent or purpose of a design choice in normative text is prohibited. Purpose belongs in Design rationale.

> *The `airside`/`landside` distinction exists to make the boundary between safe and unsafe code visible at the call site.* — prohibited in normative text.

**Novelty claim.** A sentence that asserts a construct is new, original, or an improvement over a prior state of the art is prohibited. Such a claim defines by comparison to an external baseline the specification has not established.

### Excessive rhetoric

A sentence is rhetorically excessive when its effect is emphasis, narrative, or ceremony rather than the statement of a rule.

**Anticipatory announcement.** A sentence that announces the significance or difficulty of what follows is prohibited. A rule announces itself by its content.

> *The following constraint is of critical importance to the type system.* — prohibited.

**Narrative connective.** A sentence that frames the specification as a progression is prohibited. The specification is not a story.

> *Having established the type hierarchy, we now turn to expression semantics.* — prohibited.

**Dramatic framing.** A sentence that introduces a rule with an observation or insight is prohibited.

> *The fundamental insight behind the contract type is that polarity is a property of the type, not of the operator.* — prohibited.

### External references

References to non-language technical standards — ISO/IEC/IEEE standards, IETF RFCs, and ECMA standards other than language standards — are permitted in normative text when this specification depends on an external standard for a precise definition that cannot be stated in self-contained terms. Such a reference shall name the standard and the specific version relied upon. The number of external normative references should be minimized; where a concept from an external standard can be defined in self-contained terms, the self-contained definition is preferred.

References to language standards are absolutely prohibited in body clauses. A language standard is any specification that defines the syntax and semantics of a programming language for the purpose of programme construction, including but not limited to ISO 1538, ISO/IEC 1539, ISO/IEC 1989, ISO 6160, ISO 7185, ISO 8485, ISO/IEC 8652, ISO/IEC 9496, ISO/IEC 9899, ISO/IEC 10206, ISO/IEC 10279, ISO/IEC 10514, ISO/IEC 11756, ISO/IEC 13211, ISO/IEC 13816, ISO/IEC 14882, ISO/IEC 15145, ISO/IEC 16262, ISO/IEC 22275, ISO/IEC 23270, ISO/IEC 23271, ISO/IEC 25436, ISO/IEC 30170, IEEE 1076, IEEE 1178, IEEE 1364, IEEE 1800, ECMA-262, ECMA-334, ECMA-335, ECMA-367, ECMA-372, ECMA-408, IETF RFC 5228. The prohibition extends to indirect reference: naming a language-specific artefact — a calling convention named for a language, a representation described as originating in a language — constitutes a reference to that language.

## E.3 Notation

### Orthography

Each language edition follows the recognized standard orthography of its language. Where a language admits more than one standard, the edition designates one by chronological legitimacy — the etymologically prior form — and applies it consistently.

#### English edition

The English edition uses British English, following Oxford spelling. The Greek-derived suffix is written *-ize* / *-ization*, not *-ise* / *-isation*: *organize*, *recognize*, *normalization*. A word not formed with this suffix retains *-ise* (*comprise*, *exercise*, *otherwise*); *-yse* is retained over *-yze* (*analyse*). *programme* is correct in all contexts, including a computer programme. Elsewhere the British form is used: *behaviour*, *colour*, *defence*, *licence* (noun).

Hyphenation follows position. A compound modifier is hyphenated where it precedes what it modifies, and stands open where it follows the verb: *an implementation-defined name*, *a single-assignment binding*, *a translation-time constant*; *the name is implementation defined*, *evaluation occurs at translation time*. A modifier whose leading word is an adverb in *-ly* stands open in both positions: *a newly created object*. Nouns in sequence stand open: *execution environment*, *storage region*, *floating radix point number type*. At its definition site a term keeps the form under which it is defined, whatever its position.

### Typographical conventions

Code, keywords, and identifiers appearing in running prose are set in monospaced type: `fn`, `let`, `airside`, `trap`. Code examples use monospaced formatting. Normative syntax rules appear under the Syntax heading within each subclause.

When a term is formally defined for the first time, it is set in bold: **indeterminate state**, **faithful**, **arbitrary**. The bold form marks the definition site; subsequent uses of the term are set in regular type.

Bold marks a definition site and nothing else. A label standing at the head of a paragraph or of a list item is set in regular type, unless the label is itself the term that item defines.

Italic sets the symbols of a mathematical expression appearing in running prose: *Q*, *δ*, *T*. Within the body clauses it serves no other purpose.

### Definition discipline

Each technical term used in this specification shall have exactly one name and exactly one definition. Synonyms are prohibited: if two words could refer to the same concept, one shall be chosen and the other shall not appear. The chosen term shall be used consistently throughout; variation for stylistic purposes is an editorial defect.

A term shall be defined at most once. If the same term appears to require a second definition, the two uses denote different concepts and shall be given different names.

A definition shall appear at the first point where the term is needed. If a later clause requires a concept not yet introduced, the concept shall be defined at that earlier point, or a forward reference shall be provided with enough context for the reader to proceed.

### Lists

A **prose enumeration** is used when the items are three or fewer, short, and integrate naturally into the grammatical structure of the sentence. A colon may introduce the list; items are separated by commas or semicolons.

An **unordered list** is used when the items are independent and carry no behavioural order — properties of a type, constraints on a construct, cases of a classification. The default marker is an em dash (—) at all levels.

An **ordered list** is used when and only when the items carry behavioural order. The default labelling scheme is 1. 2. 3. at the first level; a. b. c. at the second level; i. ii. iii. at the third level. An item label may be referenced only within the list in which it appears. Where an item requires a reference from outside its list, it shall be given its own subclause.

An item of either kind may carry a label naming what the item covers. The label stands first, is set in regular type by the rule on definition sites, and is separated from the prose of the item by an em dash.

The default markers and labelling schemes above may be varied to suit the rendering environment. Variation is permitted provided it is applied consistently within that environment; inconsistency of marker style within a single environment is an editorial defect regardless of rendering cause.

An ordered list where no behavioural order exists is a false implication of sequencing and is an editorial defect. Conversely, a construct whose behavioural order is normatively significant shall not be presented as an unordered list or as prose enumeration; the order must be visible in the form.

### Attribution

The name or descriptor of the originator of a format, encoding, or convention that this specification adopts may appear in normative text as a precise identifier of the adopted work. Such an attribution does not delegate authority to the originator and does not constitute a reference to a language or external system.

## E.4 Document structure

### Clause ordering

The body clauses of this specification are ordered by semantic precedence: a clause that provides definitions on which later clauses depend is placed before those later clauses. Within each clause, subclauses are ordered by operational precedence: the constructs a programmer types first are defined first. A concept appears as a concrete, usable form before the abstract category that subsumes it is named.

A clause may name a concept defined in a later clause. When it does, it shall provide enough context that the reader can write a meaningful programme using only the material presented so far. A forward reference that leaves the reader unable to understand the clause in which it appears is an editorial defect; the referenced material shall be moved earlier or summarized at the point of reference.

### Heading depth

Heading depth is relative to the page title. The page title is the top-level heading, whatever numbering depth it occupies; the next heading level is one numbering level below the title, the one after that is two below, and so on. One heading level per one numbering level, starting from whatever depth the title occupies.

The visual hierarchy produced by this convention shall be sufficient for a reader to determine the nesting depth of any section without consulting a table of contents.

#### Examples (informative)

For example, a page titled §7. Statements and control flow:

```
# §7. Statements and control flow
## 7.1 Expression statements
## 7.2 Contract types
### 7.2.1 Polarity inversion
### 7.2.2 Logical operators
### 7.2.3 Contract extraction
## 7.3 if
### 7.3.1 else if chaining
### 7.3.2 then / else value form
### 7.3.3 if let
## 7.4 match
### 7.4.1 Exhaustiveness
### 7.4.2 Slice patterns
```

And a page titled §7.2 Contract types:

```
# §7.2 Contract types
## 7.2.1 Polarity inversion
## 7.2.2 Logical operators
## 7.2.3 Contract extraction
### 7.2.3.1 Short-circuit semantics
### 7.2.3.2 Extraction with else
```

### Subclause headings

Each subclause should use the following headings, in the order given, to separate concerns. A subclause may omit any heading that has no applicable content, present the headings in another order, or use a heading not listed here. Such departures are editorial judgements and are left to the editor’s discretion.

1. Preamble — purpose, scope, and the terms the subclause defines, carrying no heading, immediately after the subclause title.
2. Syntax — EBNF productions.
3. Static semantics — translation-time rules: type judgements, name resolution, visibility.
4. Dynamic semantics — execution-time behaviour: evaluation order, state transitions, observable effects.
5. Constraints — conditions whose violation is a translation failure; a condition that could appear under either this heading or Static semantics appears here.
6. Implementation requirements — obligations on a conforming implementation that are not constraints on the programme.
7. Implementation defined — behaviours the implementation may choose.
8. Examples (informative) — illustrative code, free-form as to platform, external name, and commentary style, subject to the rule on borrowed definitions.
9. Design rationale (informative) — motivation for the design choice.
10. Notes (informative) — supplementary remarks.
11. Numbered sub-subclauses — last.

Where Notes restate the rules of their subclause in symbols, the symbols shall state those rules and no others. The prose is the rule and the symbols are a second reading of it; a difference between them is an editorial defect, to be repaired in whichever of the two is wrong.

### Cross-references

Normative text shall not cite clause numbers. Clause numbers are editorial artefacts that may change between revisions; a cross-reference that names a number creates a maintenance obligation. The text shall refer to the target by description: *the clause on types*, *the subclause on reference casting*, *the rules defined above*.

Informative text (Examples, Design rationale, Notes) may cite clause numbers, and should prefer descriptive references.

The scope subclause is excepted: there the number is the description.
