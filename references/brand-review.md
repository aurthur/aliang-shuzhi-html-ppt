# Brand-color: bounded roles + a review pass

Color usage is a *judgment*, not a fixed recipe — so this skill doesn't give you a recipe. It gives
you **bounded roles** (so over-coloring is structurally hard) and a **two-stage review** you run
against a rubric (so over/under-use gets *caught*, per page and across the deck). This is the part a
spec alone can't do; based on the open-source [open-design](https://github.com/nexu-io/open-design)
`craft/color.md` + `lint-artifact.ts` loop and the design-review-agent pattern.

## Contents
- [The constraint: color roles + proportion](#the-constraint-color-roles--proportion)
- [Per-page review (run on every slide)](#per-page-review-run-on-every-slide)
- [Whole-deck review (run once at the end)](#whole-deck-review-run-once-at-the-end)
- [Multi-color brands within this model](#multi-color-brands-within-this-model)
- [The loop](#the-loop)

## The constraint: color roles + proportion

Bound the brand color by **role**, not by vibe:

- **Brand hue appears ONLY via `--accent`** (and its `-d/-soft/-line` shades) — the "solid fill / CTA"
  role. Never hardcode the brand hex in the body. Everything else is **neutral** (`--ink/--gray/--bg/
  --line/--hair`) or **semantic** (`--pos` green / `--neg` red / `--warn`). Tokens are named by
  purpose, never by hue — an agent literally can't over-color if brand only lives in one capped token.
- **Proportion per slide (target):** neutral **70–90%** · accent **5–10%** · semantic **0–5%** ·
  decorative effects **<1%**.
- **Hard cap — ≤ 2 *strong* accent moments per content slide.** "Strong" = a saturated fill, a CTA, a
  large brand-colored figure, a link. Small uppercase labels and soft-tint icon badges are quiet and
  don't count. The squint test is the real arbiter (below); the count is the guardrail.
- **One dominant hue.** Even for a multi-color brand, ONE color is the structural primary (Google →
  blue); the others are a separate, low-emphasis role (see below), never a second focal accent.

## Per-page review (run on every slide)

Screenshot the rendered slide, then audit — yes, **every page**:

1. **Squint test.** Blur your eyes (or downscale the screenshot). Only the *one intended focal
   element* should pop. If two+ things pop, the accent is overused → demote the weakest to neutral.
2. **Count.** Count visible *strong* accent uses (fills, CTAs, large colored figures, links). > 2 →
   list which to demote and why.
3. **Proportion.** Eyeball the neutral / accent / semantic split vs 70-90 / 5-10 / 0-5. Mostly neutral?
4. **One brand moment present?** Conversely — if a content page has *zero* brand presence, it reads
   generic. It should have exactly one accent moment (a figure, a key card, an icon) — not zero.
5. **Semantics correct.** Up=green / down=red on numbers; light brand colors (e.g. yellow) carry dark
   text for contrast (WCAG: normal text ≥ 4.5:1, large ≥ 3:1, UI/graphics ≥ 3:1 — don't round).

**Per-page audit prompt** (give the agent each rendered slide):
> "Screenshot this slide. (1) Squint: name what pops — if more than the single intended focal element
> pops, flag it. (2) Count visible strong accent uses; if > 2, list which to demote to neutral. (3)
> Estimate neutral/accent/semantic proportion vs 70-90/5-10/0-5. (4) If the page has zero brand
> presence, flag it. Output findings as `{severity, id, message, fix}`, P0 first, then RE-EMIT the
> corrected slide — no separate explanation."

## Whole-deck review (run once at the end)

Per-page can't catch inconsistency — so also audit the deck as a whole:

- **Consistency:** the same role uses the same token on every slide (no raw-hex drift); the accent
  sits in the *same kind of place* slide to slide; chapter pages all use the same gradient treatment.
- **Balance / rhythm:** no slide is markedly louder or more washed-out than its neighbors. Flip
  through all slides as thumbnails — the color energy should feel even, with the brand felt on each.
- **Backbone present:** one primary hue carries the structural bits (progress bar, page-number badge,
  flagship figures, flywheel hub) across the whole deck.

**Whole-deck rubric (score Color 0–10).** A 10 = *accent reserved for one focal point per slide;
identical role→token mapping across all slides; passes the squint test everywhere; the brand is felt
on every page; zero hardcoded/AI-slop hexes.* Below 8 → fix and re-score.

## Multi-color brands within this model

A multi-color brand (Google, Microsoft, Slack) fits the same roles — it does **not** mean "color
everything":

- **Primary accent** = one brand hue in `--accent`, still capped ≤2 strong uses/slide.
- **Brand-expression role** = the *other* brand colors, allowed ONLY in **low-emphasis, quiet** slots:
  a static multi-color gradient on the consistent corner page-number badge; chapter-page gradients;
  and **soft tints** of a fixed 3-color sub-palette mapped (same order) onto the deck's small N-item
  sets (context cards / step badges / tabs / icons / nodes). Because these are *soft and small*, they
  pass the squint test — they color the page without competing for focus.
- This keeps the hard cap intact (soft brand tints aren't "strong accent uses") while letting the
  multi-color identity be felt on every page. The failure modes the review catches: **only the cover
  colored** (superficial) and **bold/saturated brand on everything or an animated badge** (loud).

## The loop

Don't ship on first pass. **Generate → run `scripts/validate-deck.sh` (deterministic hard gates) →
do the per-page review → fix every finding → re-review → only ship at a Color score ≥ 8 with the
linter clean.** Make findings specific and actionable (`{severity, id, message, fix}`) so correction
is one pass, not a guess.
