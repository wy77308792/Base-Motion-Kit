# Animation Inventory

> DM = dark mode, LM = light mode. Image/video preview assets are excluded; snippets should not reference bundled image files.

| ID | Name | Source | Scenario | Intent | Tech | Variants | Reuse | Snippet |
|---|---|---|---|---|---|---|---|---|
| `ambient-ripple` | 涟漪呼吸背景 | Downloads/动画 Skill/呼吸动画 031011 | page background / overlay | ambient, focus, premium feel | HTML, CSS keyframes, SVG mask, JS mouse trail | LM, DM | B: useful but needs component extraction and reduced-motion | `snippets/ambient-ripple/light.html`, `snippets/ambient-ripple/dark.html` |
| `ai-loading-button` | 蓝紫按钮炫光 | Downloads/动画 Skill/按钮动画 | CTA / AI loading button | loading, attention, AI status | HTML, CSS keyframes | LM, DM | B: strong visual, should be parameterized | `snippets/ai-loading-button/light.html`, `snippets/ai-loading-button/dark.html` |
| `layout-loading-loop` | 三卡片布局加载循环 | Lark Wiki: 一、加载动画 | loading illustration | loading, AI thinking, data layout morphing | HTML, CSS keyframes | built-in light/dark vars | B: high value, complex timeline | `snippets/layout-loading-loop/index.html` |
| `typewriter-ai-input` | 输入框打字机效果 | Codex thread 019e3f8a-233f-7521-b2b3-06c34eee610f final NewTableLandingPromptInput | AI prompt input | feedback, affordance, guided input | HTML, CSS transitions, JS typewriter | single | A/B: reusable input shell, prompts/icons should be replaced | `snippets/typewriter-ai-input/index.html` |
| `create-card-hover` | 新建卡片 hover | Lark Wiki: 二、新建动画 | create/new entry icon | affordance, hover feedback | HTML, CSS transform | single | A: small and easy to adapt | `snippets/create-card-hover/index.html` |
| `upload-card-hover` | 上传卡片 hover | Lark Wiki: 三 上传动画 | upload/import entry icon | affordance, hover feedback | HTML, CSS transform, inline SVG | single | A/B: reusable, icons may need tokenization | `snippets/upload-card-hover/index.html` |
| `create-card-scale-hover` | 新建卡片缩放 hover | Lark Wiki: 五 新建动画 | create/new entry icon | affordance, hover feedback | HTML, CSS transform | single | A: small and easy to adapt | `snippets/create-card-scale-hover/index.html` |

## Excluded

| Item | Reason |
|---|---|
| Lark Wiki: 四 模版入口动画 | User asked to exclude template entry animation. |

## Immediate Gaps

| Gap | Impact | Fix |
|---|---|---|
| No `prefers-reduced-motion` fallback in current snippets | Accessibility risk and noisy infinite motion | Add fallback in each productionized snippet |
| Some snippets include demo page shell | Direct copy may bring unrelated body/background styles | Split into `component.css` + minimal markup |
| `ambient-ripple` uses large blur and mouse-follow JS | Performance risk on low-end devices | Keep subtle by default; pause or simplify on mobile |
| Demo visual validation may need a browser | Skill users may assume Playwright must be installed | Prefer existing Chrome/Chromium or skip visual validation |
