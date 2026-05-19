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

> ⚠️ **2026-05-19 自我驗證更新**：先前版本引用了「Stone Age」這句話作為 Karpathy 原話，但實際上那是 [quasa.io](https://quasa.io/media/enough-with-the-walls-of-text-andrej-karpathy-s-simple-lifehack-just-ask-ai-for-html) 的 paraphrase。
> **詳細比對**：[SELF-VALIDATION.md](SELF-VALIDATION.md)

### Karpathy 的真正論述：Audio → Input, Vision → Output

> *"audio is the human-preferred input to AIs but vision (images/animations/video) is the preferred output from them. Around a ~third of our brains are a massively parallel processor dedicated to vision, it is the 10-lane superhighway of information into brain."*
> 
> —— Karpathy 原推文（2026-05-12）

**人類對 AI 的 I/O 偏好是不對稱的**：

| 方向 | 人類偏好 | 為什麼 |
|---|---|---|
| **Input → AI**（你給 AI） | **Audio**（語音） | 講話比打字快，思考流暢 |
| **AI → Output**（AI 給你） | **Vision**（視覺：圖像 / 動畫 / 影片） | 大腦 1/3 是視覺處理器，10 線道資訊高速公路 |

**HTML 不是孤立技巧，是「vision-as-AI-output」這個大論述在 2026 的具體實踐**。

### 4 級演進階梯（Karpathy 原文）

```
1) raw text                    （難讀、費力）
2) markdown                    （現行 default）
3) HTML                        ← 我們在這裡
   ↓ ...
n) interactive neural videos / simulations  
   （由 diffusion neural net 直接生成的互動影片）
```

> *"the extrapolation (though the technology doesn't exist just yet) ends in some kind of interactive videos generated directly by a diffusion neural net."*

HTML **不是終點，是第一步**。在 Neuralink-esque BCI 之前，這是目前能做的最大跳躍。

### 為何 HTML 是當前最佳選擇

- 排版、顏色、字型、間距全套樣式系統
- Tables、lists、accordions、details/summary 可摺疊區塊
- 暗色模式自動切換（`prefers-color-scheme`）
- 響應式 layout
- 連 SVG / Canvas / 簡易互動（`<details>`、`onclick`）都不用加 build step

**你早就有了瀏覽器**——這是地球上裝機率最高的軟體——卻把它閒置，繼續看 markdown 純文字。

### 致謝 Thariq：方法的原始長文

Karpathy 這條推文實際上是 **quote tweet 回應 [@trq212 Thariq 在 May 9 寫的文章](https://x.com/trq212/status/...)「Using Claude Code: The Unreasonable Effectiveness of HTML」**。Thariq（Anthropic Claude Code team）才是最早系統性論述「**markdown 是 agent 與人類溝通的 dominant format，但 HTML 可以做得更好**」的人。Karpathy 推廣了這個方法 + 補上 vision-as-output 的理論基礎。

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

## Karpathy 的 TLDR 金句

> **「The input/output mind meld between humans and AIs is ongoing and there is a lot of work to do and significant progress to be made, way before jumping all the way into neuralink-esque BCIs and all that. For what's worth exploring at the current stage, hot tip try ask for HTML.」**
>
> 「人機 I/O 心靈融合是個持續過程，在跳到 Neuralink-style BCI 之前還有很多進步空間。**就目前可以探索的階段，hot tip：試試請 AI 給你 HTML**。」

順帶一提，Karpathy 也提到 **slideshow** 是另一個有效的 trick（同樣 prompt 結尾要求 LLM 用 slideshow 形式呈現）。這份指南聚焦在 HTML，但 slideshow 是延伸應用。

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
