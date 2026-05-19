[← 回 README](../README.md) · [← Ch 06](06-advanced-interactivity.md)

# 第 07 章：跟 12-Factor Agents 的關聯

> **核心句**：Karpathy 的「+HTML」跟 Dex Horthy 的「12-factor agents」乍看是兩個獨立社群提的不同方法。實際上它們**同源**——都在解決「**LLM 內部能力遠超 chat UI 表達**」的不對稱問題。把這兩個觀念放在一起，會理解整套 LLM-as-software 的設計哲學。

---

## 兩條觀念的根

| 觀念 | 提出者 | 核心句 | 解決什麼 |
|---|---|---|---|
| Structure as HTML | Karpathy | 「Output is still stuck in the Stone Age」 | LLM **輸出層**還停在純文字 |
| 12-Factor Agents | Dex Horthy | 「Agent 本質上是穿插 LLM 步驟的 deterministic 軟體」 | LLM **工程化**還停在「丟 prompt loop until done」 |

不同層，但同源——**LLM 的潛能被「過度簡化的使用模式」鎖住了**。

---

## 對應關係

### Karpathy +HTML ↔ Factor 3（Context Engineering）

> Factor 3：**You don't necessarily need to use standard message-based formats for conveying context to an LLM.**

把這句反過來：**你也不必用標準 message format 接收 LLM 輸出**。

| 維度 | Factor 3 (input side) | Karpathy +HTML (output side) |
|---|---|---|
| 拒絕的預設 | "Standard ChatML messages" | "Plain text / markdown response" |
| 推薦做法 | 自製 XML-like context format | 自製 HTML 輸出格式 |
| 為什麼 | Token efficiency + attention | Reading efficiency + reuse |

**兩條原則的精神完全一致**：**Take ownership of the format**——不要被 chat UI / framework 默認鎖死。

---

### Karpathy +HTML ↔ Factor 4（Tools are Structured Outputs）

> Factor 4：**Tools don't need to be complex. At their core, they're just structured output from your LLM.**

**HTML 是 structured output 的另一種形式**——它不是給程式 parse 的，是給瀏覽器 render 的，但本質都是「LLM 輸出結構化資料」。

| 形式 | 給誰看 | 解析方式 |
|---|---|---|
| JSON tool call | 程式碼 | `JSON.parse` |
| HTML document | 瀏覽器 | DOM parser |
| Markdown | 人類 | 眼睛 |

JSON 是 machine-readable structured；HTML 是 **human-readable structured**；markdown 是 **structured-light**。**+HTML 把 LLM 從「給人看的非結構化」推到「給人看的結構化」**。

---

### Karpathy +HTML ↔ Factor 2（Own Your Prompts）

> Factor 2：**Don't outsource your prompt engineering to a framework.**

+HTML 是 prompt engineering 的具體技藝。要把它做好，你需要：

- 自己寫 STYLE BLOCK
- 自己迭代模板
- 自己測試跨 LLM provider 的一致性
- 自己版控

**完全符合 Factor 2 的「prompt 是 first-class code」**。

---

### Karpathy +HTML ↔ Factor 10（Small Focused Agents）

> Factor 10：**Small, focused agents do one thing well.**

