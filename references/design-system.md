# Design System — Apple-style HTML Deck

The visual contract. Every token here lives in the deck's `:root`; re-theming = changing tokens, not
structure. Schema follows a portable design-spec shape: **color · typography · spacing · layout ·
elevation · motion · numbers · voice · brand · anti-patterns**.

## Contents
- [Token philosophy](#token-philosophy)
- [Color](#color)
- [Typography](#typography)
- [Spacing & layout](#spacing--layout)
- [Elevation (shadows)](#elevation-shadows)
- [Motion](#motion)
- [Numbers](#numbers)
- [Voice & tone](#voice--tone)
- [Brand & theming](#brand--theming)
- [Anti-patterns](#anti-patterns)

## Token philosophy

Three tiers, named by **meaning, not value** (`--accent`, never `--blue`):

1. **Primitive** — raw values you rarely touch (`#0A84FF`, `52px`).
2. **Semantic** — meaning-based aliases the deck actually uses: `--accent`, `--pos`, `--neg`,
   `--ink`, `--gray`, `--sh2`.
3. **Component** — scoped, derived from semantic tokens in component CSS (`.tcard.feat` background).

To re-brand, you change a few **semantic** tokens. Components inherit automatically.

## Color

Restraint is the whole game: a near-neutral surface, near-black ink, and **one accent**. Color marks
hierarchy and meaning — never decoration. The bundled "business" theme:

```css
:root{
  /* accent (the single brand color + its shades) */
  --accent:#0A84FF; --accent-d:#0060df; --accent-soft:#eaf3ff; --accent-line:#cfe2ff;
  /* semantic status — used ONLY on numbers/deltas, see Numbers */
  --pos:#1faa4b; --pos-soft:#e9f7ec;   /* up / good */
  --neg:#e0322f; --neg-soft:#fdecec;   /* down / bad */
  --warn:#F08A24; --warn-soft:#fdf0e2; /* the single "bottleneck" highlight */
  /* neutrals — the Apple base */
  --ink:#1d1d1f; --gray:#6e6e73; --gray2:#86868b;
  --bg:#f5f5f7; --card:#ffffff; --line:#e8e8ed; --line2:#eeeef1; --hair:rgba(0,0,0,.06);
  --dark:#0b0b0e; /* cover/divider/closing background */
}
```

Rules:
- **Brand color appears only in**: numbers/flagship figures, small uppercase labels, icon badges,
  the one or two bold keywords in a statement, and the cover/divider/closing gradients.
- **Body text is `--ink`; secondary is `--gray`.** Never tint paragraphs.
- **Every page earns exactly one brand-color moment.** If a content page has no accent anywhere,
  add one (a figure, a key card, an icon) — but only one focus.
- Light surfaces, not dark — soft shadows read on light and vanish on dark (Apple HIG: darker
  materials hide shadows and reduce depth).

**Color roles & budget (the constraint, not a vibe).** The brand hue is a *role*, not a free color:
it lives only in `--accent` (the solid-fill/CTA role); everything else is neutral or semantic. Per
slide target: neutral **70–90%** · accent **5–10%** · semantic **0–5%**. **Hard cap: ≤ 2 *strong*
accent uses per content slide** (fills/CTAs/large colored figures/links; small soft-tint badges don't
count). Getting "the right amount of color" is a judgment you *verify*, not a recipe you follow once —
**run the per-page + whole-deck review in `references/brand-review.md` before shipping.**

## Typography

**Apple's web font, no Noto, no web-font `<link>` (system-native = zero-network, works offline /
when projecting).** SF Pro can't be legally web-embedded, so rely on the system fallback chain;
Chinese falls to 苹方 PingFang SC, which is the genuine apple.com/cn look.

```css
--font:-apple-system,BlinkMacSystemFont,"SF Pro Text","PingFang SC","Helvetica Neue",Helvetica,Arial,sans-serif;
--fd:-apple-system,BlinkMacSystemFont,"SF Pro Display","PingFang SC","Helvetica Neue",Helvetica,Arial,sans-serif;
```

- `--fd` (**Display**, ≥20px): titles, big figures, statements. `--font` (**Text**, <20px): body, labels.
- **2–3 weights only**: Regular 400 / Semibold 600 / Bold 700–800. Avoid thin weights at large sizes.
- Note: 苹方 has no 900 Black — large headings render a touch lighter than Noto would. That's correct
  and on-brand; do not switch to Noto to get heavier headings.
- Chinese titles: **no negative letter-spacing** (it crowds); latin may use a slight negative.
- Cross-platform fallback (non-Apple machines): add `"Inter"` after `SF Pro Display` if you ship Inter.

Type scale (the sample): page title 40px/700 · big figure 64px/800 · statement 22–24px/700 ·
body 14–16px/400–500 · label 11.5px/600 uppercase.

## Spacing & layout

- **Fixed canvas 1280×720**, content margins **72px** L/R, title at 80px, body region top:150 → bottom:56.
- A tiny JS engine scales the 1280×720 stage to fill any window (`transform: scale()`), so you author
  in fixed px and forget responsive. One stage, one active `.slide`.
- Generous whitespace is a feature; **one focal element per slide** (big title / big figure / big
  image / big video). Everything else is support.
- Put a **section divider** before each new direction so the audience never "jumps" between topics.

## Elevation (shadows)

Soft, layered, low-opacity — never hard 1px borders for emphasis. Three tiers:

```css
--sh1:0 1px 2px rgba(17,17,26,.035), 0 5px 16px rgba(17,17,26,.05);
--sh2:0 2px 6px rgba(17,17,26,.05), 0 14px 34px rgba(17,17,26,.07);
--sh3:0 4px 12px rgba(17,17,26,.06), 0 26px 56px rgba(17,17,26,.10);
```

Cards: white fill + `--sh1/2` + 18–22px radius + a hairline `--hair` border. Lift a card with a
stronger shadow (`--sh3`), a faint brand gradient fill, or a solid icon badge — **never a left bar**.

## Motion

Restraint. Durations + easing are tokenized so nothing feels random:

- **Slide-in**: 0.5s `cubic-bezier(.22,.68,.18,1)`, opacity + 18px rise. (Every `.slide.active`.)
- **Count-up** numbers on entry: ~0.95s, easeInOutSine. Mark with `data-to` / `data-dec`.
- **Staggered bars** (funnel): each row fades + slides in, 0.05s steps.
- **One signature animation per deck max** (e.g. the flywheel ring: arrow orbits, the node it passes
  glows). It's a garnish, not the dish. If business results are weak or the audience's taste is
  unknown, dial animation down further — content outranks spectacle in a review.

## Numbers

How figures are styled is a first-class rule (a review lives or dies on its numbers):

- **▲ green (`--pos`) = increase / good; ▼ red (`--neg`) = decrease.** Color the +/− deltas
  consistently. Pair with a ▲/▼ glyph so direction is unambiguous even in grayscale.
- **Exactly one flagship figure per data page in brand-blue (`--accent-d`)** — the number you most
  want remembered. Everything else stays ink/green/red.
- Level metrics that aren't a change (a ratio, a share) stay `--ink` — don't force a color on them.
- **Count up on entry** (`data-to`, optional `data-dec`) — small motion that draws the eye to results.
- `font-variant-numeric: tabular-nums` so digits don't jitter.
- Real numbers only. Never invent a "looks reasonable" figure to fill a slot (honesty rule).

## Voice & tone

Review/述职 register: **plain, confident, content-first.** Lead with the result, then how. State the
viewpoint as one clear sentence (a colored keyword carries the emphasis) — don't dress it up. Titles
say what the slide is *about*, not a slogan. No sub-subtitles competing with the page title.

## Brand & theming

- **Default**: the business-blue sample (`--accent:#0A84FF`). When the user doesn't choose, use it and
  tell them it's the default and swappable.
- **Single-color brand re-brand** (Apple, a corporate blue/green/violet): change `--accent` + its
  `-d`/`-soft`/`-line` shades, and the cover/divider/closing gradient. That's the whole job. Keep
  neutrals/shadows/radius — that's the Apple base.
- **Logo**: replace the placeholder `<div class="lg">…</div>` with `<img>` in cover/divider/closing.

### ⚠️ Multi-color brands (Google, Microsoft, Slack, eBay, NBC…) — read this

Changing ONE `--accent` is **not** a re-brand for a multi-color brand — it collapses a several-color
identity into a single color, so the brand reads only on the cover while every content page looks
generic. (Real failure: a "Google colors" deck where only the cover had the 4 colors; inside it was
mono-blue and indistinguishable from the default.) But the opposite — bold, saturated brand color on
everything, or an animated badge — gets loud and busy. The sweet spot is **soft, consistent, static
distribution**:

1. **A static multi-color "brand mark" in one consistent spot.** The small element in the same place
   on every content page (the **top-left kicker page-number badge**) gets a multi-stop gradient of the
   palette. **Do not animate it** — a moving badge is distracting; a still gradient already reads as a
   living logo. The brand is felt on every page while content stays calm.
   ```css
   .kicker .num{background:linear-gradient(125deg,#4285F4,#34A853 40%,#FBBC05 66%,#EA4335);}
   ```
2. **Chapter pages get the full multi-color burst**: cover/closing keyword as a multi-stop gradient,
   divider numbers as a gradient across the glyphs. (Watch CSS specificity — `.divider .left .dno`
   beats `.divider .dno`; the gradient's `color:transparent` silently loses to the weaker selector.)
3. **Distribute SOFT tints of a fixed sub-palette across the deck's small "N-item sets"** — this is
   wanted, not forbidden, as long as it's *light and consistent*. Pick **3 colors** (e.g. Google
   blue/red/green) and map them, in the same order every time, onto each parallel set: the 3 context
   cards, the 3 step badges, the 3 carousel tabs, the 3 To-Do icons, the flywheel node badges. Use
   **light tints** — a pale colored background + a colored icon/heading — not bold saturated fills.
   Tiny number badges may stay solid (white numeral needs it). Soft + same mapping everywhere = the
   brand is felt throughout without shouting. (One genuinely 4-item set, like the combo levers, can
   use all 4 brand colors as a slightly bolder Workspace-icon moment.)
4. **Keep one primary** from the palette as the backbone for the big/structural bits (featured block,
   flywheel hub, progress bar, flagship figure, links): Google → blue, Microsoft → blue, Slack →
   aubergine.

**Semantics still win**: up=green / down=red on numbers regardless of brand; a light brand color
(e.g. Google yellow) on a filled bar/badge needs dark text for contrast. The two failure modes to
avoid: **(a) only the cover colored** (superficial), and **(b) bold color on everything / an animated
badge** (loud). Aim between them — soft, consistent, still.

## Anti-patterns

The full list with rationale is in `design-principles.md`. The non-negotiables: no emoji icons; no
card with a left vertical color bar; don't box every statement; don't over-animate; don't tint body
text; don't add a color "just because it matches."
