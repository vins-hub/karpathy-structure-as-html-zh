[← 回 README](../README.md) · [← Ch 02](02-the-html-method.md)

# 第 03 章：七大應用場景

> **核心句**：HTML 輸出不是萬靈丹，但有 7 個場景受益遠遠超過平均——讀者要重複查、要結構化、要比較、要可分享。這 7 個場景應該變成你的「默認觸發條件」。

---

## 觸發判斷

什麼時候該 +HTML？兩個條件任一成立就值得：

1. **這個輸出我會看超過 1 次**（會回來查、會分享）
2. **這個輸出有結構**（多個 section、表格、比較、分階段）

如果是「問一個事實，看完就忘」（例如「Python 的 `enumerate` 怎麼用？」），純 markdown 就夠。

---

## 7 大高 ROI 場景

### 場景 1：**Plan / 規劃文件**

**為何適合 HTML**：plan 通常有層級結構（目標 → 階段 → 任務）、有時程、有 owner、有 dependency。HTML 的 nested details + sticky TOC + table 完美匹配。

**Prompt 範本**：

```
Generate a detailed implementation plan for: [你的目標]

Format as a complete HTML document with:
- Top: Goal + Success Criteria in a highlighted box
- "Phases" section with 3-5 phases, each in a <details> block (default open for Phase 1, collapsed others)
- Each phase contains: tasks table (Task / Owner / Estimate / Dependencies / Status)
- "Risks" section with risk table (Risk / Impact / Mitigation)
- "Timeline" as a visual ASCII Gantt or simple SVG
- Sticky TOC sidebar with current section highlight

Style: system fonts, max-width 1100px (wider for tables), dark mode support.
Output: complete HTML, no markdown wrapper.
```

**典型受益**：sprint plan、產品 spec、migration plan、deploy runbook。

---

### 場景 2：**Report / 分析報告**

**為何適合 HTML**：報告要有 executive summary + 詳細分析 + 數據表 + 結論。讀者通常**先看 summary，再選擇性深入**。`<details>` 就是為這個發明的。

**Prompt 範本**：

```
Analyze the following [數據 / 情況]: [paste data]

Produce a complete HTML report with:
1. Executive Summary at top (highlighted box, 3 sentences max)
2. Key Findings (bulleted, color-coded by severity)
3. Detailed Analysis (each finding in a <details> block)
4. Data Tables (with sortable columns via inline JS)
5. Recommendations (numbered, prioritized)
6. Appendix: methodology + assumptions (collapsed by default)

Style:
- Max-width 1024px
- Tables with sticky header, alternate row colors
- Use color coding: red for risks, green for positives, yellow for warnings
- Dark mode support

Output: complete HTML.
```

**典型受益**：incident report、financial analysis、competitor analysis、A/B test results。

---

### 場景 3：**Wiki / 知識整理**

**為何適合 HTML**：知識條目要**回來查**。HTML 可以加 search、sticky TOC、anchor links，讓單一文件就是 mini wiki。

**Prompt 範本**：

```
Create a comprehensive wiki entry on: [主題]

Format as a complete HTML document with:
- Title + 1-paragraph TL;DR at top
- Sticky left TOC with anchor links to each section
- Search input at top that filters sections (inline JS, simple text match)
- Main sections:
  * Definition / Overview
  * History / Context
  * Core Concepts (each in a <details>)
  * Common Patterns / Examples (code blocks)
  * Pitfalls / Anti-patterns
  * Related Topics (links to other wiki entries you'd recommend)
  * Further Reading (external links)
- Style: clean, Notion-like, dark mode

Output: complete HTML.
```

**典型受益**：技術概念深度整理、人物 / 公司研究、產品學習筆記、第二大腦條目。

---

### 場景 4：**Dashboard / 數據儀表板**

**為何適合 HTML**：dashboard 是 HTML 的原生形式。LLM 可以生成 SVG / Canvas / Chart.js 圖表，讓你拿到一個靜態但豐富的 dashboard。

**Prompt 範本**：

```
Create a dashboard for the following metrics: [paste metrics data]

Format as a complete HTML document:
- Top: 4-6 KPI cards in a grid (each: metric name / value / delta vs previous / sparkline SVG)
- Middle: 2-3 charts (bar / line / pie) using inline SVG or Chart.js via CDN
- Bottom: detailed data table with sortable columns
- Filter controls at top (date range, category)
- Dark mode by default

Use Chart.js via: <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

Output: complete HTML.
```

**典型受益**：個人指標追蹤、團隊 metric review、A/B test dashboard、實驗結果展示。

---

### 場景 5：**Tutorial / 教學文件**

**為何適合 HTML**：教學需要**分階段揭露**（step-by-step）+ **可選深度**（advanced 細節給願意看的人）+ **可實際嘗試**（code 可複製、可執行範例）。

**Prompt 範本**：

