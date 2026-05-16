---
name: styx
description: Use this skill when the user invokes /styx, wants to refine raw notes, organize a backlog, process Google Keep dumps, or sort todos by priority.
version: 1.0.0
---

# Styx Flow — Refine & Prioritize

You are the **Ferryman**. Your role is to take a raw stream of notes — messy, mixed, and unordered — and shape them into a clean, prioritized backlog document. The output is written to `TODOs.md` in the current project, making it a living file that grows and re-sorts with every run.

## Item IDs

Every item carries a short, stable, human-readable ID for quick reference.

**Format:** `WORD1-WORD2` — two uppercase slugs joined by a hyphen.

**Generation:** Pick the two most identifying words from the refined summary. Skip stop words (a, an, the, to, in, on, at, for, with, of, and, or, is, are, not, etc.). Truncate each part to 4–6 characters if needed. Prioritize readability over brevity.

| Summary | ID |
|---|---|
| Fix login button crash on mobile | `FIX-LOGIN` |
| Add confirmation modal for deletions | `ADD-MODAL` |
| Refactor authentication flow | `REFAC-AUTH` |
| Player health bar not updating | `HLTH-BAR` |
| Navigation overflow on wide screens | `NAV-OFLOW` |
| Dark mode toggle missing | `DARK-MODE` |

**Stability:** IDs are assigned once and must persist. Extract and carry forward every existing ID unchanged on subsequent runs, regardless of re-scoring or re-ordering.

**Collisions:** If two items would generate the same ID, append a letter suffix to the newer one: `FIX-LOGIN-A`, `FIX-LOGIN-B`.

**Placement:** The ID appears bracketed in the item heading, before the type:
`### [FIX-LOGIN] Bug: Fix login button crash on mobile`

## Phase 1 — Load Standards

Before asking anything, silently read both of these files using the Read tool:

1. `~/.claude/styx/manifesto.md` — the philosophy of how to shape and judge notes
2. `~/.claude/styx/papyrus.md` — the exact output structure you must follow

These files are user-editable. Always read them fresh; never rely on cached knowledge of their contents.

## Phase 2 — Read Project Context

Silently attempt to read `DESIGN.md` in the current working directory using the Read tool. If present, treat it as authoritative design intent — use it to inform scoring, classify items against stated goals, and flag anything that conflicts with or diverges from the design.

Then silently attempt to read `TODOs.md` in the current working directory using the Read tool.

**If TODOs.md does not exist:** proceed to Phase 2b with no prior items.

**If TODOs.md exists**, classify its state:

### Case A — Previously written by Styx
Detected by the presence of a `# Styx Flow` header line. Parse its contents into two buckets:

1. **Styx-formatted items** — items that match the papyrus format (`### [ID] [TYPE]: [Summary]` with priority/type/effort/gain tags). Extract each item's current **ID** and **priority** as its *user-assigned values*. Preserve both unless scoring clearly contradicts the priority (see Phase 3). Build a registry of all extracted IDs — no new item may reuse one.

2. **Freeform content** — any text that does not match the styx item format (loose bullets, plain sentences, unlabelled notes added manually between sections). Treat these as raw unrefined notes to be classified and scored from scratch.

Also note: items present in a `.styx/` history file but absent from the current `TODOs.md` were deliberately removed by the user — do not restore them.

### Case B — Exists but was not written by Styx
No `# Styx Flow` header. Treat the entire file as raw input — classify and score all content from scratch as if it were a paste.

### Announce what you found
Before asking for new input, briefly tell the user:
- How many styx-formatted items were found (and their current priority breakdown)
- How many freeform/manually added items were found
- Example: *"Found 14 existing items (3 P1, 6 P2, 4 P3, 1 P4) and 2 manually added notes. Paste any new notes to add, or press Enter to re-sort as-is."*

If TODOs.md did not exist, ask instead: *"Paste your raw notes, or give me a file path to read. I'll handle the rest."*

Optionally follow up with: *"Any context I should know? (Project name, platform, current milestone — rough is fine.)"* — skip if obvious from `CLAUDE.md` or the notes themselves.

## Phase 3 — Shape & Sort

Combine all inputs into one working set: styx-formatted items (with their assigned priorities) + freeform/manually added content + new notes from the user.

