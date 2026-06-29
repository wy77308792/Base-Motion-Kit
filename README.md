# Base Motion Kit

Reusable UI animation snippets and an installable Codex skill for choosing the right motion pattern.

## Contents

| Pattern | Use case | Path |
|---|---|---|
| `ambient-ripple` | breathing background / ambient ripple | `snippets/ambient-ripple/` |
| `thinking-text-shimmer` | AI thinking text shimmer | `snippets/thinking-text-shimmer/` |
| `layout-loading-loop` | AI thinking / layout loading illustration | `snippets/layout-loading-loop/` |
| `typewriter-ai-input` | AI input placeholder typewriter and suggestion dropdown | `snippets/typewriter-ai-input/` |
| `particle-input-ambient` | ambient particle background for an existing AI input/card | `snippets/particle-input-ambient/` |
| `create-card-hover` | create-entry hover micro-interaction | `snippets/create-card-hover/` |
| `create-card-scale-hover` | compact create-entry hover micro-interaction | `snippets/create-card-scale-hover/` |
| `upload-card-hover` | upload/import hover micro-interaction | `snippets/upload-card-hover/` |

## Install as a Codex Skill

Install the repository into the local Codex skills directory:

```bash
git clone https://github.com/wy77308792/Base-Motion-Kit.git ~/.codex/skills/base-motion-kit
```

Restart Codex after installing. Then invoke it explicitly:

```text
/base-motion-kit 给背景加呼吸涟漪动画
/base-motion-kit 给 AI 正在思考中的文字加扫光效果
/base-motion-kit 给页面生成过程加加载动效
/base-motion-kit 给输入框加颜色弥散和跟手星光背景
```

The skill entrypoint is `SKILL.md`; it routes requests through `references/decision-matrix.md` and `references/pattern-catalog.md`.

## Public Preview

Open the rendered gallery:

https://wy77308792.github.io/Base-Motion-Kit/snippets/gallery.html

## Update Check

The skill includes a daily update checker. Agents should run it before the first substantive use each day:

```bash
cd ~/.codex/skills/base-motion-kit
bash scripts/check-update.sh
```

If a newer remote version exists, the script prints the exact `git pull --ff-only` command to run. It does not auto-update the skill unless the user asks.

## Use Snippets Directly

Clone the repository and copy only the selected snippet:

```bash
git clone https://github.com/wy77308792/Base-Motion-Kit.git
cp -R Base-Motion-Kit/snippets/create-card-scale-hover ./src/components/
```

## Asset Policy

Image/video preview assets are intentionally excluded to keep the repository and future package small. Snippets must not reference bundled image/video files; use inline CSS/SVG or replace with project-owned assets when integrating.

## Dependency Policy

The skill does not require runtime dependencies. Do not install Playwright, browser packages, or animation libraries by default; use the target project's existing tooling for validation.

## Ambient Ripple Rule

`ambient-ripple` source files are visual references. When integrating into a product, adapt it into a parent-container-fill component:

- parent provides explicit size from layout, `height`, or `aspect-ratio`
- animation root uses `position: absolute; inset: 0; width: 100%; height: 100%; overflow: hidden`
- canvas, SVG mask, mouse coordinates, ripple center, and dot grid are recalculated from the current container size
- preserve the original visual recipe; do not add new ring or ripple layers unless redesigning the effect
