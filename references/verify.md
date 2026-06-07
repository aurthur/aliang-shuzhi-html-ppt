# Verify — prove the deck is correct before handoff

Don't eyeball-and-ship. Run the lint, then the runtime checks.

## Contents
- [1. Static lint](#1-static-lint)
- [2. Overflow](#2-overflow)
- [3. Banned patterns](#3-banned-patterns)
- [4. Animation sync](#4-animation-sync)
- [5. Screenshot recipe (the gotcha)](#5-screenshot-recipe-the-gotcha)

## 1. Static lint

```bash
scripts/validate-deck.sh path/to/index.html
```

Fails (non-zero) on: any emoji, a `border-left` accent bar on a card/lead, a Noto / Google-Fonts
`<link>`, or a stray `TODO`. Fix to zero before continuing.

## 2. Overflow

Each slide's content must fit the 720px canvas. Activate every slide and measure the body region:

```js
// in the page console / preview eval
[...document.querySelectorAll('.slide')].map(s => {
  document.querySelectorAll('.slide').forEach(x => x.classList.remove('active'));
  s.classList.add('active');
  const b = s.querySelector('.body');
  return { id: s.id, overflow: b ? b.scrollHeight - b.clientHeight : 0 };
}).filter(r => r.overflow > 1);   // must be []
```

Absolutely-positioned children (layered shots, ring nodes) don't expand `.body` — for those, also
check each element's rect stays within the 1280×720 stage and above the footer.

## 3. Banned patterns

```bash
grep -nE "border-left:[34]px" index.html          # vertical-bar cards → must be empty
grep -nP "[\x{1F000}-\x{1FAFF}\x{2600}-\x{27BF}]" index.html   # emoji → must be empty
grep -n "Noto\|fonts.googleapis" index.html        # web-font dependency → must be empty
```

## 4. Animation sync

If the deck has the flywheel, the orbiting arrow must light the node it's actually passing. The arrow
reaches node *k* at `t = 2·(k−1)s`; node glow peaks at the start of its `pass` keyframe, so node
delays run **reversed**: `0, -8s, -6s, -4s, -2s` for 5 nodes. Verify deterministically:

```js
// sweep the global animation clock and confirm the passed node is the bright one
const anims = document.getAnimations();
[0,2,4,6,8].forEach(t => { anims.forEach(a => a.currentTime = t*1000); /* inspect which node has glow */ });
```

A misordered delay makes nodes light in reverse — the classic "the animation doesn't match the arrow"
bug. Fix the delay order, not the geometry.

## 5. Screenshot recipe (the gotcha)

When screenshotting via a headless preview, the backing surface often differs from the emulated
viewport, so the stage renders small/offset. Reliable recipe: resize the viewport to **800×1010**,
then pin the scale yourself before shooting:

```js
const s = 800/1280;                       // fixed scale
const st = document.getElementById('stage');
st.style.transform = `translate(-50%,-50%) scale(${s})`;
st.style.top = '225px'; st.style.left = '400px';
// activate the target slide, then screenshot
```

Note the slide-in animation starts at opacity 0 — if a shot looks dim/empty, you caught it mid-fade;
re-shoot a moment later.
