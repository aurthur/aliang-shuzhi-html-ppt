#!/usr/bin/env bash
# validate-deck.sh — lint a deck HTML against the non-negotiable design rules.
# Usage: scripts/validate-deck.sh path/to/index.html
# Exit 0 = clean; exit 1 = violations printed.
set -u
FILE="${1:-}"
if [[ -z "$FILE" || ! -f "$FILE" ]]; then
  echo "usage: validate-deck.sh <deck.html>"; exit 2
fi

fail=0
note(){ echo "  ✗ $1"; fail=1; }

echo "Validating: $FILE"

# 1) Emoji used as icons (any emoji is a violation). Python for reliable unicode ranges.
emoji=$(python3 - "$FILE" <<'PY'
import re,sys
txt=open(sys.argv[1],encoding='utf-8',errors='ignore').read()
rng=re.compile('[\U0001F000-\U0001FAFF\U00002600-\U000027BF\U0001F1E6-\U0001F1FF←-⇿⬀-⯿️]')
# allow intentional typographic marks: number deltas (▲▼), bullets (◆·), arrows (←→×),
# and engine UI-chrome control glyphs (⛶ fullscreen, ‹ › nav). NOT decorative content icons.
allowed=set('▲▼◆←→×·⛶‹›')
hits=[c for c in txt if rng.match(c) and c not in allowed]
print(len(hits))
print(''.join(sorted(set(hits)))[:40])
PY
)
ecount=$(echo "$emoji" | sed -n '1p'); echars=$(echo "$emoji" | sed -n '2p')
[[ "${ecount:-0}" -gt 0 ]] && note "emoji found ($ecount): $echars  → use an open-source line-icon SVG set instead"

# 2) Left vertical color-bar cards (the AI-generated tell)
if grep -nE 'border-left:[[:space:]]*[34]px[^;]*(accent|brand|#)' "$FILE" >/dev/null 2>&1; then
  note "left vertical color-bar on a card/lead (border-left:3/4px accent) — remove it:"
  grep -nE 'border-left:[[:space:]]*[34]px' "$FILE" | sed 's/^/      /'
fi

# 3) Web-font dependency (should be system Apple fonts, offline-safe)
if grep -nE 'Noto Sans SC|fonts\.googleapis|fonts\.gstatic' "$FILE" >/dev/null 2>&1; then
  note "web-font dependency found (Noto / Google Fonts) — use the system Apple stack (SF Pro + PingFang SC):"
  grep -nE 'Noto Sans SC|fonts\.googleapis|fonts\.gstatic' "$FILE" | sed 's/^/      /'
fi

# 4) Leftover placeholders
if grep -nE 'TODO|FIXME|占位|lorem ipsum|REPLACE-ME' "$FILE" >/dev/null 2>&1; then
  note "leftover placeholder text:"
  grep -nE 'TODO|FIXME|占位|lorem ipsum|REPLACE-ME' "$FILE" | sed 's/^/      /'
fi

# 5) AI-slop default hexes (Tailwind indigo/violet) — the #1 "generic AI" palette tell.
#    Allowed only if it's the deck's actual brand, declared on a --accent* line in :root.
slop='#6366f1|#4f46e5|#4338ca|#3730a3|#8b5cf6|#7c3aed|#a855f7'
if grep -niE "$slop" "$FILE" | grep -viE '\-\-accent' >/dev/null 2>&1; then
  note "AI-slop default palette (Tailwind indigo/violet) used outside --accent — pick a real brand color:"
  grep -niE "$slop" "$FILE" | grep -viE '\-\-accent' | sed 's/^/      /' | head -6
fi

# 6) Raw-hex drift in the body (hardcoded colors instead of tokens). Informational.
bodyhex=$(grep -oiE 'style="[^"]*#[0-9a-f]{3,6}' "$FILE" | wc -l | tr -d ' ')
[[ "${bodyhex:-0}" -gt 16 ]] && echo "  ℹ $bodyhex inline hex colors in body — consider moving repeated ones into :root tokens"

if [[ "$fail" -eq 0 ]]; then
  echo "  ✓ deterministic gates clean (no emoji / left-bar / web-font / placeholder / AI-slop palette)"
fi
echo ""
echo "  → The linter cannot see visual balance. Now run the BRAND-COLOR REVIEW (references/brand-review.md):"
echo "    per-page squint + ≤2 strong accent uses/slide + 70-90/5-10/0-5 proportion, then whole-deck consistency."
echo "    Only ship at a Color score ≥ 8."
exit $fail
