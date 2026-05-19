[← 回 README](../README.md) · [← Ch 01](01-the-output-bottleneck.md)

# 第 02 章：HTML 方法論 — 完整 Prompt 範本 + 工作流 SOP

> **核心句**：把 LLM 從「chat 助手」切換成「HTML 文件產生器」，只需要一個 prompt 結尾的指令。但要穩定拿到**高品質**結果，需要 4 個層次的精細化：基礎指令 → 樣式約束 → 結構提示 → 互動元素。

---

## 4 層 Prompt 精細化階梯

### Level 1：最基礎（一行版）

```
Format your entire response as a complete HTML document.
```

**結果**：能跑、但樣式 LLM 自由發揮，品質浮動。

---

### Level 2：基礎 + 樣式約束（推薦起點）

```
Format your entire response as a complete HTML document with:
- Clean modern typography using system fonts
- Max-width 820px, centered
- Line-height 1.65, comfortable reading
- Dark/light mode support via prefers-color-scheme
- Headings with subtle border-bottom
- Code blocks with monospace font and gray background

Output only the HTML, no markdown wrapper, no explanation.
```

**結果**：穩定的中高品質輸出，可以開始當文件用。

---

### Level 3：基礎 + 樣式 + 結構提示

```
Format your entire response as a complete HTML document.

STYLE REQUIREMENTS:
- System fonts: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif
- Max-width: 820px, margin: 2rem auto, padding: 0 1.5rem
- Line-height: 1.65, color: #222 (light) / #ddd (dark)
- Headings: border-bottom 1px solid, padding-bottom 0.3em
- Code: Menlo/Consolas/monospace, background #f5f5f5, border-radius 4px
- Tables: full width, alternate row backgrounds
- Dark mode via @media (prefers-color-scheme: dark)

STRUCTURE REQUIREMENTS:
- Start with a "Conclusion" box (colored background, prominent)
- Then "Key Points" as a list with emoji or icons
- Then a comparison table if comparing things
- Then detailed sections, each in a <details> block
- End with "Next Steps" or "Action Items"

OUTPUT:
- Only the complete HTML (with <!doctype html>)
- No markdown code fences around the HTML
- No explanation before or after
```

**結果**：可以當交付品用，達到 production-grade 文件質量。

---

### Level 4：完整版 + 互動元素

```
Format your entire response as a complete, self-contained HTML document.

STYLE: [same as Level 3]

STRUCTURE: [same as Level 3]

INTERACTIVITY:
- Use <details>/<summary> for collapsible sections
- Add a sticky top navigation with anchor links to each section
- For tables with > 5 rows, add a search input that filters rows via inline JS
- For code blocks, add a "Copy" button via inline JS
- Add a table of contents that highlights current section on scroll (intersection observer)
- Make all links open in new tab (target="_blank")

ACCESSIBILITY:
- Semantic HTML (<article>, <section>, <nav>)
- ARIA labels on interactive elements
- Keyboard-navigable (tabindex)
- Min font size 16px

OUTPUT:
- Only the complete HTML, no markdown wrapper
- All CSS inline in <style>
- All JS inline in <script>
- Self-contained: no external dependencies
```

**結果**：mini single-page app，可以直接 deploy / 分享。

---

## 工作流 SOP

### 簡單一次性查詢

```
1. 想問題（無論是什麼問題）
2. 在 prompt 結尾貼上 Level 2 模板
3. 把 LLM 輸出複製到 response.html
4. 瀏覽器打開
```

時間成本：**+5 秒**。閱讀體驗：**+200%**。

### 重複型 / 重要文件

```
1. 把你的 Level 3 / Level 4 模板存成 snippet（macOS 用 Raycast / Alfred）
2. 想生成什麼文件，先寫具體問題
3. 觸發 snippet 自動 append 模板
4. 送 LLM
5. 用 Chrome DevTools 微調 → 把改動丟回 LLM 說「保留這些 style，重新生成內容」
6. 反覆迭代
```

### Pipeline 化（自動化生成報告）

```python
# 自動化範例 (Python + Anthropic SDK)
import anthropic

HTML_TEMPLATE_INSTRUCTION = """
Format your entire response as a complete HTML document with...
(your Level 3 / Level 4 spec here)
"""

def llm_to_html(user_prompt: str, output_path: str) -> None:
    client = anthropic.Anthropic()
    msg = client.messages.create(
        model="claude-opus-4-7",
        max_tokens=8000,
        messages=[{
            "role": "user",
            "content": f"{user_prompt}\n\n---\n\n{HTML_TEMPLATE_INSTRUCTION}"
        }]
    )
    html = msg.content[0].text
    # LLM 可能還是會包 ```html ... ``` 把它剝掉
    html = html.strip().removeprefix("```html").removesuffix("```").strip()
    with open(output_path, "w") as f:
        f.write(html)
    print(f"✓ Saved to {output_path}")
```

