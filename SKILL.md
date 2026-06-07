---
name: aliang-shuzhi-html-ppt
description: >-
  Builds a self-contained, Apple-style HTML presentation deck — one .html file that opens
  full-screen in any browser, no PowerPoint or Keynote. A flexible design system (brand-color
  tokens, a closed menu of named slide layouts, explicit motion and number-styling rules) plus a
  workflow that confirms the page-by-page structure with the user before generating slides. Use
  when the user wants an HTML PPT / HTML deck / HTML slides, a 述职 / 汇报 / 年终 / 年中 / 项目复盘 /
  report deck, wants to turn a document or dataset into a presentation, or asks for an Apple-style
  / on-brand deck. Default theme is a black-&-white business sample; brand colors are swappable.
---

# 阿亮 · 述职 HTML PPT — Apple 风格 HTML 演示设计系统

> **This file is the entry point of a folder-based skill — not standalone.** It references sibling
> files under `references/`, `templates/`, `examples/`, and `scripts/`. Use the whole folder.

A design system + workflow for building **self-contained HTML decks** for performance reviews and
reports. The output is a single `index.html` (plus an `assets/` folder) that runs full-screen in any
browser — keyboard navigation, progress bar, inline video, restrained animation. Swap a handful of
color tokens to re-brand; swap text to re-content. The structure and Apple-grade polish are reused.

This skill exists because the AI's *first* unguided attempt at "a slick deck" tends to look like
generic AI slop — plastic gradients, emoji icons, boxes around everything. The rules here are what
turn that into something that reads as designed.

## The one rule that matters most

**Do not start generating slides until the page structure is agreed.** The single biggest failure
mode is dumping a wall of text at the model and letting it guess the pagination. Always run the
workflow: understand the goal and audience → gather the source material → **confirm a page-by-page
outline with the user** → only then build. See `references/workflow.md`.

## Workflow (always follow)

1. **Understand** — goal, audience (who reviews this?), tone, the one or two things they most want
   remembered. Ask; don't assume.
2. **Gather material** — the source doc / data / numbers / screenshots. Structured input (one block
   per topic, with background · goal · key data · thinking · to-do) paginates far better than a wall
   of prose. If the user only has prose, help them outline it first.
3. **Confirm the page outline** — propose a numbered slide list and get a yes before building.
4. **Theme** — default to the bundled sample's brand tokens unless the user names brand colors /
   a reference site to emulate. Confirm only what actually changes.
5. **Build** — start from `templates/deck-template.html`, assemble components from
   `references/components.md`, obey `references/design-principles.md`.
6. **Verify** — run `scripts/validate-deck.sh` (hard gates), then the **brand-color review**
   (`references/brand-review.md`): per-page squint + ≤2 strong accent/slide + whole-deck consistency.
   Plus overflow & animation sync. See `references/verify.md`.
