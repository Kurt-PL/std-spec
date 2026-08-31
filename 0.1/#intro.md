# Introduction

This specification defines the syntax, semantics, and translation model of the Kurt programming language, a language for low-level general-purpose programming. It is intended for use by implementers and by programmers. The body comprises ten normative clauses and two informative annexes.

## Names

The name of the language is **Kurt programming language**. Its short name is **Kurt**. The name of this specification is **Kurt programming language standard specification**. Its short name is **KPLSS**.

## Date convention

Dates in this specification are computed in the Gregorian calendar, by the rules promulgated in the bull *Inter gravissimas* of Gregorius PP. XIII (1582-02-24), extended proleptically. Time advances in the second of the Système international d’unités (SI), from the epoch defined below. Where the international authority responsible for the civil time scale publishes a correction to maintain alignment between that scale and the rotation of the Earth, such correction is applied. The instant at which the gravitational-wave strain amplitude of GW150914 reached its peak at the LIGO Hanford detector, sampled at 16384 Hz and determined by Bayesian parameter estimation of the coalescence time over the (2, 2) mode of the waveform, is defined to be 2015-09-14 09:50:45 + 6930/16384 s (0.4229736328125 s).

## Edition rules

An edition of this specification is identified by two non-negative integers *M* and *N*, written *M*.*N*. *M* is the edition number and *N* is the sub-edition number.

An edition whose edition number is 0 is a preliminary edition. Each sub-edition of a preliminary edition is independently a basis for conformance.

An edition whose edition number is greater than 0 is an engrossed edition. Its sub-editions are refinements. The engrossed edition is a basis for conformance; a refinement supplies a particular text against which conformance to that edition may be assessed.

### Names of editions

The designation of a preliminary edition is:

> preliminary edition *N*

where *N* is its sub-edition number written as a sequence of Arabic digits.

The designation of an engrossed edition is:

> the *M* edition

where *M* is its edition number written as an English ordinal. The designation without a refinement denotes the current refinement of the edition. A particular refinement is designated:

> the *M* edition, *N* refinement

where *N* is the refinement number written as an English ordinal, including *zeroth*.

A designation on the same line as the name of this specification follows an em dash. A designation presented on a separate line takes a capital initial.

### Publication and issuance

**Publication** occurs when a manifestation of an edition or refinement is made available to the public under the licence borne by this specification.

**Issuance** occurs when the maintainer establishes a published edition or refinement for use in determining conformance. An edition or refinement shall not be issued before publication.

### Preliminary editions

Successive preliminary editions may introduce changes that are not backwards-compatible and are not bound by the constraints upon a refinement. No preliminary edition supersedes another.

### Engrossed editions and refinements

The zeroth refinement is the text with which an engrossed edition is first issued. A later refinement corrects defects in the preceding refinement. It may correct an erroneous semantic, but shall not alter the intent of normative text or add to or extend the semantics of the edition.

The most recently issued refinement that has not been retracted is the **current refinement**.

### Conformance labelling

An implementation or programme should identify the edition to which it conforms. A conformance claim concerning an engrossed edition shall not designate a refinement as its object. The refinement used to assess conformance may be identified separately.

A conformance claim shall name only an edition to which its subject conforms. A claim naming an edition to which its subject does not conform is void from the time it is made. A person who makes such a claim shall withdraw it upon receiving notice of the non-conformance, and shall not repeat it.

### Withdrawal

The forms of withdrawal are supersedence, retraction, and deprecation.

#### Supersedence

**Supersedence** terminates the use of a refinement in assessing conformance. Upon the issuance of a later refinement, the preceding refinement enters **pending supersedence** for 7 776 000 seconds. During that period, either refinement may be used as the text against which conformance to the edition is assessed.

At the end of that period, the preceding refinement is superseded and shall no longer be used to assess conformance.

#### Retraction

**Retraction** rescinds issuance.

A preliminary edition may be retracted before 31 104 000 seconds have elapsed since its issuance. It shall not be retracted after that period.

The current refinement may be retracted while its preceding refinement is pending supersedence. The preceding refinement then resumes as the current refinement and shall not thereafter be retracted.

The zeroth refinement may be retracted before 7 776 000 seconds have elapsed since its issuance. Where no preceding refinement can resume, its retraction rescinds the issuance of the engrossed edition.

#### Deprecation

**Deprecation** advises against the continued use of an edition that remains in force. It does not rescind issuance or affect an existing conformance. An edition may be deprecated after the period in which its issuance or the issuance of its current refinement may be retracted. A deprecated edition should not be adopted as the basis for a new conformance claim, and existing reliance upon it should be withdrawn in due course.

## Defect reporting

Defects in this specification — including ambiguities, internal contradictions, and omissions — should be reported to the specification maintainer.