呼叫：

```python
llm_to_html(
    "Analyze my Q1 sales data: ... [paste data]",
    "/tmp/q1-analysis.html"
)
import webbrowser; webbrowser.open("/tmp/q1-analysis.html")
```

**5 行程式碼，把 LLM 變成你自己的文件產生器**。

---

## 5 個常見問題

### Q1：LLM 還是會包 ```html``` markdown 怎麼辦？

A：在 prompt 加：
```
IMPORTANT: Do NOT wrap the HTML in markdown code fences. 
Start your response with <!doctype html> directly.
```

或者程式碼裡用 `strip().removeprefix("```html").removesuffix("```")` 處理。

### Q2：輸出截斷了怎麼辦？

A：兩個解法：

1. **提高 `max_tokens`**（很多人忘記設這個，預設可能只 1024）
2. **分段生成**：先讓 LLM 生成 outline，再分章節各別生成 HTML 片段，最後手動合併

### Q3：圖表怎麼辦？

A：兩個方案：

1. **SVG inline**：LLM 直接生成 `<svg>...</svg>`，簡單的 bar / line chart 都可以
2. **Chart.js / D3 via CDN**：把 CDN URL 加到 head，LLM 生成 `<canvas>` + 初始化 JS

範例 prompt 加：
```
For data visualization, use inline <svg> for simple charts (bar, line, pie).
For complex charts, use Chart.js via CDN: 
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
```

### Q4：要不要加 Tailwind？

A：**通常不用**。Tailwind 沒在 LLM 訓練資料裡 first-class，且需要 build step / CDN bundle。**直接寫 inline CSS 反而更穩**——LLM 對 raw CSS 駕輕就熟。

### Q5：怎麼確保跨 LLM provider 結果一致？

A：**不能完全一致**。但 Level 3 / Level 4 的具體約束已經把 80% 的變動鎖住。剩下 20% 是各家 LLM 風格差異（Claude 偏 minimal，GPT-4 偏 colorful，Gemini 偏 structured）。挑一家當主力，把模板針對它調 fine-tune。

---

## 進階技巧：把 HTML 當成「LLM ↔ 人類」契約

當 LLM 為你輸出 HTML，這個 HTML 不只是「給人讀」，**它還是 LLM 自我表達的高保真載體**。具體表現：

| 表現 | 含意 |
|---|---|
| LLM 把某段放進「結論」box | 它認為這段最重要 |
| LLM 把某段放進 `<details>` | 它認為這段是次要細節 |
| LLM 用紅色 background 標記某段 | 它認為這段是警告 / 風險 |
| LLM 把某些項目做成 sticky | 它認為這些是需要持續參考的 |

**讀 LLM 寫的 HTML，等於讀 LLM 對「資訊優先級」的判斷**。比讀 markdown 更有資訊量。

---

## 範本：你可以立刻用的 5 個模板

我們會在 [第 04 章](04-template-library.md) 給 9 個完整模板。先給你 1 個搶先用：

### 「**任何技術問題分析**」模板

```
[你的技術問題]

---

Format your entire response as a complete HTML document analyzing this problem.

STRUCTURE:
1. Top: Executive Summary in a colored box (TL;DR in 3 sentences)
2. "Problem Statement" section
3. "Root Cause Analysis" with collapsible details for each possible cause
4. "Recommended Solution" with step-by-step plan
5. "Trade-offs" as a comparison table
6. "Implementation Checklist" as a checklist
7. "Risks & Mitigations" 

STYLE:
- System fonts, max-width 820px, centered
- Dark mode via prefers-color-scheme
- Code blocks with syntax highlighting class names
- Tables with subtle borders, alternate row colors

OUTPUT: Complete self-contained HTML, no markdown wrapper.
```

**試一次**：拿一個你最近在思考的技術決策，貼進去，看結果。

---

## 本章小結

| 觀念 | 用途 |
|---|---|
| 4 層精細化階梯 | 從入門到 production-grade |
| Snippet 化模板 | 5 秒重複觸發 |
| Pipeline 自動化 | 把 LLM 變成文件 generator |
| 處理截斷 / 圖表 / Tailwind 等實務問題 | 邊角案例不卡住 |
| HTML 是 LLM 表達優先級的高保真載體 | 讀 HTML 比讀 markdown 更有資訊 |

---

## 接下來

➡️ [Chapter 03: 七大應用場景](03-use-cases.md)

知道怎麼寫 prompt 後，下一步是知道**什麼情境最值得用**這個方法。
