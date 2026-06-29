# Animation Decision Matrix

Use semantic intent first, keyword match second. When neither target surface nor motion intent is clear, show the clarification menu instead of choosing a default.

## Clarification Menu

Use this menu when the request is vague, for example: "加点动画", "动起来", "高级一点", "更有呼吸感但没说加在哪", or "帮我加个动效".

Requirements:

- Always show all 6 options below, including each option name and use case.
- Use the public rendered gallery link by default: `https://wy77308792.github.io/Base-Motion-Kit/snippets/gallery.html`.
- Put the clickable rendered preview link in the clarification title sentence, without repeating the same words before the link: `你可以 [预览效果](https://wy77308792.github.io/Base-Motion-Kit/snippets/gallery.html) 然后选择：`.
- Tell the user to open the preview page, then reply with the option number.
- Do not rely on native clickable choice cards; use the complete numbered list plus the gallery link as the stable interaction.

Only use the local gallery URL for local development or unpublished changes: `http://127.0.0.1:8765/snippets/gallery.html`. If the local URL is needed but not reachable, start or reload the persistent LaunchAgent. Serve the installed skill directory because macOS may block background services from reading `Documents`:

```bash
launchctl bootout gui/$(id -u) /Users/bytedance/Library/LaunchAgents/com.base-motion-kit.gallery.plist 2>/dev/null || true
launchctl bootstrap gui/$(id -u) /Users/bytedance/Library/LaunchAgents/com.base-motion-kit.gallery.plist
launchctl kickstart -k gui/$(id -u)/com.base-motion-kit.gallery
```

```text
你需要增加什么动画效果？你可以 [预览效果](https://wy77308792.github.io/Base-Motion-Kit/snippets/gallery.html) 然后选择：
1. 背景呼吸/涟漪氛围：适合页面背景或局部背景容器
2. 文字扫光思考动效：适合 AI 思考中、生成中状态文字
3. 输入框后弥散点阵动效：适合输入框后方、卡片后方使用
4. 页面加载或页面生成动效：适合页面、模块或数据块加载/生成中
5. 输入框打字机效果：适合 AI 输入框、提示词输入和 placeholder 示例轮播
6. 上传/导入卡片按钮 hover 效果：适合上传文件、导入数据入口

请先打开预览链接查看效果，再回复编号；也可以补充目标元素和 light/dark 模式。
```

## Routing

| User wording | Intent | Surface | Default snippet | Ask? |
|---|---|---|---|---|
| 背景、氛围、呼吸、涟漪、鼠标跟随、高级感 | ambient | background / overlay | `ambient-ripple` | No, unless target page area is unclear |
| 文字扫光、扫光文字、AI 正在思考中、思考中、生成中文字、流光文字 | loading / thinking | text | `thinking-text-shimmer` | No |
| 页面加载或页面生成动效、文档第一个加载动画、加载动画、AI 思考、数据块流转、布局变化 | loading / thinking | illustration | `layout-loading-loop` | No |
| 输入框、AI 输入框、placeholder、打字机、输入提示、提示词轮播 | feedback / affordance | input | `typewriter-ai-input` | No |
| 输入框后弥散点阵、输入框背景、输入框背后、卡片后方、粒子背景、颜色弥散、星光、跟手、鼠标跟随输入框 | ambient / feedback | input/card background | `particle-input-ambient` | Ask only if target element is unclear |
| 上传/导入卡片按钮 hover 效果、上传、导入、文件入口 | affordance | icon / card entry | `upload-card-hover` | No |
| hover、悬停反馈、微交互 | affordance | unknown | pick by noun: upload/import -> `upload-card-hover` | Ask if noun missing |
| 加点动画、动起来、高级一点、帮我加个动效 | unknown | unknown | none | Show clarification menu |

## Selection Rules

1. Identify `intent`: ambient, loading, affordance, feedback, layout-transition.
2. Identify `surface`: background, overlay, button, entry-card, illustration.
3. Pick the least intense snippet that satisfies the intent.
4. Prefer A-level snippets for direct copy; use B-level snippets as visual source and extract first.
5. Always add `prefers-reduced-motion`.
6. If the user has not specified light/dark mode, provide both when the snippet has both.
7. For `ambient-ripple`, always adapt it into a parent-container-fill implementation before use; never ship the fixed-size demo dimensions.
8. For `particle-input-ambient`, attach only the background layer behind an existing card/input/container. If the target is not explicit, list likely target elements from the page/code and ask the user to choose before implementation.

## Default Intensity

| Context | Intensity | Notes |
|---|---|---|
| Workbench / dense product UI | subtle | Keep hover and loading short; avoid continuous large motion |
| Empty state / onboarding / AI generation | medium | Ambient or illustration loops are acceptable |
| Marketing / demo page | expressive | Button glow and large background motion are acceptable |
