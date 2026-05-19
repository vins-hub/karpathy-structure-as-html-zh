[← 回 README](../README.md) · [← Ch 03](03-use-cases.md)

# 第 04 章：Prompt 模板庫

> **使用方式**：直接複製對應模板，把 `[...]` 內容替換成你的具體輸入。9 個模板分 3 級：基礎（Level 1-2）、實戰（Level 3）、進階（Level 4 含互動）。

---

## 共用 STYLE BLOCK（基礎樣式，可重複使用）

```
STYLE REQUIREMENTS:
- Font family: -apple-system, BlinkMacSystemFont, "Segoe UI", "PingFang TC", sans-serif
- Max-width: 820px (or wider for tables: 1100px)
- Margin: 2rem auto, padding: 0 1.5rem
- Line-height: 1.65
- Light mode: background #fff, color #222
- Dark mode (prefers-color-scheme): background #1a1a1a, color #ddd
- Headings: border-bottom 1px solid, padding-bottom 0.3em, margin-top 1.8em
- Code: font-family Menlo/Consolas/monospace, background #f5f5f5 (dark: #2a2a2a), border-radius 4px, padding 0.1em 0.35em
- Pre: background #f5f5f5 (dark: #2a2a2a), padding 0.9em, border-radius 5px, overflow-x auto
- Tables: full width, border-collapse collapse, alternate row backgrounds
- Blockquote: border-left 4px solid #888, padding-left 1em, color #555 (dark: #aaa)
- Links: color #0366d6, no underline
```

---

## Level 1-2：基礎模板

### 模板 #1：通用「+HTML」

最短、最通用，無腦 append 在任何 prompt 後面。

```
---

Format your entire response as a complete HTML document with:
- Clean modern typography using system fonts
- Max-width 820px, centered
- Dark/light mode via prefers-color-scheme
- Headings with subtle border-bottom
- Code blocks with monospace font and gray background

Output only the HTML, no markdown wrapper, no explanation before/after.
```

---

### 模板 #2：「給我一份精美回答」

當你想要視覺驚艷時用。

```
---

Format your response as a beautifully designed HTML document.
Treat it like crafting a polished blog post or design portfolio piece:
- Generous whitespace
- Carefully chosen colors with good contrast
- Considered typography hierarchy
- Pull quotes for key insights (large italic, indented)
- Subtle animations on hover (CSS transitions)
- Dark mode that looks intentional, not just inverted

Take pride in the visual craft. Output only the HTML.
```

---

## Level 3：實戰模板（7 大場景對應）

### 模板 #3：Plan 規劃文件

```
[你的目標 / 要規劃的事情]

---

Generate a detailed implementation plan, formatted as a complete HTML document.

STRUCTURE:
1. Top: Goal + Success Criteria in a highlighted box
2. Executive Summary (3 sentences)
3. "Phases" section with 3-5 phases:
   - Phase 1 in <details> open by default
   - Other phases in <details> collapsed
   - Each phase contains: task table (Task / Owner / Estimate / Dependencies / Status)
4. "Risks & Mitigations" table
5. "Timeline" as ASCII Gantt or simple inline SVG
6. "Definition of Done" checklist

[paste STYLE BLOCK here]

Output: complete HTML, max-width 1100px (wider for tables).
```

---

### 模板 #4：Report 分析報告

```
Analyze this [情境 / 數據]: [paste data or context]

---

Produce a comprehensive HTML report.

STRUCTURE:
1. Executive Summary box at top (3 sentences max, colored background)
2. Key Findings (3-5 bullets, color-coded: red=risk, green=positive, yellow=warning)
3. Detailed Analysis section, each finding in a <details> block:
   - The finding
   - Supporting data
   - Implications
4. Data tables with sticky headers
5. Recommendations (numbered, prioritized 1=highest)
6. Appendix in <details>: methodology, assumptions, raw data

[paste STYLE BLOCK]

Output: complete HTML, max-width 1024px.
```

---

### 模板 #5：Wiki 知識整理

