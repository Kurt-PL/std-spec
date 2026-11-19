# Introduction

This specification defines the syntax, semantics, and translation model of the Kurt programming language, a language for low-level general-purpose programming. It comprises ten body clauses and two annexes.

The rules of this introduction govern this specification, those who publish, issue, and cite it, and those who claim conformance to it.

## Names

The name of the language is **Kurt**. The name of this specification is **Kurt programming language standard specification**. Its short name is **KPLSS**.

## Date convention

Dates in this specification are computed in the Gregorian calendar, by the rules promulgated in the bull *Inter gravissimas* of Gregorius PP. XIII (1582-03-06), extended proleptically. Time advances in the second of the Système international d’unités (SI), from the reference point defined below. Where the international authority responsible for the civil time scale publishes a correction to maintain alignment between that scale and the rotation of the Earth, such correction is applied. The **reference point** is the instant at which the gravitational-wave strain amplitude of GW150914 reached its peak at the LIGO Hanford detector, sampled at 16384 Hz and determined by Bayesian parameter estimation of the coalescence time over the (2, 2) mode of the waveform. That instant is defined to be 2015-09-14 09:50:45 + 6930/16384 s (0.4229736328125 s).

## Edition rules

This specification is issued as texts, each identified by two non-negative integers, its edition number and its sub-edition number, written in that order with a full stop between them.

A text whose edition number is 0 is a **preliminary edition**, and each preliminary edition is a basis for conformance.

The texts that share one edition number greater than 0 are the **refinements** of one **engrossed edition**, which is a basis for conformance; a refinement supplies a particular text against which conformance to that edition may be assessed. An **edition** is a preliminary edition or an engrossed edition.

### Names of editions

The designation of a preliminary edition is:

> preliminary edition *sub-edition number*

where the sub-edition number is written as a sequence of Western Arabic numeral digits.

The designation of an engrossed edition is:

> the *edition number* edition

where the edition number is written as an ordinal spelled in words. The designation without a refinement denotes the current refinement of the edition. A particular refinement is designated:

> the *edition number* edition, *refinement number* refinement

where the refinement number is the sub-edition number, written the same way, including *zeroth*.

A designation on the same line as the name of this specification follows an em dash. A designation presented on a separate line takes a capital initial. The designations of this edition are:

> Kurt programming language standard specification &mdash; preliminary edition 1

> Preliminary edition 1

### Publication and issuance

**Publication** occurs when a manifestation of an edition or refinement is made available to the public under the licence borne by this specification.

**Issuance** occurs when the maintainer establishes a published edition or refinement for use in determining conformance. An edition or refinement shall not be issued before publication.

### Preliminary editions

Successive preliminary editions may introduce changes that are not backwards-compatible and are not bound by the constraints upon a refinement. No preliminary edition supersedes another.

### Engrossed editions and refinements

The zeroth refinement is the text with which an engrossed edition is first issued. A later refinement corrects defects in the preceding refinement. It shall alter no requirement except to correct a defect, and shall not extend the semantics of the edition.

The most recently issued refinement that has not been retracted is the **current refinement**.

### Conformance labelling

An implementation or programme should identify the edition to which it conforms. A conformance claim concerning an engrossed edition shall not designate a refinement as its object. The refinement used to assess conformance may be identified separately.

A conformance claim shall name only an edition to which its subject conforms. A claim naming an edition to which its subject does not conform is void from the time it is made. A person who makes such a claim shall abandon it upon receiving notice of the non-conformance, and shall not repeat it until its subject conforms.

### Withdrawal

The forms of withdrawal are supersedence, retraction, and deprecation.

#### Supersedence

**Supersedence** terminates the use of a refinement in assessing conformance. Upon the issuance of a later refinement, the preceding refinement enters **pending supersedence** for 7 776 000 seconds. During that period, either refinement may be used as the text against which conformance to the edition is assessed.

At the end of that period, the preceding refinement is superseded and shall no longer be used to assess conformance.

#### Retraction

**Retraction** rescinds issuance.

A preliminary edition may be retracted before 31 104 000 seconds have elapsed since its issuance. It shall not be retracted after that period.

The current refinement may be retracted while its preceding refinement is pending supersedence. The preceding refinement then resumes as the current refinement.

The zeroth refinement may be retracted before 7 776 000 seconds have elapsed since its issuance. Its retraction rescinds the issuance of the engrossed edition.

#### Deprecation

**Deprecation** advises against the continued use of an issued edition. It does not rescind issuance or affect an existing conformance. An edition may be deprecated after the period in which its issuance or the issuance of its current refinement may be retracted. A deprecated edition should not be adopted as the basis for a new conformance claim, and existing reliance upon it should end.

## Defect reporting

Defects in this specification &mdash; including ambiguities, internal contradictions, and omissions &mdash; should be reported to the specification maintainer.
