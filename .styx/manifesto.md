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

## Codex

- **No Invention.** Never add items that weren't in the source notes.
- **Preserve All.** Every item in the input must appear in the output — even if it ends up P4 or flagged for drop.
- **Bug First Within Tier.** Within each priority level, list Bugs → Features → Improvements → other types.
- **Needs Tag.** When a note is too vague to score, add `Needs: [what clarification is required]` as a detail line.
- **No Ghosting.** Never silently discard or merge items. If two notes are about the same thing, group them explicitly and say so.
