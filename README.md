# 阿亮 · 述职 HTML PPT （aliang-shuzhi-html-ppt）

**一套专门为「述职 / 汇报」做的 HTML 版 PPT 模板 + 设计系统**，交给 AI Agent（Claude Code / Codex /
Cursor…）来用。产物是一个 `index.html`，浏览器全屏打开就能放映 —— 不用 PowerPoint，不用 Keynote。

设计语言参考了 **苹果官网（apple.com）** 的风格：SF Pro + 苹方字体、克制的配色、柔和的多层阴影、大量留白、
每页一个视觉重点。**默认是黑白商务蓝主题，但品牌色可以随便换** —— 改几个 token 就能换成你自己公司的品牌色或别的风格。

它不是一个"填空式模板"，而是一套**设计系统 + 工作流**：你把素材给 Agent，它按规则把整套 PPT 搭出来；换主题改
几个颜色，换内容改文字，**结构和那股"苹果质感"直接复用**。

![封面](docs/preview-cover.png)

---

## 这套模板能解决什么

述职做 PPT，传统流程又慢又费神：整数据一天、抠排版对齐一天，还得跟同事一样卷模板。换成 AI 做 HTML 之后：

- **改东西基本靠一张嘴** —— 对齐、挪位置、改措辞，一句话的事。
- **视觉天花板更高** —— 放图、加动画、内嵌视频都简单，本质就是个网页。
- **批量改一句话全改** —— 某个词写错了，一次性全替换，不用一页页翻。
- **顺手给一份演讲腹稿** —— Agent 知道你每页要讲什么，出口播稿几乎是免费的。
- **分发简单** —— 打包成压缩包发出去，对方解压点 `index.html` 就能放。

但有个坑：AI 第一版"自以为好看"的东西，往往一股塑料 AI 味 —— 花花绿绿的 emoji 图标、到处都是色块卡片。
**这套 skill 就是把那股味儿摁住的一整套规则。**

## 截图（样片为脱敏示例，产品/数字均虚构）

<table>
<tr>
<td width="50%"><img src="docs/g-opening.png" alt="开场 · 一句话背景"></td>
<td width="50%"><img src="docs/preview-result.png" alt="数据页 · 开门见山晒结果"></td>
</tr>
<tr>
<td><img src="docs/g-layered-shots.png" alt="手段页 · 真实后台截图叠放"></td>
<td><img src="docs/g-funnel.png" alt="思考假设 · 漏斗信息图"></td>
</tr>
<tr>
<td><img src="docs/g-flywheel.png" alt="业务飞轮 · 唯一的招牌动画"></td>
<td><img src="docs/g-carousel.png" alt="功能截图 · 轮播"></td>
</tr>
<tr>
<td><img src="docs/g-todo.png" alt="下一步 · 主推大块 + 列表"></td>
<td><img src="docs/g-video.png" alt="视频成果 · 页内播放"></td>
</tr>
</table>

## 三个关键（做好一份述职 PPT 的要点）

1. **先把"怎么分页"定下来，再动手。** 别甩一坨文字让模型自己猜分页 —— 它按感觉拆，你来回返工。先给它结构化
   输入（一个主题一块：背景 · 目标 · 关键数据 · 思考 · to-do），或者一起把大纲理出来，再生成。
2. **抄大厂官网的设计语言，禁用 emoji。** 别教模型"审美" —— 直接让它学 apple.com（或你/你老板都认可的品牌）。
   并且明确禁止用 emoji 当图标（这是廉价 AI 味的头号来源），改用一套开源线性图标。
3. **动画和炫技要克制。** 述职场景，内容权重永远大于呈现。挑一两个最想让老板记住的地方稍微亮一下技术，其余保持
   安静。业绩硬 + 一点恰到好处的呈现 = 锦上添花；业绩一般还堆一堆炫酷动画 = 帮倒忙。

## 怎么用

1. 把这个文件夹放到 Agent 能读到的地方（当成一个 skill，或直接让它读 `SKILL.md`）。
2. 跟它说：*"基于这份材料，帮我做个述职用的 HTML PPT。"*
3. Agent 会按 `SKILL.md` 走：搞清目标和受众 → **先和你确认逐页结构** → 选主题（不指定就用默认那套）→ 从
   `templates/deck-template.html` 搭 → 用 `scripts/validate-deck.sh` 自检 → 打包。
4. 想先看效果：打开 `examples/business-deck/index.html`（← / → 翻页，`F` 全屏）。

