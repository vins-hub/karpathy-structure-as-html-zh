# 自我驗證報告：Karpathy 推文原文比對

> 日期：2026-05-19
> 動作：用 gstack/browse 實際讀取 [@karpathy 推文 2053872850101285137](https://x.com/karpathy/status/2053872850101285137) 原文，比對本 repo 內容

---

## 推文原文（May 12, 2026 12:20 AM · 2.8M views）

> Andrej Karpathy @karpathy
>
> This works really well btw, at the end of your query ask your LLM to "structure your response as HTML", then view the generated file in your browser. I've also had some success asking the LLM to present its output as slideshows, etc.
>
> More generally, imo **audio is the human-preferred input to AIs but vision (images/animations/video) is the preferred output from them**. Around a ~third of our brains are a massively parallel processor dedicated to vision, it is the 10-lane superhighway of information into brain. As AI improves, I think we'll see a progression that takes advantage:
>
> 1) raw text (hard/effortful to read)
> 2) markdown (bold, italic, headings, tables, a bit easier on the eyes) <-- current default
> 3) HTML (still procedural with underlying code, but a lot more flexibility on the graphics, layout, even interactivity) <-- early but forming new good default
> ...4,5,6,...
> n) interactive neural videos/simulations
>
> Imo the extrapolation (though the technology doesn't exist just yet) ends in some kind of interactive videos generated directly by a diffusion neural net. Many open questions as to how exact/procedural "Software 1.0" artifacts (e.g. interactive simulations) may be woven together with neural artifacts (diffusion grids), but generally something in the direction of the recently viral [link to @zan2434].
>
> There are also improvements necessary and pending at the input. Audio nor text nor video alone are not enough, e.g. I feel a need to point/gesture to things on the screen, similar to all the things you would do with a person physically next to you and your computer screen.
>
> **TLDR The input/output mind meld between humans and AIs is ongoing and there is a lot of work to do and significant progress to be made, way before jumping all the way into neuralink-esque BCIs and all that. For what's worth exploring at the current stage, hot tip try ask for HTML.**

**Quote tweet**：Thariq @trq212 (May 9) - "Using Claude Code: The Unreasonable Effectiveness of HTML" — Markdown has become the dominant file format used by agents to communicate with us. It's simple, portable, has some rich text capability and is easy for you to edit. Claude has even gotten...

---

## 比對結果

### ✅ 本 repo 寫對的部分

1. 「**prompt 結尾加 HTML 指令 → 存檔用瀏覽器打開**」核心方法（Ch 02 完全準確）
2. HTML 比 markdown 更豐富的論點（Ch 01）
3. 「最終會演進到 interactive simulations / dynamic visualizations」的未來願景（README）
4. 各種應用場景與 prompt 模板（Ch 03-04）— 這部分是延伸應用，不違反原文精神
5. 反模式（Ch 05）— 延伸實戰，獨立有效

### ❌ 本 repo 缺漏 / 錯誤的部分

#### 缺漏 #1：核心論述 — Audio 是 input, Vision 是 output

**原文重點**：「audio is the human-preferred input to AIs but vision (images/animations/video) is the preferred output from them」

**我的版本**：完全沒提這個雙向 framing。我只講「output 還停留純文字」，但**沒解釋為何 vision 是天然的 output**——大腦 1/3 是視覺處理器、10-lane 資訊高速公路。

**影響**：讀者拿到「**怎麼做**」但拿不到「**為何視覺是對的方向**」的科學基礎。

#### 缺漏 #2：4 級演進階梯

**原文**：明確列出 1) raw text → 2) markdown → 3) HTML → ...4,5,6... → n) interactive neural videos/simulations

**我的版本**：只講 markdown → HTML 跳躍，**沒列出完整光譜**。

**影響**：讀者看不到「HTML 只是 stage 3，未來還會繼續演進」這個更大的圖景。

#### 缺漏 #3：「Stone Age」是 quasa.io 第三方 paraphrase，不是 Karpathy 原話