```
Create a comprehensive wiki entry on: [主題]

---

Format as a complete HTML document.

STRUCTURE:
- Title + 1-paragraph TL;DR
- Sticky left sidebar with TOC (anchor links to sections)
- Top: search input that filters sections by text (inline JS)
- Main sections:
  * Definition / Overview
  * History / Context (<details> collapsed)
  * Core Concepts (each subconcept in <details>)
  * Common Patterns + Code Examples
  * Pitfalls / Anti-patterns
  * Related Topics (cross-link suggestions)
  * Further Reading
- Each section has anchor id matching TOC

[paste STYLE BLOCK]

Output: complete HTML.
```

---

### 模板 #6：Dashboard

```
Create a dashboard for: [metrics description or data paste]

---

Format as a complete HTML document.

STRUCTURE:
- Top: 4-6 KPI cards in CSS grid (each: metric name / large value / delta vs previous / inline SVG sparkline)
- Middle: 2-3 charts using inline SVG (bar chart, line chart, pie chart)
- Optional: include Chart.js via <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> for complex charts
- Bottom: data table with sortable columns (inline JS)
- Filter controls at top (date range selector, category dropdown)

[paste STYLE BLOCK]

STYLE override:
- Dark mode by default (dashboards look better dark)
- KPI cards with subtle border, padding 1.5rem
- Charts max-height 300px

Output: complete HTML.
```

---

### 模板 #7：Tutorial 教學

```
Create a hands-on tutorial for: [學習主題]

---

Format as a complete HTML document.

STRUCTURE:
- Top: "Prerequisites" + "What you'll learn" in side-by-side boxes
- Progress bar at top showing "Step N of M"
- Each step in its own <section>:
  * Step number badge + title
  * Explanation
  * Code block with "Copy" button (inline JS)
  * "Expected output" preview
  * <details> "Why this works" (deeper explanation)
  * <details> "Common mistakes"
- Final "Next Steps" + "Further Reading"

[paste STYLE BLOCK]

STYLE override:
- Friendly, lots of whitespace
- Step number badges: circle, colored
- Code blocks: monospace, syntax-aware via class (no actual highlighting unless you can do it inline)

Output: complete HTML.
```

---

### 模板 #8：Cheatsheet 速查表

```
Create a one-page cheatsheet for: [工具 / 語言 / 框架]

---

Format as a complete HTML document optimized for both screen and print.

STRUCTURE:
- Title at top
- 3-column CSS grid (1 column on mobile via @media)
- Each section a compact card:
  * Section title (small, all caps)
  * Code snippets (dense, small font)
  * Brief annotations
- Color coding: blue=syntax/keyword, green=examples, red=gotchas/warnings
- Dense layout, minimal whitespace

@media print:
- A4 size, no page breaks within cards
- Light mode forced
- Smaller font sizes

[paste STYLE BLOCK]

Output: complete HTML.
```

---

### 模板 #9：Code Review

```
Review this code:

```
[paste code or diff]
```

---

Format your review as a complete HTML document.

STRUCTURE:
- Top: Overall verdict badge (Pass ✅ / Pass with revisions ⚠️ / Major issues ❌)
- Summary: top 3 issues + top 3 strengths
- Detailed comments — each issue is a card containing:
  * Severity badge (Critical=red / High=orange / Medium=yellow / Low=blue / Nit=gray)
  * File:line reference
  * Code snippet (the offending lines, with line numbers)
  * "Why this is an issue" explanation
  * "Suggested fix" with code block
  * <details> "Further context"
- "Recommended next steps" section

[paste STYLE BLOCK]

STYLE override:
- Reuse GitHub PR-review aesthetic but cleaner
- Severity badges with appropriate colors
- Code diffs: red background for - lines, green for + lines

Output: complete HTML.
```

---

## Level 4：進階模板（含互動）

### 模板 #10：互動式分析儀表板（terminal velocity 版）

