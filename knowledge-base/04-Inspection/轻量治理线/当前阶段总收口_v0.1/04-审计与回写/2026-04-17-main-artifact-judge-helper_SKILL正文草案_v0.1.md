---
name: main-artifact-judge-helper
description: Use when the real question is which output is the current stage's main artifact versus supporting artifacts such as bridge docs, entry cards, explanation docs, path cards, or closing cards. Helps clarify the current judgment surface and likely result center, but does not replace the lead agent's final decision on overall project placement, final acceptance, or full delivery structure.
---

# main-artifact-judge-helper

## What this skill is for

Use this skill when the real problem is not “what should we produce”, but:

> **which current-stage object should be treated as the main artifact, and which objects are only supporting artifacts around it.**

This skill is for cases where multiple objects are all carrying visible main-line function, and the team risks treating the most obvious object as the result center without a real judgment.

This skill is especially useful when several of the following coexist:
- bridge docs are carrying the handoff pressure
- entry cards look like the current center because everyone is reading them
- explanation docs feel complete enough to be mistaken for the result
- path cards or closing cards temporarily carry the main line

---

## When to use

Trigger this skill when at least one of the following is true:

1. The real question is **which object is the stage's main artifact**.
2. Several artifacts are all carrying current-stage function, and the team needs to distinguish the result center from the support layer.
3. There is a risk that the most visible, most complete, or easiest-to-chain object is being treated as the main artifact by convenience.
4. The team needs a structured judgment surface for “why this is the main artifact” and “why the others are not”.

---

## When not to use

Do **not** use this skill when the real problem is:

1. **Smallest-unit compression**
   - “This task is still too thick; what is the smallest executable unit?”
   - Use `minimal-unit-builder` instead.

2. **`revision-needed` return routing**
   - “After audit says `revision-needed`, which layer should this return to?”
   - Use `revision-needed-router` instead.

3. **Registry / entry-state / stage-label decisions**
   - “Which file should be read first?”
   - “What is the current stage label?”
   - “Which card is the right entry point?”
   - Handle through registry / entry-order / stage-state alignment instead.

4. **Final project acceptance or full project placement**
   - This skill helps judge the current-stage main artifact.
   - It does **not** replace the lead agent's final project placement or acceptance decision.

---

## What this skill does

This skill only does four things:

1. **Clarify the current judgment surface**
   - State what stage is being judged and what counts as the current result center question.

2. **Identify the most likely main artifact**
   - Judge which object is closest to the current stage's result center.

3. **Separate the support layer from the result center**
   - Distinguish the main artifact from:
     - bridge docs
     - entry cards
     - explanation docs
     - path cards
     - closing cards
     - temporary support pieces

4. **Explain the judgment with boundaries**
   - State why this object is currently the best main-artifact candidate.
   - State what remains uncertain when the case is not clean enough.

---

## What this skill must not do

This skill must not:

- act as the final project acceptance authority
- take over the lead agent's final placement decision
- rewrite the full delivery structure for the whole project
- absorb smallest-unit compression work
- absorb `revision-needed` return routing work
- absorb registry or stage-entry judgment
- pretend that the most visible or most complete object is automatically the main artifact

---

## Minimum input

Provide at least:

- current stage goal
- current judgment surface
- candidate objects list
- what each object is currently doing
- known dispute or confusion point

If any of these are missing, say what is missing before judging.

---

## Minimum output

The output should contain:

1. **Current likely main artifact**
   - Which object is currently closest to the result center

2. **Why it is the main artifact**
   - The stage-specific reason, not a generic preference

3. **Why the others are not**
   - Why the nearby bridge / entry / explanation / path / closing objects remain support-layer objects

4. **Uncertainty or pending checks**
   - What still needs human confirmation in complex cases

---

## Positive judgment standard

This skill must not only reject shortcut misjudgments. It must also provide a **forward judgment frame** for why one object is currently the main artifact.

When giving a positive judgment, prefer these criteria:

1. **Current-stage result-center closeness**
   - Which object is closest to the current stage's default result center, rather than merely surrounding it.

2. **Default placement priority**
   - Which object would most reasonably be treated as the current stage's default priority result if the team had to place one object first.

3. **Judgment-surface fit**
   - Which object best matches the actual judgment surface being resolved now, instead of only helping people navigate, explain, bridge, or close the stage.

4. **Support-layer dependence check**
   - Whether nearby objects mainly exist to support this object's formation, understanding, handoff, or access, rather than replace its role as result center.

5. **Complex-scene candidate signals**
   - In messy scenes, do not force certainty, but still state what currently supports this object as the main-artifact candidate.
   - Typical signals include:
     - it directly carries the current-stage result judgment
     - it is the object the stage would most reasonably return to as the result center
     - nearby artifacts mainly help interpret, route, bridge, or expose this object

A good positive judgment should answer both:
- why this object is currently the best main-artifact candidate
- why it is closer to the current stage's default result placement than the nearby objects

## Hard boundaries

These are mandatory:

1. **This is an auxiliary judgment skill, not a final decider.**
2. **It clarifies the current main-artifact judgment surface; it does not take over the whole result chain.**
3. **It must not treat “most visible / most complete / easiest to chain” as a shortcut for main-artifact judgment.**
4. **In high-complexity delivery scenes, it must allow outputs like: current judgment, evidence, and pending verification points.**
5. **It must not absorb smallest-unit splitting, `revision-needed` routing, or registry-entry judgment.**

---

## High-risk misjudgment patterns

Reject at least these patterns:

### 1. Visibility shortcut
- The object is treated as the main artifact because everyone is currently looking at it.

### 2. Completeness shortcut
- The object is treated as the main artifact because it looks the most complete or polished.

### 3. Chain-convenience shortcut
- The object is treated as the main artifact because it is easiest to continue from.

### 4. Temporary-main-line inflation
- A support piece temporarily carries the main line and is incorrectly upgraded into the stage's result center.

### 5. Full-project takeover
- The judgment silently shifts from “current-stage main artifact” to “final project placement”.

---

## Working rule

When using this skill, prefer this order:

1. Clarify the current stage and judgment surface.
2. List the candidate artifacts and their current functions.
3. Exclude visibility / completeness / convenience shortcuts.
4. Identify the most likely main artifact.
5. State why the nearby objects remain support-layer objects.
6. If the case is complex, output current judgment + evidence + pending verification points.

---

## Output shape

A good output usually looks like:

- Current judgment surface is:
- Candidate objects are:
- Current likely main artifact is:
- Why it is the result center:
- Why the nearby objects are not:
- What remains uncertain / needs confirmation:

---

## Risk note

Current known risk is **misjudgment cost in high-complexity delivery scenes**.

That means:
- the skill can help clarify the current main-artifact judgment surface
- but it must stay auxiliary
- and must not overclaim certainty when the scene is structurally messy

Do not write it as an automatic final decider.

---

## One-line closure

> `main-artifact-judge-helper` exists to clarify which current-stage object is the main artifact without mistaking visibility, completeness, or chain convenience for real result-center judgment.
