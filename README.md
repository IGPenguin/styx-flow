<p align="center">
  <img src="assets/header.svg" width="100%" alt="Styx Flow Header">
</p>

## 🌊 Turn raw notes into a prioritized backlog

**Styx Flow** is a Claude Code skill that takes your unfiltered notes (Google Keep dumps, post-playtest scribbles, scattered todos) and shapes them into a clean, sorted backlog document. Paste chaos, get a prioritized list:

- **P0:** Hard blocker: crashes, breaks playthrough, stops dev cold
- **P1:** Serious bug or big easy win
- **P2:** Must ship before next release
- **P3:** Should fix, won't block the release
- **P4:** Nice to have / parking lot

---

## ⚡ Claude Code - Skill

The Ferryman lives natively inside Claude Code as a `/styx` skill.

No API keys, no config per project. Install once, invoke from any session.

### Setup

```bash
git clone https://github.com/your-repo/styx-flow.git
cd styx-flow
./install-skill.sh
```

Restart Claude Code. That's it.

### Usage

Type `/styx` in any [Claude Code](https://claude.com/product/claude-code) session. The Ferryman will:
1. Read your project's `CLAUDE.md` if present (instant context)
2. Auto-read `TODOs.md` if it exists, carrying forward and re-sorting existing items
3. Ask for any new notes to add, paste directly or point to a file
4. Parse, classify, refine, score, and sort everything (existing + new)
5. Write the full result back to `TODOs.md` and display it inline

`TODOs.md` is the living backlog. Commit it, share it, track it in git like any other project file.

### History

Every `/styx` run also saves a timestamped record to `.styx/YYYY-MM-DD-HHMM-slug.md`: source notes + full output.

The skill adds `.styx/` to your `.gitignore` automatically on first use, so session history stays local.

### Tweaking

The output template and scoring rules live in your home directory. Changes take effect immediately.

| File | Purpose |
| :--- | :--- |
| `~/.claude/styx/papyrus.md` | Output document structure: rename tiers, add fields, change format |
| `~/.claude/styx/manifesto.md` | Prioritization philosophy: scoring rubric, triage rules |

### Scoring

Each item gets two scores alongside its priority:

| Field | Scale | Notes |
| :--- | :--- | :--- |
| **Effort** | XS / S / M / L / XL | Calibrated assuming Claude Code assistance |
| **Gain** | XS / S / M / L / XL | XS = negligible, XL = transformative |

Effort and gain feed directly into priority: a high-gain, low-effort item rises fast; a vague, expensive idea parks at P4.

## 🔗 Related

- 🔥 **[Hades Gate](https://github.com/IGPenguin/hades-gate)** - Claude Skill: Feature outline to deep orthogonal analysis (`/hades`)

