#!/usr/bin/env sh
set -eu

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
OUT_DIR="$ROOT_DIR/gh-pages-dist"
PACKAGE_DIR="$ROOT_DIR/report-package"

rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR"

if [ -f "$PACKAGE_DIR/index.html" ]; then
  cp -R "$PACKAGE_DIR"/. "$OUT_DIR"/
  echo "Published report from report-package/."
elif [ -d "$PACKAGE_DIR/site" ] && [ -f "$PACKAGE_DIR/site/index.html" ]; then
  cp -R "$PACKAGE_DIR/site"/. "$OUT_DIR"/
  echo "Published report from report-package/site/."
else
  generated_at=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  cat > "$OUT_DIR/index.html" <<EOF
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Report Package Pending</title>
    <style>
      :root {
        color-scheme: light;
        --bg: #f6f3ee;
        --ink: #1f1f1f;
        --accent: #0f766e;
      }
      body {
        margin: 0;
        font-family: ui-sans-serif, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        background: radial-gradient(circle at top right, #d9efe9, var(--bg) 45%);
        color: var(--ink);
        min-height: 100vh;
        display: grid;
        place-items: center;
      }
      main {
        max-width: 700px;
        margin: 24px;
        padding: 28px;
        background: #fffdf9;
        border: 1px solid #ddd7cc;
        border-radius: 14px;
        box-shadow: 0 8px 34px rgba(0, 0, 0, 0.08);
      }
      h1 { margin-top: 0; }
      code {
        background: #f2efe8;
        border-radius: 6px;
        padding: 2px 6px;
      }
      .stamp { color: #5a5a5a; font-size: 0.9rem; }
      a { color: var(--accent); }
    </style>
  </head>
  <body>
    <main>
      <h1>GitHub Pages plumbing is ready</h1>
      <p>
        The deployment workflow is active, but no finalized report package was
        found yet.
      </p>
      <p>
        Drop the validated package at <code>report-package/</code> (or
        <code>report-package/site/</code> with <code>index.html</code>), then rerun the
        workflow.
      </p>
      <p class="stamp">Generated: $generated_at</p>
    </main>
  </body>
</html>
EOF
  echo "Published placeholder because report-package/ was not found."
fi

touch "$OUT_DIR/.nojekyll"