7. **Package & hand off** — zip the folder; the recipient unzips and opens `index.html`. Offer a
   speaker-notes draft (the model already knows every slide's intent — this is nearly free).

Full detail, with the questions to ask and the structured-input template: `references/workflow.md`.

## Named slide layouts (compose from this closed menu — don't hand-roll per-slide CSS)

`cover` · `section-divider` · `overview-table` · `data-result` · `statement` (one big sentence) ·
`hypothesis-funnel` · `flywheel` (animated cycle) · `screenshot-carousel` · `layered-shots` ·
`todo-featured` (one priority block + a list) · `video-wall` · `closing`.

Each maps to a block in `templates/deck-template.html` and is specified in `references/components.md`.
Pick a layout per slide; fill it with the user's content; theme via tokens. A typical review deck:
cover → statement/overview → data-result ×N → section-divider → how-we-did-it (statement +
layered-shots / flywheel) → todo-featured → closing.

## Build checklist (copy into your working notes)

- [ ] Goal, audience, and the 1–2 must-remember points are written down
- [ ] Source material gathered; **page-by-page outline confirmed with the user**
- [ ] Theme chosen (default sample palette unless brand colors given) — told the user it's the default
- [ ] Built from `templates/deck-template.html`; each slide is a named layout
- [ ] Numbers styled per rule (▲green / ▼red / one brand-blue flagship; count-up on entry)
- [ ] Icons are one open-source line set — **zero emoji**
- [ ] **No left-vertical-bar cards; statements are plain text, not boxes**
- [ ] Animation is restrained (1–2 moments, not every element)
- [ ] Ran `scripts/validate-deck.sh <file>` → 0 violations; fixed overflow; verified per `references/verify.md`
- [ ] Ran the **brand-color review** (`references/brand-review.md`): every slide passes the squint test
      (≤2 strong accent uses), the deck is color-consistent, Color score ≥ 8
- [ ] Packaged (zip with assets + fonts note); offered a speaker-notes draft

## The design system

- **`references/design-system.md`** — the tokens and visual language: color token set, the **Apple
  font stack (SF Pro + 苹方 PingFang SC — never Noto)**, soft layered shadows, spacing, radius, the
  1280×720 fixed canvas + auto-scale engine, and **how numbers are styled** (green = up, red = down,
  brand-blue = the one flagship figure; count-up on entry).
- **`references/design-principles.md`** — the do's and don'ts, including the hard prohibitions:
  **no emoji (use one open-source line-icon set), no card with a left vertical color bar, restrained
  animation, fewer cards (plain text for statements).** Read this before styling anything.
- **`references/brand-review.md`** — how to **constrain + verify** brand-color usage so you don't
  over/under-color: bounded color roles + proportion + a ≤2-accent-per-slide cap (the constraint), and
  a per-page (squint test) + whole-deck review pass (the verification). Use for any re-brand.
- **`references/components.md`** — the layout component catalog: cover, section divider, overview
  table, data/result page, thinking-&-hypothesis infographic, animated flywheel/cycle, screenshot
  carousel, layered real-screenshot page, To-Do (featured + list), video wall, closing.
- **`references/verify.md`** — how to actually check the result (overflow, deterministic animation
  sync, screenshot recipe, banned-pattern grep).

## Theming (the flexibility)

Everything brandable lives in `:root` as tokens. For a **single-color brand** (Apple, a corporate
blue/green/violet), re-branding is just changing `--accent` (+ its `-d`/`-soft`/`-line` shades) and
the cover/divider/closing gradient. The bundled example uses an Apple-blue business theme.

⚠️ For a **multi-color brand** (Google, Microsoft, Slack…), changing one `--accent` is NOT enough —
it collapses the identity into one color and the brand only shows on the cover. The sweet spot is
*soft, consistent, static* distribution: a **static** multi-color gradient on the top-left page-number
badge (a "brand mark", **not animated**), a multi-color gradient on chapter pages, and **soft tints of
a fixed 3-color sub-palette mapped (same order) onto the deck's small N-item sets** — the context
cards, step badges, carousel tabs, To-Do icons, flywheel nodes. Keep one primary for the big bits.
See `references/design-system.md` → "Multi-color brands". **If the user doesn't choose, default to the
sample's palette and tell them it's the default + that it's swappable.**

## What's in this repo

- `examples/business-deck/` — a complete, **desensitized** sample deck ("把 token 变成增长和收入"),
  the canonical reference for what "good" looks like. Open `index.html`.
- `examples/business-deck/_mocks/` — the HTML sources used to render the realistic product
  screenshots via headless Chrome (the "real screenshots, not placeholder boxes" technique).
- `templates/deck-template.html` — a blank, themeable starting skeleton (engine + full CSS + a few
  placeholder slides).

## Hard prohibitions (never, even if asked offhandedly)

- ❌ **Emoji as icons.** Use one consistent open-source line-icon set (e.g. Lucide), inline as SVG
  `<symbol>` sprites. (From the article: emoji icons are the #1 tell of a cheap AI deck.)
- ❌ **Cards with a left vertical color bar / "lead" strips.** Reads as AI-generated. To emphasize a
  card: tinted gradient background, stronger shadow lift, or a solid-color icon badge — never a bar.
- ❌ **Boxing every statement in a card.** A viewpoint / hypothesis / conclusion is large text on the
  page with a colored keyword — not a tinted box. Cards are for genuinely block-like content.
- ❌ **Showy animation in a review context.** Content outranks form; animate one or two moments, not
  the whole deck.

See `references/design-principles.md` for the full list and the rationale.
