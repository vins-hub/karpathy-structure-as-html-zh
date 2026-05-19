[← 回 README](../README.md) · [← Ch 07](07-relation-to-12-factor.md)

# Appendix：HTML / CSS 速查（給 +HTML 工作流用）

> 用途：當你想精細控制 LLM 生成的 HTML 樣式時，這份是即查即用的 pattern 庫。**不教你 HTML/CSS 基礎**，假設你已會基本語法。

---

## 1. HTML5 boilerplate（最小可用）

```html
<!doctype html>
<html lang="zh-Hant">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>標題</title>
  <style>
    /* CSS 在這裡 */
  </style>
</head>
<body>
  <!-- 內容 -->
  <script>
    // JS 在這裡（如有）
  </script>
</body>
</html>
```

---

## 2. 系統字型棧（跨平台一致）

```css
font-family: 
  -apple-system, BlinkMacSystemFont,    /* macOS / iOS */
  "Segoe UI",                            /* Windows */
  Roboto,                                /* Android */
  "PingFang TC", "PingFang SC",          /* macOS 中文 */
  "Microsoft JhengHei", "Microsoft YaHei", /* Windows 中文 */
  "Helvetica Neue", Arial,
  sans-serif;
```

Monospace（程式碼用）：

```css
font-family: 
  ui-monospace,
  Menlo, Monaco,
  "Cascadia Mono",
  "Roboto Mono",
  monospace;
```

---

## 3. 暗色模式（auto 切換）

```css
:root {
  --bg: #fff;
  --fg: #222;
  --muted: #666;
  --code-bg: #f5f5f5;
  --border: #ddd;
  --accent: #0366d6;
}

@media (prefers-color-scheme: dark) {
  :root {
    --bg: #1a1a1a;
    --fg: #ddd;
    --muted: #999;
    --code-bg: #2a2a2a;
    --border: #444;
    --accent: #58a6ff;
  }
}

body {
  background: var(--bg);
  color: var(--fg);
}
```

---

## 4. 文件最佳閱讀樣式

```css
body {
  max-width: 820px;
  margin: 2rem auto;
  padding: 0 1.5rem;
  line-height: 1.65;
}

h1, h2, h3, h4 {
  border-bottom: 1px solid var(--border);
  padding-bottom: 0.3em;
  margin-top: 1.8em;
}

h1 { font-size: 1.9em; }
h2 { font-size: 1.5em; }
h3 { font-size: 1.2em; }

p { margin: 1em 0; }
```

---

## 5. 強調 box 樣式（結論 / 警告 / 提示）

```css
.callout {
  border-left: 4px solid;
  padding: 1em 1.5em;
  margin: 1em 0;
  border-radius: 0 4px 4px 0;
}

.callout.info    { border-color: #0366d6; background: #f1f8ff; }
.callout.success { border-color: #28a745; background: #f0fff4; }
.callout.warning { border-color: #ffd33d; background: #fffbdd; }
.callout.danger  { border-color: #d73a49; background: #ffeef0; }

@media (prefers-color-scheme: dark) {
  .callout.info    { background: #0a2540; }
  .callout.success { background: #0a3320; }
  .callout.warning { background: #332b00; }
  .callout.danger  { background: #3a0f14; }
}
```

用法：
```html
<div class="callout info">
  <strong>提示：</strong>...
</div>
```

---

## 6. 表格樣式

```css
table {
  border-collapse: collapse;
  width: 100%;
  margin: 1em 0;
  font-size: 0.95em;
}

th, td {
  border: 1px solid var(--border);
  padding: 0.5em 0.8em;
  text-align: left;
  vertical-align: top;
}

thead {
  background: var(--code-bg);
  position: sticky;
  top: 0;
}

tbody tr:nth-child(even) {
  background: rgba(0, 0, 0, 0.02);
}

@media (prefers-color-scheme: dark) {
  tbody tr:nth-child(even) {
    background: rgba(255, 255, 255, 0.03);
  }
}
```

---

## 7. Code 與 Pre 樣式

