[← 回 README](../README.md)

# 第 01 章：輸出端瓶頸 — 為何純文字已經不夠

> **核心句**：LLM 的輸入端跑在 21 世紀（multimodal、視覺、語音、影片），輸出端還停在 1991 年的純文字 email。這個 input/output 維度錯配是當前 AI 應用最大的隱形浪費。

---

## 對稱性破缺：input vs output

過去 3 年，LLM 的「輸入端」進化驚人：

| 年份 | 輸入升維 |
|---|---|
| 2023 | 純文字 prompt |
| 2024 | 圖像 input（GPT-4V / Claude 3 Vision） |
| 2024 | 文件 input（PDF / Word 直接上傳） |
| 2025 | 即時語音 input（Realtime API） |
| 2025 | 影片 input（Gemini 1.5+） |
| 2026 | Multimodal interleaved（圖文音影同 prompt） |

而**輸出端**呢？

| 年份 | 輸出狀態 |
|---|---|
| 2023 | 純文字 |
| 2024 | 純文字 / markdown |
| 2025 | 純文字 / markdown |
| 2026 | 純文字 / markdown（**還是！**） |

> Karpathy 點破：**「Output is still stuck in the Stone Age — mostly plain text or lightly formatted Markdown.」**

3 年來，input 端做了 5 次跳躍，output 端**幾乎原地踏步**。

---

## 為何 markdown 不夠

Markdown 是 2004 年 John Gruber 設計的，目標是**「易寫的 HTML 替代品」**。它的設計約束：

1. **純文字編輯器友善**（不需 toolbar）
2. **轉成 HTML 簡單**
3. **語法簡潔**

這些約束在 2004 是優點，**在 2026 是限制**：

| Markdown 能做 | Markdown 不能做（但 HTML 可以） |
|---|---|
| 粗體、斜體 | 顏色、字型、字距 |
| 標題層級 | 卡片、邊框、陰影 |
| 列表 | 摺疊區塊、tab 切換 |
| 表格（簡單） | 表格樣式、sticky header、scroll |
| Code block | Syntax highlighting（要 renderer 配合） |
| 連結 | Button、hover、tooltip |
| 圖片 | SVG inline、canvas、互動圖表 |
| — | 暗色模式自動切換 |
| — | 響應式設計（mobile / desktop）|
| — | 動畫、過渡、micro-interaction |
| — | 直接列印 / 存 PDF（瀏覽器原生）|

**Markdown 是無格式的「思考骨架」**；**HTML 是有格式的「呈現作品」**。它們不該被混為一談。

---

## 「Walls of Text」的代價

當 LLM 回答你一個複雜問題，給的是一大段純文字（或 markdown），你的大腦要做什麼？

1. **斷句**：把連續文字切成意義塊
2. **重排優先級**：哪些是核心結論、哪些是支撐論據
3. **建立心智地圖**：各段之間的關係
4. **記住結構**：等等下捲時要記得上面講了什麼

**這四件事，本來應該是「呈現層」做的**，現在全推給你的工作記憶。對複雜問題，這就是為什麼讀 LLM 回答時你會覺得「累」——你的大腦在做 layout engine 的事。

> Karpathy 用詞：**Walls of Text**（文字之牆）——讀完一整堵牆，沒人能記得最上方寫了什麼。

---

## HTML 把工作搬回呈現層

當 LLM 直接吐 HTML：

```html
<!doctype html>
<html>
<head>
  <style>
    body { max-width: 820px; margin: 2rem auto; font-family: system-ui; line-height: 1.6; }
    .conclusion { background: #f0f9ff; border-left: 4px solid #0369a1; padding: 1rem; }
    .secondary { color: #666; font-size: 0.9em; }
    details { margin: 0.5em 0; }
    @media (prefers-color-scheme: dark) {
      body { background: #1a1a1a; color: #ddd; }
      .conclusion { background: #1e3a5f; }
    }
  </style>
</head>
<body>
  <div class="conclusion">
    <strong>結論</strong>：因為 X，所以你該選 A 不選 B。
  </div>
  
  <details>
    <summary>展開：X 是什麼？</summary>
    <p class="secondary">X 是 ...</p>
  </details>
  
  <details>
    <summary>展開：為什麼不是 B？</summary>
    <p class="secondary">B 的問題在於 ...</p>
  </details>
</body>
</html>
```

