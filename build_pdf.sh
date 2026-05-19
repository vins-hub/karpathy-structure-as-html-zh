#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

OUTPUT="Karpathy-HTML-Output-繁中精解-合輯.pdf"
COMBINED=/tmp/karpathy-html-combined.md

{
  cat README.md; echo -e "\n\n\\pagebreak\n\n"
  for f in content/01-the-output-bottleneck.md \
           content/02-the-html-method.md \
           content/03-use-cases.md \
           content/04-template-library.md \
           content/05-anti-patterns.md \
           content/06-advanced-interactivity.md \
           content/07-relation-to-12-factor.md \
           content/appendix-html-css-cheatsheet.md; do
    cat "$f"; echo -e "\n\n\\pagebreak\n\n"
  done
} > "$COMBINED"

TMP_HTML=/tmp/karpathy-html.html
pandoc "$COMBINED" -o "$TMP_HTML" --standalone --metadata title="Karpathy +HTML 繁中精解" \
  --css=<(cat <<'CSS'
body { font-family: -apple-system, "PingFang TC", "PingFang SC", sans-serif; max-width: 820px; margin: 2rem auto; padding: 0 1.5rem; line-height: 1.65; color: #222; }
h1, h2, h3, h4 { border-bottom: 1px solid #eee; padding-bottom: 0.3em; margin-top: 1.8em; }
h1 { font-size: 1.9em; } h2 { font-size: 1.5em; } h3 { font-size: 1.2em; }
code { font-family: Menlo, monospace; background: #f5f5f5; padding: 0.1em 0.35em; border-radius: 3px; font-size: 0.92em; }
pre { background: #f5f5f5; padding: 0.9em; border-radius: 5px; overflow-x: auto; font-size: 0.88em; line-height: 1.45; }
pre code { background: transparent; padding: 0; }
blockquote { border-left: 4px solid #888; padding-left: 1em; color: #555; }
table { border-collapse: collapse; width: 100%; margin: 1em 0; font-size: 0.92em; }
th, td { border: 1px solid #ccc; padding: 0.4em 0.7em; text-align: left; vertical-align: top; }
th { background: #f0f0f0; }
a { color: #0366d6; text-decoration: none; }
CSS
)

"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --headless --disable-gpu --print-to-pdf="$OUTPUT" --no-pdf-header-footer \
  --virtual-time-budget=10000 "file://$TMP_HTML" 2>/dev/null || true

ls -la "$OUTPUT"
