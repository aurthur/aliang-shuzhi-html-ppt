# HTML Report Deck

**An AI-agent skill for building self-contained, Apple-style HTML presentation decks** — for
performance reviews, project recaps, and reports. One `index.html` that opens full-screen in any
browser. No PowerPoint, no Keynote.

![cover](docs/preview-cover.png)

It's not a slide template you fill in by hand — it's a **design system + a workflow** that you hand to
a coding agent (Claude Code, Codex, Cursor, …). You give it your material; it builds the deck. Swap a
few color tokens to re-brand; swap text to re-content. The structure and Apple-grade polish are reused.

![results page](docs/preview-result.png)

## Why an HTML deck

A web page can do everything a slide can — and more: inline video, smooth motion, real product
screenshots, full-screen, keyboard navigation. Editing is conversational ("change this word
everywhere" is one instruction). And because the agent already knows every slide's intent, a spoken
script for your talk is nearly free. The output is one folder you zip and send; the recipient opens
`index.html`.

The catch every AI deck hits: the model's *first* unguided attempt looks like generic AI slop —
plastic gradients, emoji icons, a box around every sentence. This skill is the set of rules that fix
that.

## The three things that decide a deck

1. **Pin the page structure first.** Don't dump a wall of prose and let the model guess the
   pagination. Give it structured input (one block per topic) or outline it together — *then* build.
2. **Steal a great brand's design language; ban emoji.** Don't teach the model "taste" — point it at
   apple.com and have it emulate. Forbid emoji icons (the #1 tell of a cheap AI deck); use one
   open-source line-icon set instead.
3. **Be restrained.** In a review, content outranks form. Animate one or two moments — not everything.

## How to use it

1. Drop this folder where your agent can read it (e.g. as a skill, or just point it at `SKILL.md`).
2. Ask: *"Make me an HTML deck for my review from this material …"*
3. The agent follows `SKILL.md`: understands the goal → **confirms a page-by-page outline with you**
   → themes (defaults to the bundled palette) → builds from `templates/deck-template.html` → lints
   with `scripts/validate-deck.sh` → packages.
4. Open `examples/business-deck/index.html` to see what "good" looks like (← / → to navigate, `F` for
   full-screen).

## What's inside

```
html-report-deck/
├── SKILL.md                       # agent entry point: workflow, layout menu, build checklist
├── references/
│   ├── design-system.md           # tokens: color · type · spacing · shadow · motion · numbers
│   ├── design-principles.md       # do's & don'ts + the hard prohibitions
│   ├── components.md              # the closed menu of named slide layouts
│   ├── workflow.md               # request → outline → build → verify → package
│   └── verify.md                 # overflow, animation sync, banned-pattern checks
├── templates/
│   └── deck-template.html         # blank, themeable starter (engine + full CSS + placeholders)
├── examples/business-deck/        # a complete, DESENSITIZED sample deck (the reference)
│   ├── index.html
│   ├── assets/                   # images (rendered mock UIs) + demo videos
│   └── _mocks/                   # the HTML sources for the realistic screenshot mocks
└── scripts/
    └── validate-deck.sh           # lints a deck against the non-negotiable rules
```

## Design system at a glance

- **Apple font, no web-font:** `-apple-system / SF Pro Display + 苹方 PingFang SC` — system-native, works
  offline and when projecting. (SF Pro can't be legally web-embedded, so it's a fallback chain.)
- **Restrained color:** a near-neutral surface, near-black ink, and **one accent**. Brand color appears
  only on numbers, labels, icon badges, key words, and chapter-page gradients.
- **Numbers as a first-class rule:** ▲ green = up, ▼ red = down, exactly **one brand-blue flagship**
  per data page; numbers count up on entry.
- **Soft layered shadows**, 18–22px radius, generous whitespace, one focal element per slide.
- **One signature animation** per deck (e.g. an orbiting flywheel) — a garnish, not the dish.
- **Token-based theming:** change `--accent` (+ shades) and the chapter gradient to re-brand. The
  default is a black-&-white business theme; any color is supported.

## The non-negotiables

- ❌ No emoji as icons → one open-source line-icon set (SVG sprite).
- ❌ No card with a left vertical color bar (the AI-generated tell).
- ❌ Don't box every statement → a viewpoint is large text with a colored keyword, not a tinted box.
- ❌ No showy, deck-wide animation in a review context.

`scripts/validate-deck.sh` enforces the first three.

## License

[MIT](LICENSE) © 2026 Arthur Wu. The sample deck is fully fictional/desensitized — the "AI Console"
product and all figures are made up for illustration.