```
Analyze the following [數據 / 主題]: [paste]

---

Create a self-contained interactive HTML dashboard for this analysis.

STRUCTURE:
- Hero section at top: title + 1-line TL;DR + 3 high-level KPIs
- Tabbed interface (vanilla JS tab switching) with sections:
  Tab 1: Overview
  Tab 2: Deep Dive
  Tab 3: Data
  Tab 4: Methodology
- Each tab content area has its own sub-structure
- Filters at top affect all tabs simultaneously
- Inline charts using Chart.js via CDN
- Data table on "Data" tab: sortable, searchable, exportable to CSV (inline JS)

INTERACTIVITY:
- Tab switching: click to switch, keyboard arrows to navigate
- Filters: dropdowns + date range; updating filter re-renders charts
- Table: click column header to sort, type in search box to filter
- "Copy" buttons on all code blocks
- "Export" buttons that generate CSV via Blob + download link

ACCESSIBILITY:
- Semantic <article>, <nav>, <section>
- ARIA labels
- Keyboard-navigable (Tab to focus, Enter/Space to activate)

[paste STYLE BLOCK]

Output: complete self-contained HTML (Chart.js via CDN is OK).
```

---

### 模板 #11：學習路徑生成器（Spaced Repetition Mode）

```
Generate a complete learning path for: [主題]

---

Create an interactive HTML learning roadmap.

STRUCTURE:
- Top: Goal statement + estimated total time
- Phases as horizontal timeline (CSS flex)
- Each phase contains:
  * Resources list (links with type badges: video / article / book / exercise)
  * Practice questions (collapsible <details> with answer reveal)
  * Self-check checklist (with checkboxes — clicking persists state in localStorage)
- Bottom: "Show progress" button that highlights which checkboxes are done

INTERACTIVITY:
- Checkbox state persists in localStorage
- "Reset progress" button
- Each checkbox marked "complete" reduces phase opacity slightly (visual progress)
- Random "Quiz me" button that picks a random question

[paste STYLE BLOCK]

Output: complete self-contained HTML.
```

---

## 進階組合：把模板組裝成 LLM 工作站

把這些模板集中在一個檔案 `~/.prompts/html-templates.md`，並用 Raycast / Alfred 的 snippet 功能設快捷鍵：

| 快捷鍵 | 觸發模板 |
|---|---|
| `;html` | #1 通用 |
| `;htmlbeauty` | #2 精美 |
| `;htmlplan` | #3 Plan |
| `;htmlreport` | #4 Report |
| `;htmlwiki` | #5 Wiki |
| `;htmldash` | #6 Dashboard |
| `;htmltutorial` | #7 Tutorial |
| `;htmlcheat` | #8 Cheatsheet |
| `;htmlreview` | #9 Code Review |
| `;htmlinteractive` | #10 互動儀表板 |

問完問題後按一下快捷鍵 → send。**5 秒成本，產出價值差 10 倍**。

---

## 模板使用心法

### 心法 1：先用最小模板，再追加細節

不要一開始就用 Level 4。先用 #1 看 LLM 給什麼，再根據結果**手動 prompt 補強**：「加上 X」、「把 Y 改成 dark mode」。

### 心法 2：保留結果，用迭代而非從頭

LLM 第一次給的 HTML 可能 70% 達標。**不要重 prompt**，而是貼回去說：「保留所有 style 不動，但把 Section 3 改成 ...」。比較省 token，結果更穩定。

### 心法 3：把好的輸出存為自己的模板

LLM 給你一個你很滿意的 HTML？**把它的 `<style>` 區塊抽出來**存成你自己的 STYLE BLOCK。下次 prompt 直接貼這個 style → LLM 會保持風格一致。

### 心法 4：跨 LLM 一致性靠 STYLE BLOCK

換 LLM provider（Claude → GPT → Gemini）會有風格漂移。把 STYLE BLOCK 越寫越具體（顏色 hex 都明確），漂移會縮小到可接受範圍。

---

## 接下來

➡️ [Chapter 05: 反模式 — 別這樣用](05-anti-patterns.md)
