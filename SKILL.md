---
name: base-motion-kit
description: Use when the user asks to add, choose, reuse, or adapt UI animations from Base Motion Kit, including background breathing/ripple effects, AI loading buttons, loading illustrations, create/upload entry hover interactions, or when the user wants animation snippets selected by scenario.
---

# Base Motion Kit

This skill routes animation requests to the local snippet library under `snippets/`.

## Workflow

1. Identify intent: `ambient`, `loading`, `affordance`, `feedback`, `layout-transition`.
2. Identify surface: `background`, `overlay`, `button`, `entry-card`, `illustration`.
3. Read `references/decision-matrix.md` to choose a snippet.
4. Read the selected entry in `references/pattern-catalog.md`.
5. Copy or adapt only the selected snippet. Do not scan the whole library unless the user asks for discovery.
6. Add `prefers-reduced-motion` before production use.

## Dependency Rule

- Do not install Playwright, browser packages, animation libraries, or asset packages by default.
- Visual validation is optional. If validation is needed, prefer an existing system Chrome/Chromium or the user's existing project tooling.
- If no browser/runtime is available, state that visual validation was skipped instead of adding new dependencies.
- Snippets must not depend on bundled image/video assets. Use inline CSS/SVG or the consumer project's own assets.

## `ambient-ripple` Container Rule

When using `ambient-ripple`, do not copy the fixed-size demo directly into a product page. Treat `light.html` / `dark.html` as visual references and extract a container-fill component:

- The consumer provides a parent container with explicit size from layout, `height`, or `aspect-ratio`.
- The animation root must use `position: absolute; inset: 0; width: 100%; height: 100%; overflow: hidden`.
- Canvas, SVG mask, and mouse coordinates must read the current container size, not hard-coded demo dimensions.
- Use `ResizeObserver` or equivalent resize handling so dragging/resizing the container recalculates canvas size, mask bounds, ripple center, and dot grid.
- Preserve the original visual recipe: blob colors, blur style, mask ripple, mouse trail, and dot matrix. Do not add new visual layers unless the user asks for a visual redesign.
- If the target environment cannot run JS, fallback to a static full-container gradient with reduced motion.

## Defaults

| Request | Snippet |
|---|---|
| 背景呼吸 / 涟漪 / 氛围 | `ambient-ripple` |
| AI loading button / 按钮炫光 | `ai-loading-button` |
| 加载动画 / AI 思考 / 数据块流转 | `layout-loading-loop` |
| 新建入口 / 加号卡片 | `create-card-scale-hover` |
| 上传入口 / 导入入口 | `upload-card-hover` |

## Clarification

Ask one short question only when both are missing:

- target element
- animation intent

If one is clear, pick the closest subtle animation and state the assumption.
