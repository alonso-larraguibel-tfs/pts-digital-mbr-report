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
    <title>Product 360 MBR Readout - July 2026 (Preview)</title>
    <style>
      :root {
        color-scheme: light;
        --bg: #f3f0ea;
        --ink: #1e1b18;
        --muted: #6a6258;
        --accent: #0d9488;
        --panel: #fffdf9;
        --line: #e7dfd2;
      }
      * { box-sizing: border-box; }
      html, body { margin: 0; }
      body {
        font-family: "Avenir Next", Avenir, "Segoe UI", sans-serif;
        color: var(--ink);
        background:
          radial-gradient(circle at 10% 10%, #d9efe9 0%, rgba(217, 239, 233, 0) 36%),
          radial-gradient(circle at 95% 0%, #f6e9d8 0%, rgba(246, 233, 216, 0) 42%),
          var(--bg);
      }
      .shell {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
      }
      .topbar {
        background: rgba(255, 253, 249, 0.9);
        backdrop-filter: blur(6px);
        border: 1px solid var(--line);
        border-radius: 16px;
        padding: 16px 18px;
        display: flex;
        flex-wrap: wrap;
        gap: 14px;
        align-items: center;
        justify-content: space-between;
      }
      .title h1 {
        margin: 0;
        font-size: clamp(1.25rem, 2.3vw, 2rem);
        letter-spacing: 0.01em;
      }
      .title p {
        margin: 4px 0 0;
        color: var(--muted);
        font-size: 0.94rem;
      }
      .chips { display: flex; gap: 8px; flex-wrap: wrap; }
      .chip {
        border: 1px solid #cfe7e3;
        background: #ecfaf8;
        color: #0f766e;
        border-radius: 999px;
        padding: 6px 10px;
        font-size: 0.8rem;
        font-weight: 600;
      }
      .tabs {
        margin-top: 14px;
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
      }
      .tab {
        background: #f7f3ec;
        border: 1px solid var(--line);
        border-radius: 10px;
        padding: 8px 12px;
        font-size: 0.88rem;
        color: #4d453c;
      }
      .tab.active {
        background: #fff;
        border-color: #c7ddd8;
        color: #0f766e;
        font-weight: 700;
      }
      .grid {
        margin-top: 16px;
        display: grid;
        grid-template-columns: repeat(12, 1fr);
        gap: 12px;
      }
      .card {
        background: var(--panel);
        border: 1px solid var(--line);
        border-radius: 14px;
        padding: 14px;
        box-shadow: 0 8px 24px rgba(31, 24, 18, 0.06);
      }
      .kpi { grid-column: span 3; }
      .wide { grid-column: span 8; }
      .side { grid-column: span 4; }
      .full { grid-column: span 12; }
      .metric {
        font-size: clamp(1.35rem, 2.2vw, 2rem);
        font-weight: 750;
        margin: 6px 0 4px;
      }
      .delta {
        color: #0f766e;
        font-size: 0.85rem;
        font-weight: 650;
      }
      .dim {
        color: var(--muted);
        font-size: 0.86rem;
      }
      .card h2 {
        margin: 0 0 10px;
        font-size: 1rem;
      }
      .bars { display: grid; gap: 8px; }
      .bar {
        height: 14px;
        border-radius: 999px;
        background: linear-gradient(90deg, #14b8a6, #5eead4);
      }
      .bar.secondary { background: linear-gradient(90deg, #f59e0b, #fde68a); }
      .bar.tertiary { background: linear-gradient(90deg, #3b82f6, #93c5fd); }
      .table {
        width: 100%;
        border-collapse: collapse;
        font-size: 0.88rem;
      }
      .table th, .table td {
        border-bottom: 1px solid var(--line);
        text-align: left;
        padding: 8px 6px;
      }
      .table th { color: #675f54; font-weight: 650; }
      .badge {
        font-size: 0.75rem;
        padding: 3px 8px;
        border-radius: 999px;
        border: 1px solid #cde5e1;
        background: #eef8f6;
        color: #0f766e;
      }
      .footer {
        margin-top: 12px;
        color: #6a6258;
        font-size: 0.82rem;
      }
      @media (max-width: 960px) {
        .kpi { grid-column: span 6; }
        .wide, .side, .full { grid-column: span 12; }
      }
      @media (max-width: 600px) {
        .kpi { grid-column: span 12; }
      }
    </style>
  </head>
  <body>
    <div class="shell">
      <header class="topbar">
        <div class="title">
          <h1>Product 360 MBR Readout - July 2026</h1>
          <p>Preview dashboard shell - awaiting validated artifact package</p>
        </div>
        <div class="chips">
          <span class="chip">Audience: Leadership</span>
          <span class="chip">Cadence: Monthly</span>
          <span class="chip">Status: Preview</span>
        </div>
      </header>

      <nav class="tabs" aria-label="Report tabs">
        <span class="tab active">Executive Summary</span>
        <span class="tab">Revenue</span>
        <span class="tab">Engagement</span>
        <span class="tab">Retention</span>
        <span class="tab">Reliability</span>
        <span class="tab">Risks & Actions</span>
      </nav>

      <section class="grid" aria-label="Dashboard preview">
        <article class="card kpi">
          <div class="dim">MRR</div>
          <div class="metric">USD 4.86M</div>
          <div class="delta">+8.4% vs Jun</div>
        </article>
        <article class="card kpi">
          <div class="dim">Net Retention</div>
          <div class="metric">112%</div>
          <div class="delta">+3 pts QoQ</div>
        </article>
        <article class="card kpi">
          <div class="dim">Active Accounts</div>
          <div class="metric">1,284</div>
          <div class="delta">+71 net new</div>
        </article>
        <article class="card kpi">
          <div class="dim">Incidents (sev 1/2)</div>
          <div class="metric">3</div>
          <div class="delta">-2 vs prior month</div>
        </article>

        <article class="card wide">
          <h2>Performance trend (placeholder)</h2>
          <div class="bars">
            <div class="bar" style="width: 72%"></div>
            <div class="bar secondary" style="width: 58%"></div>
            <div class="bar tertiary" style="width: 81%"></div>
            <div class="bar" style="width: 76%"></div>
            <div class="bar secondary" style="width: 68%"></div>
          </div>
          <p class="dim">Final charts will come from the validated Data Analytics artifact.</p>
        </article>

        <article class="card side">
          <h2>Top insights</h2>
          <p class="dim">1. Expansion in enterprise cohort drove 41% of growth.</p>
          <p class="dim">2. Activation-to-value improved from 9.2d to 6.8d.</p>
          <p class="dim">3. API reliability gains reduced support tickets by 18%.</p>
        </article>

        <article class="card full">
          <h2>Initiatives and owners</h2>
          <table class="table" aria-label="Initiatives table">
            <thead>
              <tr>
                <th>Initiative</th>
                <th>Owner</th>
                <th>Status</th>
                <th>Target</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Pricing & packaging refresh</td>
                <td>Product Ops</td>
                <td><span class="badge">On Track</span></td>
                <td>2026-08-15</td>
              </tr>
              <tr>
                <td>Enterprise onboarding revamp</td>
                <td>Customer Success</td>
                <td><span class="badge">In Progress</span></td>
                <td>2026-08-31</td>
              </tr>
              <tr>
                <td>Data quality guardrails</td>
                <td>Data Platform</td>
                <td><span class="badge">At Risk</span></td>
                <td>2026-09-10</td>
              </tr>
            </tbody>
          </table>
          <p class="footer">Generated preview: $generated_at</p>
        </article>
      </section>
    </div>
  </body>
</html>
EOF
  echo "Published placeholder because report-package/ was not found."
fi

touch "$OUT_DIR/.nojekyll"
