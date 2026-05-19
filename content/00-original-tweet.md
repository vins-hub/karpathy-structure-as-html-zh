[← 回 README](../README.md)

# 第 00 章：Karpathy 原推文完整對照

> 來源：[@karpathy/status/2053872850101285137](https://x.com/karpathy/status/2053872850101285137) · 2026-05-12 · 2.8M views
> 抓取方式：gstack/browse headless browser 實際載入

---

## 英文原文（完整）

> Andrej Karpathy @karpathy
>
> This works really well btw, at the end of your query ask your LLM to "structure your response as HTML", then view the generated file in your browser. I've also had some success asking the LLM to present its output as slideshows, etc.
>
> More generally, imo audio is the human-preferred input to AIs but vision (images/animations/video) is the preferred output from them. Around a ~third of our brains are a massively parallel processor dedicated to vision, it is the 10-lane superhighway of information into brain. As AI improves, I think we'll see a progression that takes advantage:
>
> 1) raw text (hard/effortful to read)
> 2) markdown (bold, italic, headings, tables, a bit easier on the eyes) <-- current default
> 3) HTML (still procedural with underlying code, but a lot more flexibility on the graphics, layout, even interactivity) <-- early but forming new good default
> ...4,5,6,...
> n) interactive neural videos/simulations
>
> Imo the extrapolation (though the technology doesn't exist just yet) ends in some kind of interactive videos generated directly by a diffusion neural net. Many open questions as to how exact/procedural "Software 1.0" artifacts (e.g. interactive simulations) may be woven together with neural artifacts (diffusion grids), but generally something in the direction of the recently viral [@zan2434/status/2046982383430496444](https://x.com/zan2434/status/2046982383430496444)
>
> There are also improvements necessary and pending at the input. Audio nor text nor video alone are not enough, e.g. I feel a need to point/gesture to things on the screen, similar to all the things you would do with a person physically next to you and your computer screen.
>
> TLDR The input/output mind meld between humans and AIs is ongoing and there is a lot of work to do and significant progress to be made, way before jumping all the way into neuralink-esque BCIs and all that. For what's worth exploring at the current stage, hot tip try ask for HTML.

**Quote tweet 對象**：

> Thariq @trq212 · May 9
> 
> **Article: Using Claude Code: The Unreasonable Effectiveness of HTML**
>
> Markdown has become the dominant file format used by agents to communicate with us. It's simple, portable, has some rich text capability and is easy for you to edit. Claude has even gotten...

---

## 繁體中文逐段翻譯

> **Andrej Karpathy（@karpathy）**

> 順道一提，這招效果非常好——在你 query 結尾請 LLM「**把你的回應結構化為 HTML**」，然後在瀏覽器打開生成的檔案。我也試過請 LLM 用**簡報（slideshow）**等形式呈現輸出，也滿成功的。

> 從更廣的角度看，**個人觀點**：**audio 是人類偏好的「給 AI」輸入方式，但 vision（圖像 / 動畫 / 影片）是人類偏好的「AI 給人」輸出方式**。我們大腦約 1/3 是專門處理視覺的大規模平行處理器，它是進入大腦的「10 線道資訊高速公路」。AI 變強後，我預期會看到一條善用這個事實的演進路徑：

> **1) raw text**（純文字，難讀、費力）
> **2) markdown**（粗體、斜體、標題、表格——對眼睛較友善）**← 目前 default**
> **3) HTML**（底下仍是程式碼，但圖形、layout、甚至互動的彈性大很多）**← 新興、正成為新 default**
> ...4, 5, 6, ...
> **n) 互動式 neural 影片 / 模擬**

> 我認為**極端外推**（雖然技術現在還不存在）會結束在某種**由 diffusion neural net 直接生成的互動式影片**。在「精確/程序化的 Software 1.0 artifact（例如互動式模擬）如何與 neural artifact（diffusion grid）編織在一起」這個問題上有很多 open question，但大致方向是像 [@zan2434](https://x.com/zan2434/status/2046982383430496444) 最近爆紅的那個方向。

> 輸入端也有改善需要做。Audio 或 text 或 video 任一單獨都不夠——例如我覺得需要**指 / 比劃螢幕上的東西**，類似於你跟一個實際坐你旁邊看你螢幕的人會做的所有動作。

> **TLDR**：人類跟 AI 之間的「**input/output 心靈融合**」是個持續演進的議題，**在跳到 Neuralink-esque BCI 之前還有大量工作要做、大量進步空間**。**就目前可以探索的階段，hot tip：試試請 AI 給你 HTML**。

---

## 上下文：被引用的 Thariq 原始文章

Karpathy 的推文是 quote tweet 形式，被引用的是 **Thariq（@trq212，Anthropic Claude Code team）**在 5/9 發表的 X Article：

**標題**：「Using Claude Code: The Unreasonable Effectiveness of HTML」

**開頭段落（X 預覽可見）**：
> Markdown has become the dominant file format used by agents to communicate with us. It's simple, portable, has some rich text capability and is easy for you to edit. Claude has even gotten...

**這篇是「LLM 輸出 HTML」方法的原始系統論述**。Karpathy 推廣它並加上 vision-as-output 的理論基礎。

要看 Thariq 原文，需要 X premium 或從 Thariq 的個人 site 查找。

---

## 從原推文可以拆解出的精確論點

| # | 論點 | 章節對應 |
|---|---|---|
| 1 | **方法**：query 結尾要求 LLM 輸出 HTML | Ch 02 方法論 |
| 2 | **延伸**：slideshow 也是類似 trick | Ch 02 / Ch 04 |
| 3 | **理論**：audio = preferred input, vision = preferred output | Ch 01 為何有效 |
| 4 | **科學**：人腦 1/3 是視覺處理器（10 線道）| Ch 01 |
| 5 | **演進階梯**：text → markdown → HTML → ... → neural video | Ch 01 / README |
| 6 | **未來**：diffusion neural net 直接生成互動影片 | Ch 07 |
| 7 | **input 端也要進步**：gesture/point at screen | 延伸思考 |
| 8 | **TLDR**：BCI 之前用 HTML 探索 | README |

---

## 引文準確性聲明

本 repo 第一版（commit 13ac436）部分引用「Output is still stuck in the Stone Age」**是 quasa.io 的 paraphrase，不是 Karpathy 原話**。已在 [SELF-VALIDATION.md](../SELF-VALIDATION.md) 詳細說明並修正。

如果你看到本 repo 任何地方引用 Karpathy 時用了引號 `"..."`，**請對照本章原文確認**。本章的英文版才是 source of truth。

---

## 接下來

➡️ [Chapter 01: 輸出端瓶頸 — 為何純文字已經不夠](01-the-output-bottleneck.md)
