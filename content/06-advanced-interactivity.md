[← 回 README](../README.md) · [← Ch 05](05-anti-patterns.md)

# 第 06 章：進階 — 互動、可下載、分享

> **核心句**：靜態 HTML 的天花板比你想像的高。在「**不寫 build step、不引外部 framework**」的前提下，你可以加上摺疊、tab、sort、search、copy、localStorage 持久化、PDF 列印優化、可分享 link，把 HTML 輸出從「文件」升級成「mini app」。

---

## 進階範圍的明確邊界

本章談的是**「inline JS 不超過 100 行能實作」**的互動。超過這個，請見 [反模式 #8](05-anti-patterns.md#反模式-8html-文件越做越複雜反而失去-llm-加值)，換真 framework。

---

## 6 個 inline JS 互動 pattern

### Pattern 1：可摺疊區塊（純 HTML，零 JS）

最便宜的互動，不用任何 JS：

```html
<details>
  <summary>展開：詳細推導</summary>
  <p>因為 X，所以 Y...</p>
</details>
```

加上樣式：

```css
details {
  border: 1px solid #ddd;
  border-radius: 4px;
  padding: 0.5em 1em;
  margin: 0.5em 0;
}
summary {
  cursor: pointer;
  font-weight: 600;
}
details[open] summary {
  margin-bottom: 0.5em;
}
```

**Prompt 加**：
```
Use <details>/<summary> for any content the reader might want to skip.
Default state: open for primary sections, collapsed for secondary.
```

---

### Pattern 2：Tab 切換（30 行 JS）

```html
<div class="tabs">
  <nav>
    <button data-tab="overview" class="active">Overview</button>
    <button data-tab="details">Details</button>
    <button data-tab="data">Data</button>
  </nav>
  <section data-content="overview" class="active">...</section>
  <section data-content="details" hidden>...</section>
  <section data-content="data" hidden>...</section>
</div>

<script>
document.querySelectorAll('.tabs nav button').forEach(btn => {
  btn.addEventListener('click', () => {
    const target = btn.dataset.tab;
    btn.parentElement.querySelectorAll('button').forEach(b => 
      b.classList.toggle('active', b === btn));
    btn.closest('.tabs').querySelectorAll('section').forEach(s => {
      const isTarget = s.dataset.content === target;
      s.classList.toggle('active', isTarget);
      s.hidden = !isTarget;
    });
  });
});
</script>
```

---

### Pattern 3：表格 sort（40 行 JS）

```html
<table id="data-table">
  <thead>
    <tr>
      <th data-sort="name">Name ▲▼</th>
      <th data-sort="value">Value ▲▼</th>
      <th data-sort="date">Date ▲▼</th>
    </tr>
  </thead>
  <tbody>...</tbody>
</table>

<script>
const tbl = document.getElementById('data-table');
const tbody = tbl.querySelector('tbody');
let sortState = {col: null, asc: true};

tbl.querySelectorAll('th[data-sort]').forEach((th, i) => {
  th.style.cursor = 'pointer';
  th.addEventListener('click', () => {
    const col = th.dataset.sort;
    sortState.asc = sortState.col === col ? !sortState.asc : true;
    sortState.col = col;
    const rows = Array.from(tbody.querySelectorAll('tr'));
    rows.sort((a, b) => {
      const av = a.children[i].textContent.trim();
      const bv = b.children[i].textContent.trim();
      const aNum = parseFloat(av), bNum = parseFloat(bv);
      const cmp = !isNaN(aNum) && !isNaN(bNum) 
        ? aNum - bNum 
        : av.localeCompare(bv);
      return sortState.asc ? cmp : -cmp;
    });
    rows.forEach(r => tbody.appendChild(r));
  });
});
</script>
```

---

### Pattern 4：Search filter（20 行 JS）

```html
<input id="search" placeholder="Filter...">
<table>
  <tbody id="searchable">
    <tr><td>foo</td><td>123</td></tr>
    <tr><td>bar</td><td>456</td></tr>
  </tbody>
</table>

<script>
document.getElementById('search').addEventListener('input', (e) => {
  const q = e.target.value.toLowerCase();
  document.querySelectorAll('#searchable tr').forEach(tr => {
    tr.hidden = !tr.textContent.toLowerCase().includes(q);
  });
});
</script>
```

---

### Pattern 5：Copy 按鈕（15 行 JS）

```html
<pre><code>fetch_data --output csv</code><button class="copy-btn">Copy</button></pre>

<script>
document.querySelectorAll('.copy-btn').forEach(btn => {
  btn.addEventListener('click', () => {
    const code = btn.previousElementSibling.textContent;
    navigator.clipboard.writeText(code);
    const orig = btn.textContent;
    btn.textContent = 'Copied!';
    setTimeout(() => btn.textContent = orig, 1500);
  });
});
</script>
```

---

### Pattern 6：localStorage 持久化（25 行 JS）

讓用戶的 checkbox 狀態 / 折疊狀態跨 session 保留：

```html
<label><input type="checkbox" data-persist="task-1"> 完成設計 Spec</label>
<label><input type="checkbox" data-persist="task-2"> 完成 API 文件</label>

<script>
document.querySelectorAll('input[data-persist]').forEach(input => {
  const key = 'persist:' + input.dataset.persist;
  input.checked = localStorage.getItem(key) === '1';
  input.addEventListener('change', () => {
    localStorage.setItem(key, input.checked ? '1' : '0');
  });
});
</script>
```

---

## PDF 列印優化

當你要把 HTML 印成 PDF（Chrome Cmd+P → "Save as PDF"），加這段 CSS：

```css
@media print {
  body { 
    max-width: none !important; 
    margin: 0 !important;
    background: white !important;
    color: black !important;
  }
  
  /* 避免在 card / table 中間斷頁 */
  .card, table, pre {
    break-inside: avoid;
  }
  
  /* 隱藏互動元素 */
  .copy-btn, .search-input, nav.tabs {
    display: none !important;
  }
  
  /* 強制展開所有 details */
  details { 
    break-inside: avoid;
  }
  details[open] summary {
    margin-bottom: 0;
  }
  
  /* 連結後面顯示 URL */
  a[href]:after {
    content: " (" attr(href) ")";
    font-size: 0.85em;
    color: #666;
  }
  
  /* A4 紙設定 */
  @page {
    size: A4;
    margin: 1.5cm;
  }
}
```

**Prompt 加**：
```
Include @media print CSS for:
- Removing max-width and dark colors
- Avoiding break-inside on cards/tables/pre
- Hiding interactive UI (.copy-btn, search input)
- Force-expanding all <details>
- A4 page size with 1.5cm margins
```

---

## 可下載成檔案

讓 HTML 自己生成 CSV / JSON / Markdown 給用戶下載：

```html
<button id="export-csv">Export as CSV</button>

<script>
document.getElementById('export-csv').addEventListener('click', () => {
  const rows = [['Name', 'Value']];
  document.querySelectorAll('#data-table tbody tr').forEach(tr => {
    rows.push(Array.from(tr.children).map(td => td.textContent.trim()));
  });
  const csv = rows.map(r => r.map(c => `"${c.replace(/"/g, '""')}"`).join(',')).join('\n');
  const blob = new Blob([csv], {type: 'text/csv'});
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = 'data.csv';
  a.click();
  URL.revokeObjectURL(url);
});
</script>
```

---

## 可分享：把 HTML 當 single file 分享

HTML 的最大優勢之一是「**一個檔案就是完整作品**」，可以：

1. **Email 附件**：HTML 直接收件人雙擊就能看
2. **AirDrop / 微信檔案**：同樣
3. **存 iCloud / Dropbox / 公司 wiki**：當 first-class document
4. **存 git**：版控
5. **用 [GitHub Gist](https://gist.github.com) 公開**：得到一個可分享 link

進階：把 HTML 轉成 **data URL** 直接做成超連結：

```bash
# macOS: 把 HTML 轉 data URL，複製到剪貼簿
DATA_URL="data:text/html;base64,$(base64 -i response.html)"
echo "$DATA_URL" | pbcopy
# 貼到瀏覽器網址列直接打開（沒檔案傳遞需要）
```

注意 data URL 有長度限制（Chrome ~ 2MB），太大檔案不適合。

---

## 把 HTML 變成 PWA（offline-first）

加 `<link rel="manifest">` + service worker，理論上 HTML 可以 install 到桌面當 app。**但**這超出本章範圍，需要 build step。**如果你有這需求，請用真的 PWA 工具鏈**。

---

## 進階組合：個人「LLM Document Pipeline」

完整工作流範例：

```python
#!/usr/bin/env python3
# ~/bin/llm-html
import sys, os, subprocess, anthropic, datetime