## 换成你自己的品牌 / 风格

所有可改的颜色都在 `:root` 里以 token 形式存在。**默认是苹果蓝商务主题**；要换：

- 改 `--accent` 及它的 `-d / -soft / -line` 几档，再改封面/分隔页/结尾的渐变 —— 就这些。
- 例：企业绿 `#1f9a40`、紫色 `#6E56F0`、极光多色渐变（只在章节页用）。
- 中性色、阴影、圆角保持不变 —— 那是"苹果质感"的根。
- Logo：把占位的 `<div class="lg">…</div>` 换成你的 `<img>`。

**不指定就用默认那套**，Agent 会告诉你这是默认色、随时能换。

## 仓库结构

```
aliang-shuzhi-html-ppt/
├── SKILL.md                       # Agent 入口：工作流 + 布局菜单 + 构建 checklist
├── references/
│   ├── design-system.md           # 设计 token：配色 · 字体 · 间距 · 阴影 · 动效 · 数字
│   ├── design-principles.md       # do's & don'ts + 硬禁忌项
│   ├── components.md             # 一套封闭的「命名布局」菜单
│   ├── workflow.md              # 需求 → 确认分页 → 搭建 → 自检 → 打包
│   └── verify.md                # 溢出 / 动画同步 / 违规模式自检
├── templates/
│   └── deck-template.html         # 可换主题的空白脚手架（引擎 + 全套 CSS + 占位页）
├── examples/business-deck/        # 一份完整、已脱敏的样片（参照基准）
│   ├── index.html · assets/ · _mocks/   # _mocks 是用无头 Chrome 渲染真实截图的源码
└── scripts/
    └── validate-deck.sh           # 按硬规则 lint 一份 deck
```

## 设计系统要点

- **苹果字体、不联网**：`-apple-system / SF Pro Display + 苹方 PingFang SC`，系统自带，离线/投屏都稳
  （SF Pro 不能合法网络内嵌，所以走系统回退链）。
- **克制配色**：近中性底 + 近黑正文 + **一个强调色**。品牌色只出现在数字、小标签、图标徽章、关键词、章节页渐变。
- **数字是一等规则**：▲ 绿=增、▼ 红=减、每个数据页只留**一个品牌蓝的旗舰数字**；进场数字滚动。
- **柔和多层阴影**、18–22px 圆角、大留白、每页一个焦点。
- **每个 deck 只留一个招牌动画**（比如那个会转的飞轮）—— 点缀，不是主菜。

## 硬禁忌（即使随口要求也不做）

- ❌ 用 emoji 当图标 → 改用一套开源线性图标（SVG sprite）。
- ❌ 卡片左边带竖色块（最像 AI 生成的样式）。
- ❌ 把每句观点都套进卡片 → 观点是大字 + 一个染色关键词，不是色块。
- ❌ 述职场景里满屏炫技动画。

`scripts/validate-deck.sh` 会自动卡前三条。

---

## English

**A purpose-built HTML deck template + design system for performance reviews & reports**, driven by a
coding agent (Claude Code / Codex / Cursor…). Output is one `index.html` you open full-screen in any
browser — no PowerPoint, no Keynote. The visual language emulates **apple.com** (SF Pro + PingFang SC,
restrained color, soft layered shadows, generous whitespace). The default is a black-&-white business
theme, but **brand colors are swappable** — change a few tokens to re-brand to any color or style.

It's a **design system + workflow**, not a fill-in template: give the agent your material and it builds
the deck; re-theme by changing tokens, re-content by changing text. The three rules that make it read
as *designed*: **(1) confirm the page-by-page structure before building, (2) emulate Apple's design
language and ban emoji icons, (3) keep animation restrained — content outranks form in a review.**

**Use it:** point your agent at `SKILL.md` and ask for "an HTML deck for my review from this material."
It confirms the outline with you, themes (defaults to the bundled palette), builds from
`templates/deck-template.html`, lints with `scripts/validate-deck.sh`, and packages. See
`examples/business-deck/index.html` for a complete, desensitized reference (← / → to navigate, `F` for
full-screen).

**Non-negotiables:** no emoji icons (use an open-source line-icon SVG set); no card with a left
vertical color bar; statements are large text with a colored keyword, not boxes; no showy deck-wide
animation. The first three are enforced by the lint script.

## License

[MIT](LICENSE) © 2026 Arthur Wu. 样片完全虚构 / 脱敏 —— "AI Console" 产品与所有数字均为示意。
