[← 回 README](../README.md) · [← Ch 04](04-template-library.md)

# 第 05 章：反模式 — 別這樣用

> **核心句**：HTML 輸出是強力工具，但**用錯場合會反而降低生產力**。本章列出 8 個常見陷阱，幫你判斷「**這次該用 HTML 嗎？**」

---

## 反模式 #1：用 HTML 包一句話回答

❌ **錯**：
> Q：Python `enumerate` 怎麼用？
> A：[300 行 HTML，裡面只有「`enumerate(iterable)` returns (index, value) tuples」這 1 行真內容]

**為什麼壞**：HTML wrapper 自重 200 行 boilerplate，內容只 1 行。產生「**樣板包雜訊**」。

✅ **正解**：短回答用純 markdown / plain text。HTML 是給「**結構性內容**」用的，不是給任何輸出都用的。

**判準**：如果輸出 < 200 字、或沒有 section 結構，**不要 +HTML**。

---

## 反模式 #2：HTML 輸出當 chat reply

❌ **錯**：在 ChatGPT / Claude.ai 的 chat 介面用 `+HTML`，期待 chat bubble 渲染 HTML。

**為什麼壞**：
- Chat UI sandbox HTML，多數樣式不生效
- 即使顯示，也被 chat 框架尺寸鎖住
- 沒辦法存檔、分享、用 DevTools 調

✅ **正解**：HTML 輸出**永遠應該存成檔案、用瀏覽器打開**。Chat UI 是 review 用，不是消費用。

工作流：
```
LLM (chat) → 複製 HTML → 存 response.html → 雙擊瀏覽器
```

---

## 反模式 #3：要求 HTML 但不指定 style

❌ **錯**：「Format as HTML.」（句點，沒了）

**為什麼壞**：LLM 會給你**極醜的 default HTML**——白底黑字、Times New Roman、無 spacing。**會比 markdown 還難讀**。

✅ **正解**：永遠 + STYLE BLOCK（見 [Ch 04](04-template-library.md)）。最少要指定：
- 字型（system fonts）
- max-width
- line-height
- 暗色模式

「HTML 不給樣式 = 比 markdown 還慘」。

---

## 反模式 #4：用 HTML 當「美化外殼」隱藏內容貧乏

❌ **錯**：內容只有 3 個 bullet point，硬要包成 dashboard + KPI cards + charts，造成「**設計感勝過資訊量**」的「**deck 詐欺**」。

**為什麼壞**：
- 讀者預期 dashboard 等級資訊，實際只有 3 點
- 浪費 token / 時間 / 注意力
- 自欺欺人（看起來像做了很多事，其實沒）

✅ **正解**：**內容深度先**，呈現形式跟著內容走。3 個 bullet 就好好寫 3 個 bullet。

判準：「**如果 LLM 給的是純文字版，內容夠豐富嗎？**」如果不夠，HTML 也救不了。

---

## 反模式 #5：迭代時整份重新生成

❌ **錯**：第一版 HTML 出來不滿意 → 重新 prompt 從頭來 → 結果樣式變了，連好的部分都丟了。

**為什麼壞**：
- 浪費 token
- 結果不穩定（LLM 隨機性）
- 失去先前 iteration 的精華

✅ **正解**：**保留 + 局部修改**模式。把第一版 HTML 貼回 prompt：
```
Here's the current HTML:
[paste full HTML]

Modify ONLY:
- Section 3: change to ...
- The KPI on the top right: update value to ...

Keep all other CSS and structure identical. Output the complete modified HTML.
```

---

## 反模式 #6：在 HTML 裡塞「人類看不到」的 metadata

❌ **錯**：要求 LLM 在 HTML 裡塞 hidden comments 給「下一個 LLM 看」（meta-prompt within HTML）。

**為什麼壞**：
- HTML 是給人讀的，不是 agent 中間態
- 把不同抽象層攪在一起
- Debug 時無法分辨「這段是給人看的還是給 LLM 看的」

✅ **正解**：HTML 是**終端輸出**。如果你要做 multi-step LLM workflow（agent），用 JSON / structured output 在中間步驟，**最後一步**才轉成 HTML 給人類消費。