```css
code {
  font-family: ui-monospace, Menlo, monospace;
  background: var(--code-bg);
  padding: 0.1em 0.4em;
  border-radius: 3px;
  font-size: 0.92em;
}

pre {
  background: var(--code-bg);
  padding: 1em;
  border-radius: 6px;
  overflow-x: auto;
  font-size: 0.88em;
  line-height: 1.5;
  border: 1px solid var(--border);
}

pre code {
  background: transparent;
  padding: 0;
  font-size: inherit;
}
```

---

## 8. Details / Summary 樣式

```css
details {
  border: 1px solid var(--border);
  border-radius: 4px;
  padding: 0.5em 1em;
  margin: 0.7em 0;
}

summary {
  cursor: pointer;
  font-weight: 600;
  padding: 0.3em 0;
  list-style: none;
}

summary::before {
  content: '▶';
  display: inline-block;
  margin-right: 0.5em;
  transition: transform 0.2s;
  font-size: 0.8em;
}

details[open] summary::before {
  transform: rotate(90deg);
}

details[open] summary {
  border-bottom: 1px solid var(--border);
  margin-bottom: 0.5em;
}
```

---

## 9. KPI Card grid

```css
.kpi-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  gap: 1rem;
  margin: 1.5rem 0;
}

.kpi {
  border: 1px solid var(--border);
  border-radius: 6px;
  padding: 1rem 1.25rem;
  background: var(--bg);
}

.kpi-label {
  font-size: 0.85em;
  color: var(--muted);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.kpi-value {
  font-size: 2em;
  font-weight: 700;
  margin: 0.3em 0;
}

.kpi-delta {
  font-size: 0.9em;
  font-weight: 600;
}

.kpi-delta.up { color: #28a745; }
.kpi-delta.down { color: #d73a49; }
```

---

## 10. Sticky TOC sidebar

```css
.layout {
  display: grid;
  grid-template-columns: 220px 1fr;
  gap: 2rem;
  max-width: 1100px;
  margin: 2rem auto;
}

.toc {
  position: sticky;
  top: 1rem;
  align-self: start;
  max-height: calc(100vh - 2rem);
  overflow-y: auto;
  font-size: 0.9em;
}

.toc a {
  display: block;
  padding: 0.3em 0;
  color: var(--fg);
  text-decoration: none;
  border-left: 2px solid transparent;
  padding-left: 0.8em;
}

.toc a.active {
  border-left-color: var(--accent);
  font-weight: 600;
}

@media (max-width: 768px) {
  .layout { grid-template-columns: 1fr; }
  .toc { position: static; max-height: none; }
}
```

---

## 11. 列印優化（@media print）

```css
@media print {
  body {
    max-width: none;
    margin: 0;
    background: white !important;
    color: black !important;
  }
  
  .toc, .copy-btn, .search, nav.tabs {
    display: none !important;
  }
  
  details {
    break-inside: avoid;
  }
  
  details summary {
    display: none;
  }
  
  details > *:not(summary) {
    display: block !important;
  }
  
  table, pre, .kpi {
    break-inside: avoid;
  }
  
  a[href]::after {
    content: " (" attr(href) ")";
    font-size: 0.85em;
    color: #666;
  }
  
  @page {
    size: A4;
    margin: 1.5cm;
  }
}
```

---

## 12. 響應式佈局

```css
/* mobile-first */
.layout {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1rem;
}

/* tablet */
@media (min-width: 768px) {
  .layout {
    grid-template-columns: 200px 1fr;
  }
}

/* desktop */
@media (min-width: 1200px) {
  .layout {
    grid-template-columns: 220px 1fr 200px;
  }
}
```

---

## 13. Inline SVG charts

簡單 bar chart：

```html
<svg viewBox="0 0 300 150" width="100%" height="150">
  <rect x="20" y="80" width="40" height="60" fill="#0366d6" />
  <rect x="80" y="50" width="40" height="90" fill="#0366d6" />
  <rect x="140" y="30" width="40" height="110" fill="#0366d6" />
  <rect x="200" y="60" width="40" height="80" fill="#0366d6" />
  <text x="40" y="148" text-anchor="middle" font-size="10">Jan</text>
  <text x="100" y="148" text-anchor="middle" font-size="10">Feb</text>
  <text x="160" y="148" text-anchor="middle" font-size="10">Mar</text>
  <text x="220" y="148" text-anchor="middle" font-size="10">Apr</text>
</svg>
```

