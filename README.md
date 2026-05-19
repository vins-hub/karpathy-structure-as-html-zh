# Karpathy：把 LLM 回應結構化為 HTML（繁體中文精解版）

> 來源：[@karpathy 推文 2053872850101285137](https://x.com/karpathy/status/2053872850101285137)
> 譯註版本：v1.0 · 2026-05-19 · vins-hub/vinshub
> 授權：以 CC BY-SA 4.0 釋出

---

## 一句話濃縮

> **在你的任何 LLM prompt 結尾，加上一句「Format your entire response as a complete HTML document」，然後把輸出存成 `response.html` 用瀏覽器打開。**

就這樣。一行指令，把 LLM 從「**會寫文字的工具**」變成「**會寫文件的工具**」。

---

## 為什麼這條看似簡單的提示這麼重要

Karpathy 的核心觀察：

> **AI 的輸入端（multimodal、語音、視覺、影片）正在飛速進化，但輸出端還停留在石器時代——大多是純文字或輕度格式化的 markdown。**

這個 mismatch（輸入升維 / 輸出降維）是當前 LLM 應用最大的浪費：模型內部其實能生成豐富的結構化資訊（表格、圖示、互動元素、樣式分區），但我們強迫它輸出 plain text，再把這個 plain text 塞回 textarea / chat bubble。

> 引用 [Karpathy via quasa.io](https://quasa.io/media/enough-with-the-walls-of-text-andrej-karpathy-s-simple-lifehack-just-ask-ai-for-html)：
> 
> *"While AI input methods are advancing rapidly, **Output** is still stuck in the Stone Age — mostly plain text or lightly formatted Markdown."*

**HTML 是現成的、無門檻的、跨平台的「現代輸出層」**：
- 排版、顏色、字型、間距全套樣式系統
- Tables、lists、accordions、details/summary 可摺疊區塊
- 暗色模式自動切換（`prefers-color-scheme`）
- 響應式 layout
- 連 SVG / Canvas / 簡易互動（`<details>`、`onclick`）都不用加 build step

**你早就有了瀏覽器**——這是地球上裝機率最高的軟體——卻把它閒置，繼續看 markdown 純文字。

---

## 心智模型

```
傳統工作流：
   ┌────────┐       ┌──────────┐      ┌────────────┐
   │ prompt │ ───►  │  LLM     │ ───► │ markdown / │
   │        │       │          │      │ plain text │
   └────────┘       └──────────┘      └────────────┘
                                              │
                                              ▼
                                       ┌──────────────┐
                                       │  walls of    │
                                       │  text 💀     │
                                       └──────────────┘

Karpathy 工作流：
   ┌────────┐       ┌──────────┐      ┌────────────┐      ┌──────────┐
   │ prompt │ ───►  │   LLM    │ ───► │ HTML       │ ───► │ browser  │
   │  + ★   │       │          │      │ document   │      │          │
   └────────┘       └──────────┘      └────────────┘      └──────────┘
        ★ "Format your entire response as a                      │
           complete HTML document"                                ▼
                                                          ┌──────────────┐
                                                          │ 排版 / 顏色 / │
                                                          │ 摺疊區 / 表格 │
                                                          │ 暗色模式 ✨   │
                                                          └──────────────┘
```

---

## 學習路徑

| 章節 | 內容 | 適合誰 |
|---|---|---|
| [01. 輸出端瓶頸](content/01-the-output-bottleneck.md) | 為何純文字 / markdown 已經不夠 | 所有 LLM 使用者 |
| [02. HTML 方法論](content/02-the-html-method.md) | 完整 prompt 範本 + 工作流 SOP | 想立刻上手的人 |
| [03. 七大應用場景](content/03-use-cases.md) | Plan / Report / Wiki / Dashboard / Tutorial / Cheatsheet / Code Review | 看你的 use case 對號入座 |
| [04. Prompt 模板庫](content/04-template-library.md) | 9 個可複製貼上的高品質模板 | 立刻可用 |
| [05. 反模式](content/05-anti-patterns.md) | 別這樣做的 8 個陷阱 | 避免踩雷 |
| [06. 進階：互動、可下載、分享](content/06-advanced-interactivity.md) | 從靜態 HTML 升級到 mini app | 想極致化的人 |
| [07. 跟 12-factor agents 的關聯](content/07-relation-to-12-factor.md) | 為何這條跟 Context Engineering 同源 | 體系派 |
| [Appendix: HTML CSS 速查](content/appendix-html-css-cheatsheet.md) | 即查即用的常用 pattern | 工具書 |

---

## 30 秒上手

打開你的 ChatGPT / Claude / Gemini / 任何 LLM，貼這段：

````
[你原本的問題]

---

Format your entire response as a complete HTML document with:
- Clean modern typography (system fonts)
- Color-coded sections by importance
- Collapsible <details> for less-critical content
- Tables for any structured comparison
- Dark/light mode support via prefers-color-scheme
- Responsive layout (max-width: 820px, centered)

Output only the HTML, no markdown wrapper.
````

把輸出存成 `response.html`，雙擊打開。你會在第一次看到的瞬間就理解這個方法的價值。

---

## 為什麼這個方法被低估

絕大多數人接觸 LLM 都是透過 ChatGPT-like 的 chat UI。在 chat UI 裡：

- HTML 被 sandbox 在 iframe 或被禁止
- 樣式有 chat 框架硬規定
- 沒辦法存檔、分享、版本控制

於是大家**默認**「LLM 的輸出是 chat message」。但 LLM **本身**並不知道這件事——你叫它輸出 HTML，它就輸出 HTML。

**Karpathy 提示的洞察**：把 LLM 從「chat 互動」拉回「**文件生成器**」的本質。文件天然就是 HTML。

---

## 主要受益場景

| 用戶 | 受益 |
|---|---|
| **研究 / 學習** | LLM 整理的知識點可摺疊、可搜尋、可重看 |
| **產品 / 規劃** | 給 LLM 一個 spec，它直接吐出可分享的 plan deck |
| **資料分析** | 表格、圖表、條件分析可互動展開 |
| **教學文件** | 階段式揭露、code 區塊高亮、範例可摺疊 |
| **報告寫作** | 直接得到可印 / 可分享的 HTML 報告 |
| **個人 wiki / 第二大腦** | 每次查詢都生成可保存的 HTML 卡片 |

---

## 譯註者的補充

這個方法在中文社群討論度遠低於它的實際效益。Karpathy 用 5 行推文講完的事，**抵得上 100 個 prompt engineering 課程的玄學**。

它之所以神奇，**不是因為 HTML 多複雜**，而是因為它讓你**有意識地拒絕「LLM 輸出 = chat message」這個預設**。一旦你意識到 LLM 可以為你**生成完整文件**，你會發現純 markdown 是個非常窄的天花板。

---

## 接下來

➡️ [Chapter 01: 輸出端瓶頸 — 為何純文字已經不夠](content/01-the-output-bottleneck.md)
