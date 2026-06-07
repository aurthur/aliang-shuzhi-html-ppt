# Workflow — from request to packaged deck

The order matters more than any single step. **Talking the structure through with the user up front
is what separates a one-shot good deck from endless re-work.**

## Contents
- [1. Understand](#1-understand)
- [2. Gather material](#2-gather-material)
- [3. Confirm the page outline](#3-confirm-the-page-outline-do-not-skip)
- [4. Theme](#4-theme)
- [5. Build](#5-build)
- [6. Verify](#6-verify)
- [7. Package & hand off](#7-package--hand-off)
- [Common concerns to answer](#common-concerns-to-answer)

## 1. Understand

Ask before assuming. The answers shape pagination and tone:

- **Goal** — what is this deck for? (performance review, project recap, kickoff, sales…)
- **Audience** — who reviews it? A boss who likes restraint? A team? This sets how much polish/animation.
- **Tone** — confident-and-plain (default for reviews) vs. energetic (creative/marketing).
- **The 1–2 things they most want remembered.** These become the flagship figures / the signature moment.
- **Length / format** — rough page count, projector vs. share-as-file.

## 2. Gather material

Get the actual source: the doc, the numbers, screenshots, any brand/logo, reference site to emulate.

**Structured input paginates far better than prose.** Ideal shape — one block per topic:

```
## <Direction / Project name>
- Background: one or two sentences of context
- Goal & hypothesis: what you bet on and why
- Key data: the 2–4 numbers that matter (with the one flagship)
- What we did: the concrete actions (+ screenshots if any)
- To-do: next steps (mark the one priority)
```

If the user only has a wall of prose, **don't feed it raw** — help them outline it into blocks first,
or draft the outline yourself and have them correct it. A wall of text makes the model paginate by
vibe, and the result is rarely the structure they wanted.

## 3. Confirm the page outline (do NOT skip)

Propose a numbered slide list and get an explicit yes before generating any HTML. Example:

```
01 Cover
02 Stage-setting (one-sentence what-I-do)        [statement]
03 Headline results                              [data-result]
04 Section divider — "how we did it"             [section-divider]
05 The play (levers)                             [overview / statement]
06 What we actually did + screenshots            [layered-shots]
07 Thinking & hypothesis                         [hypothesis-funnel]
08 The model                                     [flywheel]
09 Systems / product screenshots                 [screenshot-carousel]
10 Section divider — "what's next"               [section-divider]
11 Next steps                                    [todo-featured]
12 Closing                                       [closing]
```

Map each line to a named layout from `components.md`. Adjust with the user, then build.

## 4. Theme

- If the user names brand colors or a reference site → use them; confirm only what changes.
- If they don't choose → **use the default business-blue sample palette and tell them so** ("using
  the default black-&-white business theme; I can re-brand to any color — just say"). Don't block.
- Replace the logo placeholder if they have one.

## 5. Build

- Start from `templates/deck-template.html` (engine + full CSS + placeholder slides).
- One slide = one named layout (`components.md`). Fill with content; don't hand-roll per-slide CSS.
- Obey `design-principles.md` (no emoji, no left-bar, plain statements, restraint) and number rules.
- For screenshots: real ones, or build + render mocks (see design-principles → Imagery).

## 6. Verify

Run the checks in `verify.md` and the lint script:

```bash
scripts/validate-deck.sh path/to/index.html   # 0 violations before handoff
```

Then preview, step through every slide, fix overflow, confirm the one animation syncs.

## 7. Package & hand off

- **Distribution**: zip the whole folder (HTML + `assets/`). Recipient unzips, opens `index.html` —
  works in any browser, like sharing a folder.
- **Fonts**: the deck uses system Apple fonts (no embed needed). If a target machine might lack them
  and exact rendering matters, bundle a fallback (e.g. Inter) and note it.
- **Speaker notes**: offer to draft a spoken script — the model already knows every slide's intent,
  so this is nearly free. Ask for length / audience / style and generate.
- **Editing caveat**: changing a word still means "tell me which slide + what," then regenerate. For
  heavy live edits, consider adding a small in-page edit mode; otherwise batch edits ("change X
  everywhere") are one instruction and replace globally.

## Common concerns to answer

- **Fullscreen / page-turn / presenter view?** Yes — it's a web page. Fullscreen is built in (F);
  arrow-key navigation is built in; a presenter view can be added on request.
- **Compatibility on another machine / the venue laptop?** It's one HTML file + media; any browser
  opens it. The only risk is missing fonts (same as PowerPoint) — bundle fonts to be safe.
- **How do I send it?** Zip the folder; they open `index.html`. No special software.