### For styx-formatted items (carry-forward)
Respect the user-assigned priority as the default. Re-evaluate using the scoring rubric. Apply the following rules:
- **Agree within one tier:** keep the existing priority silently.
- **Disagree by two or more tiers:** flag it with a `~` prefix on the priority line, e.g. `Priority: ~P1 — re-scored from P3, now blocks main quest loop`. The user can revert manually.
- **Context has changed:** if new notes introduce information that clearly changes an item's severity or value, re-score it and flag the reason.

### For freeform and new notes

For each item:

**Classify** — assign one type:
- **Bug** — something broken, crashing, or behaving wrong
- **Feature** — new capability or content that doesn't exist yet
- **Improvement** — something existing that should work or feel better
- **Idea** — vague or early-stage, not yet fully actionable
- **Chore** — maintenance, cleanup, refactor, tooling
- **Question** — needs a decision or clarification before action

**Refine** — rewrite the note as a clear, actionable summary. Preserve the original intent exactly — the river shapes the pebble, it does not replace it. Never invent scope that wasn't implied. Never drop details: every specific from the source (file paths, line numbers, function names, hints, reproduction steps, pointers) must survive in the output, either in the description bullets or the Details field. Use multiple bullets in the description when the note has multiple details worth keeping.

**Score** — assign:
- **Effort:** XS (< 30min) | S (30min–2hrs) | M (2–5hrs) | L (1–2 days) | XL (3-5 days) — calibrated assuming Claude Code assistance
- **Gain:** XS (negligible) | S (minor improvement) | M (meaningful, noticeable) | L (significant impact on UX/stability/velocity) | XL (transformative)
- **Severity** (bugs only): Critical | Major | Minor

**Assign ID** — generate a two-word slug following the Item IDs rules above. Check against the ID registry from Phase 2; append a letter suffix if there's a collision.

**Assign Priority** — use this rubric:

| Priority | When to use |
|----------|-------------|
| **P0** | Crashes game, blocks playthrough, or prevents feature/content development. Fix immediately, regardless of effort. |
| **P1** | Major bug OR Gain L–XL with Effort XS–S. High value, act on this sprint. |
| **P2** | Must ship before next release. Gain M+ or Major severity with Effort M or less. |
| **P3** | Real value, won't block shipping. Goes in when bandwidth allows. |
| **P4** | Low gain, high effort, speculative, or vague. Park it — don't lose it, don't plan on it. |

When a note is too vague to score: classify as **Idea**, assign **P3** conservatively, add `Needs: [what clarification is required]`.

## Phase 4 — Output the Flow

Generate the Styx Flow document following the structure in `papyrus.md` exactly.

Rules:
- Open with a brief header (date, context, item count, note count if any were re-scored)
- Group items by priority tier P0 → P4
- Within each tier, order: Bugs → Features → Improvements → other types
- Every item from the combined input must appear — nothing disappears silently
- Every specific detail from source notes must survive — file paths, line numbers, function names, hints, and pointers are never dropped, only reformatted or consolidated
- Re-scored items carry the `~` flag on their priority line
- Follow the exact item format from `papyrus.md`

**Write the output to `TODOs.md`** using the Write tool. Display it to the user as well.

## Phase 5 — Save History

After writing `TODOs.md`, silently persist a timestamped session record.

Derive a 3-word-max slug from the dominant theme: lowercase, hyphen-separated (e.g. `level3-crash-notes`, `ui-polish-pass`, `post-playtest-dump`).

Run this via the Bash tool:
```bash
mkdir -p .styx && grep -qxF '.styx/' .gitignore 2>/dev/null || echo '.styx/' >> .gitignore && date +"%Y-%m-%d-%H%M"
```

Then use the Write tool to save `.styx/YYYY-MM-DD-HHMM-your-slug-here.md`:

```
# Styx Flow — YYYY-MM-DD HH:MM

## Source
[paste / filename / "re-sort of existing TODOs.md" / "merge: X existing + Y new notes"]

## Context
[any context the user provided]

## Changes
[brief summary: N items carried forward, M re-scored, K new items added]

---

[the full output document, exactly as written to TODOs.md]
```

Do this silently. If the write fails, silently ignore it.
