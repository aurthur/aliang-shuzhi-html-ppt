# Components — the named slide layouts

A closed menu. Compose a deck by choosing a layout per slide and filling it — don't invent per-slide
CSS. Each layout is a `<section class="slide" id="…">` in `templates/deck-template.html`; the live
reference for all of them is `examples/business-deck/index.html`.

## Contents
- [cover](#cover) · [section-divider](#section-divider) · [overview-table](#overview-table)
- [data-result](#data-result) · [statement](#statement) · [hypothesis-funnel](#hypothesis-funnel)
- [flywheel](#flywheel) · [screenshot-carousel](#screenshot-carousel) · [layered-shots](#layered-shots)
- [todo-featured](#todo-featured) · [video-wall](#video-wall) · [closing](#closing)

## cover
Title page. Dark background (`--dark`) + a soft brand glow + faint grid; logo top-left. **Title big and
centered** (80px+), one accent keyword. A one-line meta row (`.csub`) underneath.
Use for: slide 1. Avoid: cramming it into a corner — empty space reads as unfinished.

## section-divider
`.divider` — dark, a huge chapter number (`--accent`), a short chapter title, and a right-side agenda
that highlights the current chapter. Put one before each new direction so the audience never "jumps."
Use for: between major sections.

## overview-table
A one-screen map of all directions. Columns: `# / direction / one-line what / the single best result`.
Full direction names, the "what" compressed to a sentence, **only the most compelling result** per row.
Use for: an at-a-glance agenda after the cover/results.

## data-result
`.dgrid` = a `.hero` (the headline) + a `.side` column of small cards. The hero holds 1–2 big
`.figure`s (the second can be the brand-blue flagship) + a one-line takeaway + a `.mini` row of
secondary metrics. Side cards carry supporting figures (e.g. cost ▼, reproducibility).
Numbers follow the Numbers rule (▲green/▼red/one blue; count-up). Use for: showing results.

## statement
The simplest, most Apple layout: **one big sentence** in `--fd`, 22–24px/700, with one or two
brand-colored keywords. **No box.** Optionally a smaller gray sub-line below (`.s`). Use for:
stage-setting, a thesis, a hypothesis headline, a conclusion. This replaces the urge to make a card.

## hypothesis-funnel
A `statement` headline + a `.funnel` of horizontal bars (each: a gutter label + a width-scaled bar).
**Mark the bottleneck bar with the single `--warn` (orange) highlight + a pulse** so the constraint
pops; all other bars are neutral grays. Bars stagger-fade in. Align the headline's left edge with the
bars (indent past the label gutter). Use for: explaining the bet / where the constraint is.

## flywheel
`.ring` — the one signature animation. A dashed circle, an arrow that orbits (10s), nodes placed on
the ring that glow as the arrow passes (`@keyframes pass` + per-node `animation-delay` reversed:
`0, -8s, -6s, -4s, -2s` for 5 nodes), a brand-gradient hub in the center. Beside it, a `statement`
explaining the model + 1–2 plain note rows. Use for: a self-reinforcing loop / business model.
Keep it subtle; verify arrow↔node sync (see `verify.md`).

## screenshot-carousel
`.ucard` containing stepped tabs (`.steps`) + a `.carousel` of panels; each panel = a large real
screenshot (`.cimg img`, `object-fit:cover`) + a text column (`.ctext`: badge + title + description).
Arrow keys advance the internal panel before turning the slide. Description text large enough to read.
Use for: showing several product/system screens one at a time.

## layered-shots
`.means` — left: a `statement` of the method + a borderless numbered step list (`.mlist`/`.mstep`,
no card boxes); right: **two real screenshots layered** (one behind top-right, one offset front
bottom-left, stronger shadow). Use for: "here's concretely what we did," with proof images.
Build the images as real PNGs (real screenshots or rendered mocks) — never gray placeholder boxes.

## todo-featured
`.tgrid` as flex: **left = one featured priority block** (`.tcard.feat`, solid brand-gradient, big
icon, "priority" badge, big title, one-line why) + **right = a column of 3 plain cards**. Creates
hierarchy instead of an even 2×2 grid. Use for: next steps when one item leads.
(Only use an even grid when the items are genuinely equal.)

## video-wall
`.vids` — **left = one featured video** (bigger, brand border, a "★ featured" badge) + **right = two
smaller** stacked. Each `<video>` has a realistic **poster** image (a product frame), `controls`,
`muted loop playsinline preload="metadata"`. Inline playback. Use for: demos / clips / material.

## closing
`.closing` — logo, a final brand-keyword line, one short sentence (not a paragraph), and a spaced row
of chapter tags. **Give it breathing room** (generous gaps, short copy). Use for: the last slide.

---

### Engine (shared, don't rewrite)
The template ships a small JS engine: keyboard nav (←/→/Space/F/Home/End), progress bar + page number,
auto-pause video on slide change, carousel internal-step navigation, count-up animation, and the
`fit()` scaler. Author content; leave the engine alone.
