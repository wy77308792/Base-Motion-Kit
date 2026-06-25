# Animation Decision Matrix

Use semantic intent first, keyword match second. Ask clarification only when both target surface and intent are missing.

## Routing

| User wording | Intent | Surface | Default snippet | Ask? |
|---|---|---|---|---|
| 背景、氛围、呼吸、涟漪、鼠标跟随、高级感 | ambient | background / overlay | `ambient-ripple` | No, unless target page area is unclear |
| AI loading、生成中、按钮等待、按钮炫光、蓝紫光 | loading / attention | button | `ai-loading-button` | No |
| 加载动画、AI 思考、数据块流转、布局变化 | loading / thinking | illustration | `layout-loading-loop` | No |
| 新建按钮、新建入口、创建入口、加号卡片 | affordance | icon / card entry | `create-card-scale-hover` | No |
| 上传、导入、文件入口 | affordance | icon / card entry | `upload-card-hover` | No |
| hover、悬停反馈、微交互 | affordance | unknown | pick by noun: create -> `create-card-scale-hover`, upload -> `upload-card-hover` | Ask if noun missing |
| 加点动画、动起来、高级一点 | unknown | unknown | none | Ask target element and desired feeling |

## Selection Rules

1. Identify `intent`: ambient, loading, affordance, feedback, layout-transition.
2. Identify `surface`: background, overlay, button, entry-card, illustration.
3. Pick the least intense snippet that satisfies the intent.
4. Prefer A-level snippets for direct copy; use B-level snippets as visual source and extract first.
5. Always add `prefers-reduced-motion`.
6. If the user has not specified light/dark mode, provide both when the snippet has both.
7. For `ambient-ripple`, always adapt it into a parent-container-fill implementation before use; never ship the fixed-size demo dimensions.

## Default Intensity

| Context | Intensity | Notes |
|---|---|---|
| Workbench / dense product UI | subtle | Keep hover and loading short; avoid continuous large motion |
| Empty state / onboarding / AI generation | medium | Ambient or illustration loops are acceptable |
| Marketing / demo page | expressive | Button glow and large background motion are acceptable |
