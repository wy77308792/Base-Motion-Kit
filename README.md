# Base Motion Kit

Reusable UI animation snippets and an agent skill for choosing the right motion pattern.

## Contents

| Pattern | Use case | Path |
|---|---|---|
| `ambient-ripple` | breathing background / ambient ripple | `snippets/ambient-ripple/` |
| `ai-loading-button` | AI loading / glowing CTA button | `snippets/ai-loading-button/` |
| `layout-loading-loop` | AI thinking / layout loading illustration | `snippets/layout-loading-loop/` |
| `create-card-hover` | create-entry hover micro-interaction | `snippets/create-card-hover/` |
| `create-card-scale-hover` | compact create-entry hover micro-interaction | `snippets/create-card-scale-hover/` |
| `upload-card-hover` | upload/import hover micro-interaction | `snippets/upload-card-hover/` |

## How to Use

Clone the repository and copy only the selected snippet:

```bash
git clone https://github.com/wy77308792/Base-Motion-Kit.git
cp -R Base-Motion-Kit/snippets/create-card-scale-hover ./src/components/
```

For agent-driven usage, install or reference `animation-skill/SKILL.md`; it routes requests through `references/decision-matrix.md` and `references/pattern-catalog.md`.

## Asset Policy

Image/video preview assets are intentionally excluded to keep the repository and future package small. The snippets contain code references only; replace demo image backgrounds with project-owned assets when integrating.

## Ambient Ripple Rule

`ambient-ripple` source files are visual references. When integrating into a product, adapt it into a parent-container-fill component:

- parent provides explicit size from layout, `height`, or `aspect-ratio`
- animation root uses `position: absolute; inset: 0; width: 100%; height: 100%; overflow: hidden`
- canvas, SVG mask, mouse coordinates, ripple center, and dot grid are recalculated from the current container size
- preserve the original visual recipe; do not add new ring or ripple layers unless redesigning the effect

