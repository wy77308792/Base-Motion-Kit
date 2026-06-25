---
name: base-motion-kit
description: Use when the user asks to add, choose, reuse, or adapt UI animations from Base Motion Kit, including background breathing/ripple effects, AI loading buttons, loading illustrations, input typewriter placeholders, create/upload entry hover interactions, or when the user wants animation snippets selected by scenario.
---

# Base Motion Kit

This skill routes animation requests to the local snippet library under `snippets/`.

## Update Check Rule

Before the first substantive use each day, run the update checker from this skill directory:

```bash
bash scripts/check-update.sh
```

Behavior:

- If it prints `BASE_MOTION_KIT_UPDATE_OK` or `BASE_MOTION_KIT_UPDATE_SKIP`, continue normally.
- If it prints `BASE_MOTION_KIT_UPDATE_AVAILABLE`, tell the user there is a newer Base Motion Kit version and show the printed `git pull --ff-only` command. Do not auto-update unless the user asks.
- If it prints `BASE_MOTION_KIT_UPDATE_WARN` or `BASE_MOTION_KIT_UPDATE_DIVERGED`, continue with the local version and briefly report the warning.
- The check is cached per local checkout per day under `~/.cache/base-motion-kit/`.

## Workflow

1. Identify intent: `ambient`, `loading`, `affordance`, `feedback`, `layout-transition`.
2. Identify surface: `background`, `overlay`, `button`, `input`, `entry-card`, `illustration`.
3. If the user only asks for "add animation", "make it richer", "make it feel premium", or similar without naming a motion type or target surface, run the clarification step before reading snippets.
4. Read `references/decision-matrix.md` to choose a snippet.
5. Read the selected entry in `references/pattern-catalog.md`.
6. Copy or adapt only the selected snippet. Do not scan the whole library unless the user asks for discovery.
7. Add `prefers-reduced-motion` before production use.
8. When adding, renaming, or removing a snippet, update `snippets/gallery.html` in the same change.

## Dependency Rule

- Do not install Playwright, browser packages, animation libraries, or asset packages by default.
- Visual validation is optional. If validation is needed, prefer an existing system Chrome/Chromium or the user's existing project tooling.
- If no browser/runtime is available, state that visual validation was skipped instead of adding new dependencies.
- Snippets must not depend on bundled image/video assets. Use inline CSS/SVG or the consumer project's own assets.

## `ambient-ripple` Container Rule

When using `ambient-ripple`, do not copy the fixed-size demo directly into a product page. Treat `light.html` / `dark.html` as visual references and extract a container-fill component:

- The consumer provides a parent container with explicit size from layout, `height`, or `aspect-ratio`.
- The animation root must use `position: absolute; inset: 0; width: 100%; height: 100%; overflow: hidden`.
- Canvas and SVG mask must read the current container size, not hard-coded demo dimensions.
- Use `ResizeObserver` or equivalent resize handling so dragging/resizing the container recalculates canvas size, mask bounds, ripple center, and dot grid.
- Preserve the original visual recipe: blob colors, blur style, mask ripple, edge breathing, and dot matrix. Do not add mouse-follow layers or new visual layers unless the user asks for a visual redesign.
- If the target environment cannot run JS, fallback to a static full-container gradient with reduced motion.

## Defaults

| Request | Snippet |
|---|---|
| 背景呼吸 / 涟漪 / 氛围 | `ambient-ripple` |
| AI loading button / 按钮炫光 | `ai-loading-button` |
| 页面加载或页面生成动效 | `layout-loading-loop` |
| 输入框打字机 / placeholder 动效 / AI 输入框 | `typewriter-ai-input` |
| 上传入口 / 导入入口 | `upload-card-hover` |

## Clarification

If the user has not clearly specified what animation to add, ask them to choose from the current library before implementing.

Requirements for the clarification response:

- Always show all 5 options below, including each option name and use case.
- Before responding, make sure the gallery is served from the repo root. Reuse an existing server if `http://127.0.0.1:8765/snippets/gallery.html` is reachable; otherwise start a local static server from `/Users/bytedance/Documents/Base-Motion-Kit` on port `8765`.
- Put the clickable rendered preview link in the clarification title sentence, without repeating the same words before the link: `你可以 [预览效果](http://127.0.0.1:8765/snippets/gallery.html) 然后选择：`.
- Tell the user to open the preview page, then reply with the option number.
- Do not rely on native clickable choice cards; use the complete numbered list plus the gallery link as the stable interaction.

```text
你需要增加什么动画效果？你可以 [预览效果](http://127.0.0.1:8765/snippets/gallery.html) 然后选择：
1. 背景呼吸/涟漪氛围：适合页面背景或局部背景容器
2. AI loading button/按钮炫光：适合生成、提交、等待状态按钮
3. 页面加载或页面生成动效：适合页面、模块或数据块加载/生成中
4. 输入框打字机效果：适合 AI 输入框、提示词输入和 placeholder 示例轮播
5. 上传/导入卡片按钮 hover 效果：适合上传文件、导入数据入口

请先打开预览链接查看效果，再回复编号；也可以补充目标元素和 light/dark 模式。
```

Do not ask if either the target surface or animation intent maps clearly to the decision matrix. In that case, pick the closest subtle animation and state the assumption.

## Gallery Rule

Use `http://127.0.0.1:8765/snippets/gallery.html` as the stable rendered preview surface for clarification. Do not generate an ad hoc preview page during clarification unless the user asks for a custom preview.

For vague requests, never output a shortened menu. The response must include the complete 5-option clarification menu, and the clickable rendered gallery link must appear in the title sentence before the option list. Do not output a `file://` path as the main preview link. Do not promise native clickable cards because Codex/Claude skill text cannot reliably control client UI widgets.

If `http://127.0.0.1:8765/snippets/gallery.html` is not reachable, start or reload the persistent LaunchAgent below. Serve the installed skill directory because macOS may block background services from reading `Documents`:

```bash
launchctl bootout gui/$(id -u) /Users/bytedance/Library/LaunchAgents/com.base-motion-kit.gallery.plist 2>/dev/null || true
launchctl bootstrap gui/$(id -u) /Users/bytedance/Library/LaunchAgents/com.base-motion-kit.gallery.plist
launchctl kickstart -k gui/$(id -u)/com.base-motion-kit.gallery
```

If the LaunchAgent plist is missing, create it at `/Users/bytedance/Library/LaunchAgents/com.base-motion-kit.gallery.plist` with `ProgramArguments` equivalent to:

```bash
/usr/bin/python3 -u -m http.server 8765 --bind 127.0.0.1 --directory /Users/bytedance/.codex/skills/base-motion-kit
```

When adding, renaming, or removing any motion option:

- update the clarification menu
- update `references/decision-matrix.md`
- update `snippets/gallery.html`