**讀者體驗瞬間升級**：

- **結論優先**：藍色邊框 box 第一眼就抓住
- **次要細節摺疊**：想看再展開，不想看不擋路
- **暗色模式**：晚上看眼睛不痛
- **可印 / 可存**：瀏覽器 Cmd+P 就 PDF

**這些都是 LLM 內部「**早就知道**」的呈現直覺**，只是你沒問它。

---

## 為什麼大家都沒這樣做

三個原因：

### 1. Chat UI 鎖死預設

ChatGPT / Claude.ai / Gemini 等 chat UI 把 LLM 輸出**強制 sandbox 在 chat bubble**。你會看到：
- HTML 不渲染（或在 iframe 裡限制）
- 樣式被 chat 框架覆寫
- 沒有 "save as html" 按鈕

於是大家**從來沒看過 LLM 輸出完整 HTML 的樣子**。

### 2. Prompt engineering 課程沒教

絕大多數 prompt engineering 教學講 chain-of-thought、few-shot、role prompting…**沒人講「**換個輸出格式**」這件事**。因為它不在「prompt 技巧」傳統範疇——它是「輸出格式」決策。

### 3. Markdown 已被當預設

人類已經習慣 markdown 在 GitHub、Notion、Obsidian。Markdown 「夠好用」掩蓋了「**它不是極限**」的事實。

---

## 一個 mental 實驗

想像兩個版本的同一份產品 spec：

| Version A | Version B |
|---|---|
| 12,000 字 markdown，no formatting | 同樣內容，輸出為 HTML：核心結論在頂、需求區可摺疊、表格 sticky header、TOC sidebar |
| 你會花 30 分鐘讀完，記得 30% | 你會花 10 分鐘讀完，記得 70%，且可以隨時回來查 |

**B 的內容沒有比 A 多——只是「呈現層」做了它的工作**。

---

## 從 Karpathy 的更廣脈絡看

Karpathy 不只在講 HTML，他在講**輸出形式的演化**。他的長期預測：

> *"Interactive videos, 3D simulations, or dynamic visualizations generated on the fly. Instead of reading about something, you'll experience it."*
> 
> 「互動影片、3D 模擬、即時生成的動態視覺化。你不是讀關於某件事，而是**體驗**它。」

HTML **不是終點**，是**第一步**。從 plain text → markdown → HTML → interactive simulation → multimodal experience，是一條清楚的演化路徑。今天能做到的最大跳躍，就是 **markdown → HTML**。

---

## 本章小結

| 觀念 | 為什麼重要 |
|---|---|
| Input 升維 vs Output 停滯 | 找到當前 LLM 應用的最大低效點 |
| Markdown 是 2004 年產物 | 它的設計約束不該綁住 2026 的 LLM 輸出 |
| Walls of Text 推工作給讀者大腦 | 呈現層該做的事不該推給工作記憶 |
| HTML 把工作搬回呈現層 | LLM 本來就會這事，只是你沒問 |
| Chat UI / 教學體系造成盲點 | 大家從沒看過 LLM 完整 HTML 輸出長什麼樣 |

---

## 接下來

➡️ [Chapter 02: HTML 方法論 — 完整 prompt 範本 + 工作流 SOP](02-the-html-method.md)

理解「為何」之後，下一步是「如何」：到底要怎麼寫 prompt、怎麼操作流程，才能穩定拿到高品質 HTML 輸出。