呼應 [12-factor agents Factor 4](https://github.com/vins-hub/12-factor-agents-zh)：tool 是 structured output，HTML 不是 tool 是輸出層。

---

## 反模式 #7：依賴外部 CDN 但 demo 是離線環境

❌ **錯**：模板裡寫 `<script src="https://cdn.jsdelivr.net/...">`，但用戶在飛機上、會議室斷網、或要把 HTML 寄給沒網路的人。

**為什麼壞**：HTML 看起來沒問題，實際打開圖表全是空白。

✅ **正解**：兩種策略：

1. **完全 self-contained**：禁用外部 CDN，所有圖表用 inline SVG（適合報告、寄送）
2. **明確標註**：「This HTML requires internet for Chart.js. To use offline, [...]」（適合可控環境）

模板裡加：
```
- ALL JS and CSS must be inline (no external CDN)
- For charts, use inline SVG (no Chart.js)
```

---

## 反模式 #8：HTML 文件越做越複雜，反而失去 LLM 加值

❌ **錯**：你發現 HTML 很神奇後，要求 LLM 做越來越複雜的事——複雜動畫、複雜互動、複雜資料 binding。最後 HTML 變成「**LLM 寫的 SPA**」。

**為什麼壞**：
- LLM 寫複雜 JS 一定會有 bug
- 為了 debug 你花的時間 > 自己寫的時間
- 失去原本「**5 秒 prompt 換 10 倍輸出**」的 ROI

✅ **正解**：**HTML 輸出的甜蜜點是「靜態 + 少量互動」**。需要的互動限制在：
- 摺疊 / 展開（`<details>`）
- 表格 sort（30 行 inline JS）
- Tab 切換（30 行 inline JS）
- Copy 按鈕（5 行 inline JS）
- localStorage 持久化簡單狀態

**超過這個範圍，請用真的 framework（React / Vue）跟真的工具鏈**。

---

## 三個「該用真 framework 的信號」

當你出現下面任一信號，就該停止 +HTML 路線，換 React / Vue：

| 信號 | 為何要換 |
|---|---|
| 「LLM 寫的 JS bug 越來越多」 | LLM 不擅長複雜 stateful UI |
| 「要做 form 驗證 / 多步驟流程」 | React Hook Form / Vue 等成熟方案完爆 LLM 寫的 |
| 「要連 API、要持久化、要登入」 | 那是 web app 不是 HTML 文件 |

**HTML 輸出的定位**：**「文件 / 報告 / 知識 / dashboard 等以閱讀為主的東西」**。Web app 不在範圍內。

---

## 反模式比較表

| 反模式 | 信號 | 解法 |
|---|---|---|
| #1 包一句話 | 內容 < 200 字 | 用 markdown |
| #2 chat 介面渲染 | HTML 顯示異常 | 存檔用瀏覽器開 |
| #3 不指定 style | 預設 ugly HTML | 加 STYLE BLOCK |
| #4 美化包貧乏 | 設計遠勝內容 | 加深內容 |
| #5 整份重生成 | 樣式隨機飄 | 保留 + 局部改 |
| #6 hidden metadata | LLM-to-LLM 訊息混在 HTML | 分離抽象層 |
| #7 線上 CDN 依賴 | 離線打開壞掉 | self-contained |
| #8 LLM 寫 SPA | JS bug 多 | 換真 framework |

---

## 自我檢查清單

下次要用 +HTML 之前，問自己這 5 題：

1. [ ] 這個輸出我會看超過 1 次嗎？
2. [ ] 這個輸出有 ≥ 3 個 sections？
3. [ ] 我有 STYLE BLOCK 嗎？
4. [ ] 我要不要 self-contained（無 CDN）？
5. [ ] 我預期是「文件」還是「互動 web app」？（後者請換 framework）

5 題都對的，下手 +HTML。否則用更輕量的方案。

---

## 接下來

➡️ [Chapter 06: 進階 — 互動、可下載、分享](06-advanced-interactivity.md)

在「靜態文件」的天花板內，怎麼把 HTML 輸出做到極致。
