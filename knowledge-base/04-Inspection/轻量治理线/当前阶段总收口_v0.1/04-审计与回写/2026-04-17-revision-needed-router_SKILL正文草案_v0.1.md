---
name: revision-needed-router
description: Use when an audit or review result is `revision-needed` and the real problem is where the work should return, what should be patched, which judgment surface should resume, and what the next action should be after acceptance. Defaults to routing back to the nearest valid judgment surface instead of escalating upward. For cross-layer, multi-branch, or concurrent rollback, surface the likely route, evidence, and human confirmation points rather than pretending certainty.
---

# revision-needed-router

## What this skill is for

Use this skill when the real problem is not “is revision needed”, but:

> **where the work should return, which judgment surface should resume, what should be patched now, and what the next effective action should be after acceptance.**

This skill is for cases where a `revision-needed` result has already appeared, and the team risks routing backward too far, too vaguely, or too confidently.

This skill is especially useful when several of the following coexist:
- the patch path is clear, but the return layer is not
- there are multiple nearby judgment surfaces
- acceptance is likely to trigger a next-step transition
- the return chain looks simple on the surface but actually contains branching or concurrency pressure

---

## When to use

Trigger this skill when at least one of the following is true:

1. A review, audit, or checkpoint has already produced `revision-needed`.
2. The real question is “which layer should this return to?”
3. The team needs to distinguish:
   - what must be patched now
   - which judgment surface should resume after patching
   - what should happen next after acceptance
4. The current rollback chain risks being flattened into a fake single line.

---

## When not to use

Do **not** use this skill when the real problem is:

1. **Whether the task is still too thick**
   - “What is the smallest executable unit?”
   - Use `minimal-unit-builder` instead.

2. **Which object is the stage's main artifact**
   - “Which output is the result center?”
   - Use `main-artifact-judge-helper` instead.

3. **Registry / entry-state / stage-label decisions**
   - “Which file should be read first?”
   - “What is the current stage label?”
   - “Which entry card is correct?”
   - Handle through registry / entry-order / stage-state alignment instead.

4. **Whether `revision-needed` itself is valid**
   - This skill routes after `revision-needed` exists.
   - It does **not** replace the review or audit authority that issued that result.

---

## What this skill does

This skill only does four things:

1. **Identify the likely return layer**
   - Judge where the current work should return after `revision-needed`.

2. **Resume the nearest valid judgment surface**
   - Prefer the nearest valid judgment surface instead of escalating upward by default.

3. **Separate patching from escalation**
   - Distinguish “patch and resume here” from “this truly must go back higher”.

4. **Point to the next effective action after acceptance**
   - Once the patch is accepted, state what the next effective action should be.

---

## What this skill must not do

This skill must not:

- automatically escalate to a higher layer by default
- pretend that the nearest valid judgment surface is always unique in complex scenes
- flatten cross-layer or multi-branch rollback into a fake single-line route
- absorb main-artifact judgment
- absorb registry / entry-state / stage-label judgment
- replace the audit authority that decides whether `revision-needed` is valid
- keep the work circling on the same judgment surface after acceptance

---

## Minimum input

Provide at least:

- current `revision-needed` result
- current patch items
- current judgment surface or stage surface
- known rollback dispute or ambiguity
- known next-step expectation after acceptance

If any of these are missing, say what is missing before routing.

---

## Minimum output

The output should contain:

1. **Likely return layer**
   - Where the work should return now

2. **Nearest valid judgment surface**
   - Which surface should resume after the patch

3. **Patch-vs-escalation reasoning**
   - Why this should resume here instead of going higher

4. **Next action after acceptance**
   - What should happen once the patch is accepted

5. **Human confirmation points**
   - What still needs explicit confirmation in complex scenes

---

## Hard boundaries

These are mandatory:

1. **Default to the nearest valid judgment surface; do not escalate upward by default.**
2. **Cross-layer rollback must allow human confirmation.**
3. **Multi-branch or concurrent rollback must not be flattened into a fake single line.**
4. **Concurrent review surfaces must not be treated as if the nearest valid surface were naturally unique.**
5. **Do not absorb main-artifact judgment, registry-entry judgment, or group-stage judgment.**
6. **After acceptance, route to the next effective action instead of idling on the same surface.**
7. **Complex scenes must allow outputs like: suggestion, evidence, and pending confirmation points.**

---

## Complexity-risk patterns

Reject at least these patterns:

### 1. Automatic upward escalation
- A `revision-needed` result is automatically treated as a reason to reopen a higher layer.

### 2. Fake single-line rollback
- Multi-branch or parallel patch chains are compressed into one neat route that hides complexity.

### 3. False unique-surface assumption
- Concurrent judgment surfaces are treated as if there were obviously only one nearest valid surface.

### 4. Accepted-but-still-stuck loop
- The patch is accepted, but the route still points back to the same surface without a next action.

### 5. Layer absorption
- Main-artifact judgment, registry decisions, or group-stage judgment are silently pulled into this skill.

---

## Working rule

When using this skill, prefer this order:

1. Confirm that `revision-needed` already exists.
2. Clarify the current patch items and current judgment surface.
3. Judge the nearest valid judgment surface.
4. Check whether the scene contains cross-layer, multi-branch, or concurrent rollback pressure.
5. If complexity is low, provide the likely route.
6. If complexity is high, provide suggestion + evidence + pending confirmation points.
7. State the next effective action after acceptance.

---

## Output shape

A good output usually looks like:

- Current `revision-needed` result is:
- Current patch items are:
- Likely return layer is:
- Nearest valid judgment surface is:
- Why this should resume here instead of escalating:
- Next effective action after acceptance is:
- What still needs human confirmation:

---

## Risk note

Current known risk is **over-simplification in high-complexity rollback chains**.

That means:
- the skill can structure rollback well in normal scenes
- but must stay explicit about ambiguity when cross-layer, multi-branch, or concurrent rollback appears

Do not write it as an automatic router.

---

## One-line closure

> `revision-needed-router` exists to route a `revision-needed` result back to the nearest valid judgment surface without flattening complex rollback into false certainty.