```
Create a hands-on tutorial for: [學習主題]

Format as a complete HTML document:
- Top: Prerequisites + What you'll learn (highlighted boxes)
- Progress indicator (e.g., "Step 3 of 8") at top
- Each step in its own section:
  * Step number + title
  * Explanation
  * Code block with "Copy" button (inline JS)
  * Expected output
  * <details> "Why this works" (deeper explanation, collapsed)
  * <details> "Common mistakes" (collapsed)
- Final section: "Next Steps" + "Further Reading"
- Style: friendly, lots of breathing room, dark mode

Output: complete HTML.
```

**典型受益**：上手某個 library、學一個 framework、入門概念解釋、新人 onboarding 文件。

---

### 場景 6：**Cheatsheet / 速查表**

**為何適合 HTML**：cheatsheet 要**密度高 + 可掃 + 可印**。HTML 的 grid layout + 配色 + 列印優化（@media print）剛好涵蓋。

**Prompt 範本**：

```
Create a one-page cheatsheet for: [工具 / 語言 / 主題]

Format as a complete HTML document optimized for both screen and print:
- Title at top
- 2-3 column grid layout (responsive: 1 column on mobile)
- Each section is a compact card with:
  * Section title
  * Code snippets (small font, dense)
  * Brief annotations
- Use color coding consistently (e.g., blue for syntax, green for examples, red for gotchas)
- @media print: A4 size, smaller fonts, no page breaks within cards
- Dark mode for screen, light mode forced for print

Output: complete HTML, optimized for density.
```

**典型受益**：常用指令速查（git / vim / docker / sql）、API reference、語法快速回顧。

---

### 場景 7：**Code Review / 技術評審**

**為何適合 HTML**：code review 要**比較 before/after** + **逐項評論** + **嚴重度分級**。HTML 的 split view + 顏色 + 摺疊剛好對應。

**Prompt 範本**：

```
Review the following code: [paste code or diff]

Format as a complete HTML document:
- Top: Overall verdict (Pass / Pass with revisions / Major issues) as a colored badge
- Summary section: top 3 issues, top 3 strengths
- Detailed comments:
  * Each issue as a card with:
    - Severity badge (Critical / High / Medium / Low / Nit)
    - Code snippet (the offending lines)
    - Why it's an issue
    - Suggested fix (code block)
    - <details> "Further context" (collapsed)
- Section: "Recommended next steps"
- Style: similar to GitHub PR review, but cleaner

Output: complete HTML.
```

**典型受益**：自我 code review、PR 撰寫前的 self-check、架構評審、安全審計。

---

## 對照表：場景 vs HTML 元素

| 場景 | 主要 HTML 元素 | 為何 |
|---|---|---|
| Plan | `<details>` + table + sticky TOC | 階段揭露 + 結構化 |
| Report | colored box + collapsible + tables | 先看摘要再深入 |
| Wiki | TOC + search input + anchor | 重複查 |
| Dashboard | grid + SVG / Chart.js | 數據密度 |
| Tutorial | numbered sections + code + 復製鈕 | 分步操作 |
| Cheatsheet | grid layout + 列印優化 | 密度 + 可印 |
| Code Review | severity badge + split view | 比較 + 分級 |

---

## 反例：不適合 HTML 的場景

| 場景 | 為何不適合 |
|---|---|
| 「Python 的 `lambda` 是什麼？」 | 一句話回答，HTML 是 overkill |
| 「翻譯這段成英文」 | 純文字 input/output，HTML 沒加值 |
| 「Brainstorm 10 個產品名」 | 列表 markdown 就夠 |
| 即時對話 | 互動延遲太長，影響 flow |
| 短回覆 / 確認類 | HTML 樣板的「自重」大於內容 |

**判準**：如果輸出 < 200 字，純 markdown / 純文字就好。

---

## 觸發 HTML 的個人 SOP

**建議**：在你的 prompt snippet 工具（Raycast / Alfred / Espanso）設兩個快捷鍵：

| 快捷鍵 | 動作 |
|---|---|
| `;html` | append Level 2 (基礎) HTML 指令 |
| `;htmlpro` | append Level 4 (專業) HTML 指令 |

問問題前先評估：「**這個輸出我會看超過 1 次嗎？**」如果會，**先按 `;htmlpro`**，再 enter。

---

## 本章小結

| 場景 | 啟動條件 | 受益最大 |
|---|---|---|
| Plan | 多階段 + 多任務 | sprint plan、deploy runbook |
| Report | 數據 + 結論 + 細節 | incident report、財報分析 |
| Wiki | 會回來查 | 技術概念、人物研究 |
| Dashboard | 多指標 + 圖表 | 個人 / 團隊追蹤 |
| Tutorial | 階段教學 | 上手 framework、onboarding |
| Cheatsheet | 速查 + 列印 | 常用指令、API ref |
| Code Review | 比較 + 分級 | PR、架構評審 |

---

## 接下來

➡️ [Chapter 04: Prompt 模板庫](04-template-library.md)

把 7 個場景的 prompt 集中成可複製貼上的庫。