當你用 agent 自動化 HTML 生成 pipeline（例如 [Ch 06 的範例](06-advanced-interactivity.md#進階組合個人-llm-document-pipeline)），每個 template 對應一個 micro-agent：

- report-html-agent: 5-10 step，只負責生成 report
- plan-html-agent: 5-10 step，只負責生成 plan
- wiki-html-agent: 5-10 step，只負責生成 wiki

**不要做一個「萬能 HTML agent」**，做多個 focused agent。

---

## 整合架構：HTML 是 12-factor agent 的「**人類消費介面**」

把 12-factor 完整架構畫出來：

```
[trigger] (Factor 11)
   ↓
[agent loop] (Factor 8, 12)
   ↓
[deterministic tool execution] (Factor 4)
   ↓
[event accumulated in thread] (Factor 3, 5)
   ↓
[possibly: human in the loop] (Factor 7, 6)
   ↓
[final state: thread complete]
   ↓
[★ render thread as HTML report for human review ★]   ← Karpathy +HTML 在這裡進入
```

**最後一步 — 把 agent 跑完的 thread 渲染成 HTML 給人類消費 — 完全是 Karpathy 方法論的領域**。

---

## 實戰範例：deploybot + HTML report

對應 [12-factor 第 0 章的 deploybot 範例](https://github.com/vins-hub/12-factor-agents-zh/blob/master/content/00-brief-history-of-software.md)：

```
Agent 跑完一次 deploy (15 個 events 在 thread 裡)
   ↓
Deterministic code 把 thread 餵給 LLM with HTML template:
   ↓
"Generate a deployment summary as a complete HTML document with:
- Top: Deploy verdict (success / partial / failed) badge
- Timeline: chronological list of all events with timestamps
- Each tool call expandable for full input/output
- Each human approval highlighted
- Bottom: Lessons learned / what to improve next time"
   ↓
存到 reports/deploys/2026-05-19-prod-deploy.html
   ↓
Slack 通知 link 給 SRE team
```

**Agent 自己跑完，自己生成可分享的 HTML 報告**。這就是 12-factor agent + Karpathy +HTML 的合體應用。

---

## 工具鏈整合

把 Karpathy +HTML 寫進你的 12-factor agent codebase：

```python
# agent_renderer.py

HTML_REPORT_TEMPLATE = """
Generate an HTML report summarizing this agent run.

CONTEXT:
{thread_yaml}

STRUCTURE: [Level 3 spec]
STYLE: [STYLE BLOCK]
OUTPUT: complete HTML.
"""

def render_thread_as_html(thread: Thread) -> str:
    """
    Render an agent thread (Factor 5) as a human-readable HTML report.
    Uses Karpathy's +HTML pattern at the final step.
    """
    prompt = HTML_REPORT_TEMPLATE.format(
        thread_yaml=thread_to_yaml(thread)  # Factor 3: 你自己的 serialization
    )
    response = llm.complete(prompt, max_tokens=16000)
    return strip_markdown_wrapper(response)
```

**`render_thread_as_html()` 在 agent loop 完成時呼叫一次**，把跑了 30 分鐘的 thread 變成 1 分鐘可讀的 HTML 報告。

---

## 「Output Engineering」: 新的子領域

過去業界談 prompt engineering / context engineering。**Karpathy 的 +HTML 是「Output Engineering」這個新子領域的開端**。它的問題不是「**LLM 怎麼想**」，而是「**LLM 想完之後怎麼呈現給人類消費**」。

對應的工程實踐還包括：
- HTML 之外的輸出格式（Notion / Markdown enhanced / SVG / PDF / video）
- 多格式同步生成（一次 LLM call 出 markdown + HTML + PDF）
- Style guide 系統化（公司級別的「LLM 輸出 style」一致性）
- 輸出 caching（同樣內容不要每次都 re-render）

**這些都是未來 1-2 年 LLM ops 的成長領域**。

---

## 對你的綜合建議

1. **內部 agent / pipeline 終端輸出**：永遠加 +HTML
2. **跟人類互動的最後一公里**：用 HTML 而非 chat message
3. **跨 team 分享 LLM 結果**：HTML 比 markdown 更專業
4. **公司級別的 LLM 應用**：把 HTML template 庫當公司資產維護

---

## 兩條觀念的終極合體

| 觀念 | 一句話 |
|---|---|
| 12-factor agents | **把 agent 當工程化軟體寫** |
| Karpathy +HTML | **把 LLM 輸出當文件作品做** |
| 合體 | **把 LLM 應用當「軟體 + 文件出版」雙系統設計** |

當你把這兩條都做好，你的 LLM 應用同時擁有：

- **工程紀律**（agent 可控、可暫停、可恢復、可審計）
- **產品質感**（最終輸出可讀、可分享、可印、可保存）

這是 production-grade LLM 應用的雙翼。

---

## 接下來

➡️ [Appendix: HTML/CSS 速查](appendix-html-css-cheatsheet.md)