簡單 sparkline：

```html
<svg viewBox="0 0 100 30" width="100" height="30">
  <polyline points="0,20 20,10 40,15 60,5 80,8 100,3"
            fill="none" stroke="#0366d6" stroke-width="2" />
</svg>
```

---

## 14. 全套 STYLE BLOCK（複製貼上即可用）

```html
<style>
:root {
  --bg: #fff; --fg: #222; --muted: #666;
  --code-bg: #f5f5f5; --border: #ddd; --accent: #0366d6;
}
@media (prefers-color-scheme: dark) {
  :root { --bg: #1a1a1a; --fg: #ddd; --muted: #999; --code-bg: #2a2a2a; --border: #444; --accent: #58a6ff; }
}
body {
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "PingFang TC", "PingFang SC", "Microsoft JhengHei", sans-serif;
  background: var(--bg); color: var(--fg);
  max-width: 820px; margin: 2rem auto; padding: 0 1.5rem;
  line-height: 1.65;
}
h1, h2, h3, h4 { border-bottom: 1px solid var(--border); padding-bottom: 0.3em; margin-top: 1.8em; }
h1 { font-size: 1.9em; } h2 { font-size: 1.5em; } h3 { font-size: 1.2em; }
code { font-family: ui-monospace, Menlo, monospace; background: var(--code-bg); padding: 0.1em 0.4em; border-radius: 3px; font-size: 0.92em; }
pre { background: var(--code-bg); padding: 1em; border-radius: 6px; overflow-x: auto; font-size: 0.88em; line-height: 1.5; border: 1px solid var(--border); }
pre code { background: transparent; padding: 0; }
table { border-collapse: collapse; width: 100%; margin: 1em 0; }
th, td { border: 1px solid var(--border); padding: 0.5em 0.8em; text-align: left; vertical-align: top; }
th { background: var(--code-bg); }
tbody tr:nth-child(even) { background: rgba(0, 0, 0, 0.02); }
@media (prefers-color-scheme: dark) { tbody tr:nth-child(even) { background: rgba(255, 255, 255, 0.03); } }
details { border: 1px solid var(--border); border-radius: 4px; padding: 0.5em 1em; margin: 0.7em 0; }
summary { cursor: pointer; font-weight: 600; }
blockquote { border-left: 4px solid var(--muted); padding-left: 1em; color: var(--muted); margin: 1em 0; }
a { color: var(--accent); text-decoration: none; }
a:hover { text-decoration: underline; }
.callout { border-left: 4px solid; padding: 1em 1.5em; margin: 1em 0; border-radius: 0 4px 4px 0; }
.callout.info { border-color: #0366d6; background: rgba(3, 102, 214, 0.08); }
.callout.success { border-color: #28a745; background: rgba(40, 167, 69, 0.08); }
.callout.warning { border-color: #ffd33d; background: rgba(255, 211, 61, 0.12); }
.callout.danger { border-color: #d73a49; background: rgba(215, 58, 73, 0.08); }
@media print {
  body { max-width: none; margin: 0; background: white !important; color: black !important; }
  details summary { display: none; } details > *:not(summary) { display: block !important; }
  @page { size: A4; margin: 1.5cm; }
}
</style>
```

**這份 STYLE BLOCK 可以直接貼到所有 [Ch 04 模板](04-template-library.md) 的 STYLE 區域**，立即得到 production-grade 樣式。

---

## 結尾

恭喜你讀完整份 Karpathy +HTML 精解。

### 一句話帶走

> **任何 LLM prompt 結尾，加一句「Format your entire response as a complete HTML document」。**

剩下的細節（樣式 / 模板 / 互動 / 反模式）都是優化。**先做這一件事，就贏了 90% 沒做的人**。

---

[← 回 README](../README.md)
