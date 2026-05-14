# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## What This Is

**Styx Flow** is a Claude Code skill for turning raw, messy notes into a clean, prioritized backlog. It handles mixed input — bugs, features, ideas, todos — sorts them by real developer impact (P0–P4), and outputs a ready-to-use document.

The primary delivery is a **Claude Code skill** (`/styx`).

## Repo Structure

| Path | Purpose |
|------|---------|
| `claude-skill/skills/styx/SKILL.md` | The `/styx` skill definition |
| `install-skill.sh` | One-command installer for the skill |
| `.styx/papyrus.md` | Output format template (user-editable after install) |
| `.styx/manifesto.md` | Prioritization philosophy (user-editable after install) |

## TODOs.md — Living Backlog

After each `/styx` run, the skill writes the full sorted output to `TODOs.md` in the current working directory. This is the primary output — a committable, shareable backlog file that grows with every run.

On subsequent runs, the skill reads the existing `TODOs.md` and merges it with any new notes before re-sorting, so the file stays current without manual editing.

## History Logging

In addition to `TODOs.md`, each run saves a timestamped session record to `.styx/YYYY-MM-DD-HHMM-slug.md`. The skill ensures `.styx/` is added to `.gitignore` on first use — history files are local and should not be committed.

## The Skill

The `/styx` skill installs to `~/.claude/plugins/cache/local/styx/1.0.0/` and reads its user-tweakable config from:
- `~/.claude/styx/papyrus.md` — output document structure
- `~/.claude/styx/manifesto.md` — prioritization philosophy and scoring rubric

When modifying the skill, update `claude-skill/skills/styx/SKILL.md` in this repo. Commit and push, then re-run `install-skill.sh` to pick up changes (the installer pulls from GitHub).

## Priority System (P0–P4)

| Priority | Definition |
|----------|------------|
| P0 | Hard blocker — crashes, breaks playthrough, blocks dev |
| P1 | Serious bug or Gain L-XL with Effort XS-S |
| P2 | Must ship before next release — Gain M+ or Major severity, Effort M or less |
| P3 | Should fix, won't block release |
| P4 | Nice to have / parking lot |

## Scoring

Each item is scored on two axes, both using the same XS/S/M/L/XL scale:

| Field | Scale | Notes |
|-------|-------|-------|
| **Effort** | XS / S / M / L / XL | Calibrated assuming Claude Code assistance |
| **Gain** | XS / S / M / L / XL | XS = negligible, XL = transformative |
