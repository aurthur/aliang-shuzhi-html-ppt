# Design Principles — what makes it read as *designed*, not AI-generated

The model's first unguided draft of "a slick deck" looks like AI slop: plastic gradients, emoji
icons, a box around every sentence. These rules are what fix that. Read this before styling anything.

## Contents
- [The three things that decide a deck](#the-three-things-that-decide-a-deck)
- [Hard prohibitions](#hard-prohibitions)
- [Cards: use sparingly](#cards-use-sparingly)
- [Layout & alignment](#layout--alignment)
- [Icons](#icons)
- [Animation: restraint](#animation-restraint)
- [Imagery: real, not placeholder](#imagery-real-not-placeholder)
- [Honesty rules](#honesty-rules)

## The three things that decide a deck

Everything else is secondary to these (learned the hard way doing a real review deck):

1. **Pin the pagination before building.** The model can't reliably guess how to split a wall of
   prose into slides — it paginates by vibe and you re-work it endlessly. Give it structured input
   (one block per topic: background · goal · key data · thinking · to-do) or outline it together
   first, then generate. This single step removes most of the pain. See `workflow.md`.
2. **Steal a great brand's design language; ban emoji.** Don't try to teach the model "taste."
   Point it at apple.com (or a brand the user/their boss respects) and have it emulate that language.
   And forbid emoji icons explicitly — they're the #1 tell of a cheap AI deck.
3. **Be restrained.** In a review, content outranks form. A little polish on strong work reads as
   "competent and careful." Heavy animation on weak work reads as "spent the time on the wrong
   thing." Pick one or two moments to shine; keep the rest calm.

## Hard prohibitions

- ❌ **Emoji as icons.** Use one open-source line-icon set (Lucide-style), inlined as SVG `<symbol>`
   sprites, consistent stroke width and size. Never mix emoji + symbols + icon-font.
- ❌ **A card with a left vertical color bar** (the `border-left:4px solid <brand>` "lead strip").
   It is the single most AI-generated-looking pattern. **High-frequency regression — grep
   `border-left` before every handoff** and delete any 3–4px accent bar on a card or lead (a 1px
   divider or an arrow triangle is fine). To emphasize a card instead: faint brand-gradient fill,
   stronger shadow, or a solid icon badge.
- ❌ **Too many cards.** See below.
- ❌ **Showy, deck-wide animation.** See Animation.
- ❌ **Tinting body text** or adding a color "just because it matches."

## Cards: use sparingly

The instinct to wrap every block in a rounded tinted box makes a deck feel busy and templated. Rule:

- **A statement is text, not a box.** A viewpoint / hypothesis / conclusion → large `--fd` text on
  the page with one or two **brand-colored keywords**. No background, no border, no icon chip.
  (Even a small tinted icon square counts as a box — drop it.)
- **Cards are for genuinely block-like, parallel content**: KPI figures, a screenshot, a To-Do item,
  a funnel bar, a carousel panel. If the content wouldn't fall apart without a box, don't add one.
- Self-test per block: *"Would this read fine as plain text/figure?"* If yes → no card.

## Layout & alignment

- **One focal element per slide.** Decide the star (title / figure / image / video); everything else
  recedes via size, weight, and whitespace — not via more color or borders.
- **Align text to the thing it describes.** A title/subtitle above a chart must share the chart's
  left edge. If a funnel has a 96px label gutter, indent the heading to line up with the *bars*, not
  hang off to the left. Misaligned heading↔chart is a common "feels off" that's actually just
  unaligned edges — check left edges with a measurement, don't eyeball.
- **Create hierarchy where items aren't equal.** Four to-dos with one priority → a big featured block
  (left) + three small items (right), not an even 2×2 grid. Even grids are for genuinely equal items.
- **Cover can be big and centered.** Empty corners read as unfinished — push the title large (80px+),
  center it, let one bold line own the canvas.
- **No sub-subtitle under the page title** — it splits "what is this slide about."

## Icons

One open-source line set (Lucide), as an inline SVG sprite:

```html
<svg width="0" height="0"><defs>
  <symbol id="i-target" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/>…</symbol>
</defs></svg>
<svg class="ic"><use href="#i-target"/></svg>
```

Stroke via CSS (`stroke:currentColor; fill:none; stroke-width:2`). Same visual weight everywhere.
Emphasis icons get a solid brand badge; normal ones a soft-tint badge — never different sources.

## Animation: restraint

- Slide-in + count-up are the always-on baseline (subtle).
- **One signature animation per deck** (e.g. the flywheel). It's a garnish.
- Don't animate every element, don't loop attention-grabbers behind content, don't auto-advance.
- Animation tokens (durations/easing) are in `design-system.md` — reuse them so motion feels coherent.

## Imagery: real, not placeholder

Abstract gray-box "screenshots" read as fake. Two honest options:

1. Use the user's real screenshots (crop clean, show large, never shrink to a stamp).
2. If desensitizing or none exist, **build a realistic mock UI in HTML with believable numbers and
   render it to a real PNG via headless Chrome**, then embed that:
   ```bash
   "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless=new \
     --hide-scrollbars --force-device-scale-factor=2 --window-size=1280,800 \
     --screenshot=out.png "file://$PWD/mock.html"
   ```
   A mock with real-looking figures (¥1,284,560 · 6.8% · 92) is far more convincing than a gray bar.
   See `examples/business-deck/_mocks/` for the sources used in the sample.
- Two related images → layer them (one behind, one offset in front, stronger shadow). Put the caption
  inside/near the image it explains, not in a separate column.

## Honesty rules

- Every number in the deck must have a real source. Never fabricate a placeholder score/rating to
  fill a slot — leave it out or say it's pending.
- If a metric's denominator is dirty or a result is unevaluable, say so plainly (a small note),
  don't bury it or paper over it.
- When data changes, update *every* place it appears (data page + overview table + any card).
- Desensitize before sharing: no real names, companies, customer data, internal URLs, or figures.
