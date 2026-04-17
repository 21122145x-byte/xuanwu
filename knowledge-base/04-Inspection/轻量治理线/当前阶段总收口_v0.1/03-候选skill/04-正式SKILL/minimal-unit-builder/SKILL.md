---
name: minimal-unit-builder
description: Use when a task is too thick to dispatch directly and needs to be compressed into the smallest executable unit without losing the real goal. Good for detecting fake splitting, fake prompt shrinking, and “looks smaller but still not executable” situations. Not for main-artifact judgment, audit-return routing, or registry/entry-state decisions.
---

# minimal-unit-builder

## What this skill is for

Use this skill when the real problem is not “what should we do”, but:

> **how to compress an over-thick task into the smallest executable unit without losing the real goal.**

This skill is for:
- over-thick tasks that cannot be dispatched directly
- pseudo-splitting that looks smaller but is still not executable
- cases where the current blockage is task grain, not task direction

This skill is not for:
- judging the main artifact
- deciding where `revision-needed` should return
- registry / entry-order / state-label decisions

---

## When to use

Trigger this skill when at least one of the following is true:

1. The task goal is clear, but the current unit is still too thick to execute directly.
2. The team knows what should be done, but cannot yet identify a truly dispatchable smallest unit.
3. The current work has been split into sections or modules, but those sections are still not independently executable, verifiable, and returnable.
4. There is a risk that the work has only been made *shorter in wording*, not *smaller in execution*.

---

## When not to use

Do **not** use this skill when the real problem is:

1. **Main-artifact judgment**
   - “Which output is the stage’s main artifact?”
   - Use `main-artifact-judge-helper` instead.

2. **Audit-return routing**
   - “After `revision-needed`, which layer should this return to?”
   - Use `revision-needed-router` instead.

3. **Registry / entry-state judgment**
   - “Which file should we read first?”
   - “What is the current state label?”
   - “Which entry card is the right starting point?”
   - Handle through registry / entry-order / state alignment instead.

4. **Already-small execution objects**
   - If the smallest executable object is already clear and the only problem is that the material is long or numerous, do not route here.

---

## What this skill does

This skill only does three things:

1. **Detect thickness**
   - Identify whether the current unit is still too thick to execute directly.

2. **Compress into the smallest executable unit**
   - Turn a thick problem into one of the following:
     - smallest executable object
     - smallest judgment object
     - smallest decision / sign-off object

3. **Reject fake shrinking**
   - Detect and reject reductions that only look smaller on the surface.

---

## What this skill must not do

This skill must not:

- decide which artifact is the main artifact
- decide where `revision-needed` should route
- rewrite or recompile the whole main line for the lead agent
- pretend that “made smaller” means “already solved”
- re-label the final goal as if it were already a smallest executable action

---

## Minimum input

Provide at least:

- current thick-problem summary
- current real goal
- current blockage
- current materials / outputs / file locations

If any of these are missing, say what is missing before compressing.

---

## Minimum output

The output should contain:

1. **Current thickness judgment**
   - Why the current unit is still too thick

2. **Proposed smallest unit**
   - What the smallest executable / judgment / decision object should be

3. **Why this unit is small enough**
   - Why it is executable, verifiable, and returnable

4. **Rejected fake shrinking patterns**
   - Which tempting but invalid “smaller versions” were excluded

---

## Hard boundaries

These are mandatory:

1. **The smallest unit must be executable, verifiable, and returnable.**
2. **Do not rewrite the final goal as if it were already the smallest action.**
3. **Do not create the illusion of compression by merely shortening the title.**
4. **Do not absorb main-artifact judgment, audit-return routing, or registry-entry judgment.**

---

## Fake shrinking patterns

Reject at least these patterns:

### 1. Shorter title, same thickness
- The task name becomes shorter.
- The execution burden does not become smaller.

### 2. Section splitting without independent executability
- A large task is split into 1 / 2 / 3 sections.
- None of those sections can be independently executed and returned.

### 3. Final-goal disguise
- The final intended result is rewritten as if it were already a smallest next action.

### 4. Judgment problem disguised as execution unit
- The real missing piece is judgment, routing, placement, or audit.
- But it is incorrectly packaged as a smallest action object.

---

## Working rule

When using this skill, prefer this order:

1. Check whether the current problem is really a grain problem.
2. Identify whether the current unit is still over-thick.
3. Exclude fake shrinking candidates.
4. Produce the smallest executable unit.
5. State why that unit is small enough and what was rejected.

---

## Output shape

A good output usually looks like:

- Current problem is still too thick because:
- It should not be split as:
- The smallest executable unit should be:
- Why this is small enough:
- What fake shrinking was rejected:

---

## Risk note

Current known risk is mainly **sample coverage**, not definition instability.

That means:
- the skill boundary is already reasonably clear
- but more task shapes should still be tested later

Do not overclaim maturity.

---

## One-line closure

> `minimal-unit-builder` exists to compress a thick task into the smallest executable unit without confusing “looks smaller” with “is now executable”.