**我在 README 引用**：*"Output is still stuck in the Stone Age — mostly plain text or lightly formatted Markdown."*

**實際情況**：這句是 [quasa.io 文章](https://quasa.io/media/enough-with-the-walls-of-text-andrej-karpathy-s-simple-lifehack-just-ask-ai-for-html) 的 paraphrase，**不是 Karpathy 推文原文**。Karpathy 自己沒用 Stone Age 這個詞。

**正確引用**應該是：

> Imo audio is the human-preferred input to AIs but vision is the preferred output from them.

#### 缺漏 #4：方法的原始來源 — Thariq

**原文**：Karpathy 這條是 quote tweet 回應 [@trq212 Thariq 在 May 9 寫的文章](https://x.com/trq212/status/...)「Using Claude Code: The Unreasonable Effectiveness of HTML」

**我的版本**：完全把這當成「Karpathy 原創」，**沒提 Thariq**。

**修正**：應該明確標註「Karpathy 推廣的，Thariq 早 3 天先寫了長文論述」。

#### 缺漏 #5：Slideshow 也是 Karpathy 提到的另一個 trick

**原文**：「I've also had some success asking the LLM to present its output as slideshows, etc.」

**我的版本**：完全沒提 slideshow。

#### 缺漏 #6：Diffusion neural net 終極願景

**原文**：「the extrapolation (though the technology doesn't exist just yet) ends in some kind of interactive videos generated directly by a diffusion neural net」

**我的版本**：只籠統說「interactive video / 3D simulation」，沒提**diffusion neural net** 這個具體技術路徑。

#### 缺漏 #7：Input side 也要進步（gesture/point）

**原文**：「I feel a need to point/gesture to things on the screen」

**我的版本**：完全沒提 input side 的演進，給人錯覺以為只有 output 端要升級。

#### 缺漏 #8：TLDR 這句金句沒抓到

**原文 TLDR**：「The input/output mind meld between humans and AIs is ongoing and there is a lot of work to do and significant progress to be made, way before jumping all the way into neuralink-esque BCIs and all that. For what's worth exploring at the current stage, **hot tip try ask for HTML**.」

這句完美收尾了整個論述：**在等 Neuralink 之前，先用 HTML 把現在的 I/O 做到極致**。我的版本沒抓到這層含意。

---

## 對讀者的更正建議

如果你已經讀過本 repo 內容，請在腦中補上：

1. **HTML 不是孤立技巧，是 vision-as-AI-output 大論述的具體實踐**
2. **未來會繼續演進**到 interactive neural videos（diffusion 生成）
3. **Input side 也要升級**（gesture/point at screen）
4. **致謝 Thariq**：他的長文 "Using Claude Code: The Unreasonable Effectiveness of HTML" 是這個方法的原始源頭
5. **不只 HTML，slideshows 也可以**

---

## 計畫修正

下一個 commit 會：
1. 修正 README：補上 audio-vs-vision、4 級演進階梯、TLDR 金句、Thariq 致謝
2. 修正 Ch 01：補上 1/3 大腦視覺處理器的科學基礎
3. 新增 Ch 02 開頭：標註 slideshow 也是相同 trick 的延伸
4. 新增引用塊：原推文完整翻譯版

---

## 自我反思

**為何漏掉這些**：

1. **WebFetch 對 x.com 回 HTTP 402**（推文需 login wall），我只能靠**第三方 paraphrase 源**重建內容
2. 第三方源（LinkedIn / quasa.io）多半**只挑「實用做法」**，**省略 Karpathy 的理論論述**（audio-vs-vision、1/3 大腦）
3. 我**沒主動用 gstack/browse 實際打開瀏覽器讀原推文**——直到用戶提醒

**教訓**：以後 fetch 失敗時，**應該先用 gstack/browse 開瀏覽器**而非依賴二手 paraphrase。

---

[← 回 README](README.md)
