# STYX FLOW: NOTES-TO-BACKLOG FRAMEWORK

## Philosophy

- **The River Shapes, Not Replaces.** Refinement clarifies intent; it never rewrites it. If the note says "fix that annoying door thing," the output is "Fix door interaction — [specific behavior]." Not a reframed feature. Not an invented scope.
- **Triage is Honest.** A P0 with huge effort is still a P0. A P4 with low effort is still P4 if the gain is negligible. Prioritize on real impact, not on what feels comfortable.
- **Mixed is Normal.** Bugs, features, half-baked ideas, and questions will all be jumbled together. Separate them cleanly without losing any.
- **Vagueness is a Signal.** A note that can't be scored is a note that needs a decision. Flag it with `Needs:` rather than guessing.

## Priority Rubric

| Priority | Definition |
|----------|------------|
| **P0** | Crashes, progression blockers, anything that prevents playing the game or actively developing it. Fix immediately regardless of effort. These are the boulders in the river. |
| **P1** | Major stability bug OR high gain capturable cheaply. These go in the current sprint. |
| **P2** | Must ship before next release. Meaningful gain, manageable effort. |
| **P3** | Real value, but won't block shipping. Tackle when bandwidth allows. |
| **P4** | Low gain or prohibitive effort. Park it honestly — don't lose it, don't plan on it. |

## Scoring

- **Effort:** XS (< 30min) | S (30min–2hrs) | M (2–5hrs) | L (1–2 days) | XL (3-5 days) — calibrated assuming Claude Code assistance
- **Gain:** XS (negligible) | S (minor improvement) | M (meaningful, noticeable) | L (significant impact on UX/stability/velocity) | XL (transformative)
- **Severity (bugs only):** Critical (crash/blocker) | Major (significant dysfunction) | Minor (cosmetic/edge case)

## Epic Threshold

An item qualifies as an **Epic** — too large for the sprint backlog, routed to EPICS.md instead — when any two of the following are true:

1. **Effort XL** — 3–5 days even with Claude Code
2. **Scope** — crosses 3+ core systems, or introduces a new major architectural layer
3. **Design gate** — the *how* is unknown; a dedicated design session is required before implementation begins

Large-but-well-understood items with known implementation paths stay in TODOs.md at P3/P4. The key signal is "we can't start coding this yet."

Epics use the same P1–P4 rubric with a shifted interpretation: P1 = ready to implement, P2 = design session is next, P3 = long-term vision, P4 = speculative or blocked.

## Codex

- **No Invention.** Never add items that weren't in the source notes.
- **Preserve All.** Every item in the input must appear in the output — even if it ends up P4 or flagged for drop.
- **Bug First Within Tier.** Within each priority level, list Bugs → Features → Improvements → other types.
- **Needs Tag.** When a note is too vague to score, add `Needs: [what clarification is required]` as a detail line.
- **No Ghosting.** Never silently discard or merge items. If two notes are about the same thing, group them explicitly and say so.
- **Preserve All Details.** Never remove specifics from source notes — file paths, line numbers, function names, hints, reproduction steps, pointers to code. Reformat freely, consolidate if clearly redundant, but every specific must survive in the output. Use nested or additional bullet points to carry forward details that don't fit in a one-liner.
- **Two Files.** TODOs.md holds sprint-backlog items. EPICS.md holds epics. Never put an Epic in TODOs.md or a regular item in EPICS.md.