TEMPLATES = {
    'report': open('~/.prompts/html-report.md').read(),
    'plan': open('~/.prompts/html-plan.md').read(),
    'wiki': open('~/.prompts/html-wiki.md').read(),
    # ...
}

def main():
    template_name = sys.argv[1]  # 'report' / 'plan' / 'wiki'
    user_prompt = sys.stdin.read()
    
    client = anthropic.Anthropic()
    full_prompt = f"{user_prompt}\n\n---\n\n{TEMPLATES[template_name]}"
    
    msg = client.messages.create(
        model="claude-opus-4-7",
        max_tokens=16000,
        messages=[{"role": "user", "content": full_prompt}]
    )
    
    html = msg.content[0].text.strip()
    # 剝除可能的 markdown wrapper
    if html.startswith('```html'):
        html = html[7:]
    if html.endswith('```'):
        html = html[:-3]
    
    # 存到 ~/Documents/llm-outputs/
    out_dir = os.path.expanduser('~/Documents/llm-outputs')
    os.makedirs(out_dir, exist_ok=True)
    ts = datetime.datetime.now().strftime('%Y%m%d-%H%M%S')
    path = f'{out_dir}/{template_name}-{ts}.html'
    
    with open(path, 'w') as f:
        f.write(html.strip())
    
    # 自動打開
    subprocess.run(['open', path])
    print(f'✓ Saved: {path}')

if __name__ == '__main__':
    main()
```

使用：
```bash
echo "Analyze my Q1 sales data: ..." | llm-html report
echo "Plan migration to PostgreSQL" | llm-html plan
echo "Wiki entry on Kubernetes Operators" | llm-html wiki
```

---

## 進階心法

### 心法 1：JS 互動 < 100 行就是甜蜜點

超過 100 行 inline JS，debug 成本 > 自己寫的成本。守住這條線。

### 心法 2：CSS 投資 > JS 投資

漂亮的 CSS（顏色、間距、字型、轉場）給讀者的價值，遠大於同樣 token 的 JS 互動。**先投資 CSS，再考慮 JS**。

### 心法 3：每個互動都要在沒 JS 時也能用

漸進增強原則：表格沒 JS 也能讀（只是不能 sort）、details 沒 JS 也能展開、search 沒 JS 至少不會 break 頁面。

### 心法 4：用 Chrome DevTools 反向學習

LLM 給的 HTML 你覺得很美，但你不知道怎麼來的？**用 DevTools 看 source、看 computed style**，把好東西抄進你的 STYLE BLOCK。

---

## 接下來

➡️ [Chapter 07: 跟 12-factor agents 的關聯](07-relation-to-12-factor.md)
