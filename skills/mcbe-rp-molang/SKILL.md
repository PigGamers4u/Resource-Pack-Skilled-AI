---
name: mcbe-rp-molang
description: Use for deep Molang expression-language work — syntax, variable scopes (temp/variable/context/query), aliases, structs, loops, the null-coalescing operator, and query function selection. Load this whenever an animation controller, animation, render controller, or particle needs a non-trivial Molang expression, or when the user asks "what query do I use for X". Pairs with mcbe-rp-animations, mcbe-rp-particles, and mcbe-rp-entities-and-render-controllers for the file-format side.
---

# MCBE RP Molang (Deep Reference)

Read `../../docs/19-molang-deep-dive.md` for syntax/variables and
`../../docs/20-molang-query-reference.md` for a categorized shortlist of
commonly needed query functions.

## When to load this vs. just using the animations skill

`mcbe-rp-animations` covers the basics needed for typical state
transitions. Load `mcbe-rp-molang` instead/additionally when the task
needs:
- multi-statement expressions with `temp`/`variable` assignment and a
  final `return`
- loops (`loop`, `for_each`, `break`, `continue`)
- structs (nested `variable.foo.bar.baz` data, or the `->` arrow operator
  to read another actor's exposed public variables)
- render-controller array indexing / geometry-or-texture-switching logic
- picking the *right* query function out of the very large query library
  (hundreds of `query.*` functions exist — see the categorized doc rather
  than guessing a name)

## Core rules the agent must not violate

- Molang is **case-insensitive** except for string literal contents.
- A single expression with no `;` implicitly returns its value. Multiple
  statements each need a terminating `;`, and the **last** statement
  should be `return <value>;` — if you forget the `return`, the whole
  expression silently evaluates to `0.0`.
- `material`, `texture`, and `geometry` typed values are **not**
  accessible inside animation or animation-controller Molang — only in
  render controllers. Don't write an animation file that tries to switch
  a texture; that has to happen in the render controller instead.
- Aliases: `q.` = `query.`, `v.` = `variable.`, `t.` = `temp.`,
  `c.` = `context.`. Either form is valid and they can be mixed freely —
  don't "fix" one just because it's inconsistent with the other unless
  asked.
- `temp.*` variables live for the *entire expression's execution*, not
  strictly the block scope they were declared in — be careful with
  reused temp names across sub-scopes in one expression.
- `variable.*` (entity variables) persist for the entity's lifetime but
  are **not saved** — they reset on world reload/entity despawn. Don't
  suggest them as a persistence mechanism.
- The `??` null-coalescing operator only works for numeric/entity-
  reference variables, never for `material`/`texture`/`geometry` — those
  must resolve to something valid or the game throws a content error.
- `min_engine_version` in the pack's manifest controls which *versioned
  behavior* of Molang applies to expressions in that pack (bug fixes and
  operator-precedence changes are gated by version) — if something is
  evaluating unexpectedly, check whether a versioned-changes entry
  explains it before assuming the expression itself is wrong.

## Common mistakes to catch

- Missing `return` in a multi-statement expression (silently becomes
  `0.0`, one of the most common "why is this always 0/false" bugs).
- Trying to reference `material.`/`texture.`/`geometry.` from inside an
  animation or animation controller instead of a render controller.
- Off-by-one confusion about ternary shorthand: `A ? B` runs `B` only if
  `A` is true and otherwise does nothing (not "else 0") — don't assume it
  behaves like a full ternary unless a `:` else-branch is present.
- Forgetting array wraparound behavior: an out-of-range array index in a
  render controller does **not** error, it clamps (negative) or wraps
  (too-large) — don't add manual bounds-checking Molang for this, it's
  already handled.
- Using a query name from memory without checking the categorized
  reference or the full official list — the query library is large and
  there are many similarly-named functions (e.g. `is_on_fire` vs.
  `is_onfire`, both of which exist).
