# Pattern Catalog

## `ambient-ripple`

- Intent: ambient background, page focus, premium AI feel.
- Use when: page needs soft breathing background or masked ripple around content.
- Avoid when: dense table/list workbench, low-end mobile, battery-sensitive contexts.
- Current implementation: CSS blob keyframes, SVG mask, JS mouse tracking.
- Production notes: use LM/DM files as visual references, not direct product code. Extract a container-fill component that fills the parent with `position:absolute; inset:0; width:100%; height:100%`, recalculates canvas/SVG mask/mouse coordinates from the current container via `ResizeObserver`, removes fixed demo dimensions and Tailwind CDN, exposes colors/speed/blur/opacity as params, and adds reduced-motion fallback. Preserve the original visual recipe; do not add new ring or ripple layers during adaptation.
- Source files: `snippets/ambient-ripple/light.html`, `snippets/ambient-ripple/dark.html`.

## `ai-loading-button`

- Intent: make an AI/primary button feel active while loading.
- Use when: submit/generate button enters waiting state.
- Avoid when: button is one of many repeated row actions.
- Current implementation: rotating gradient border, glow layer, shine sweep.
- Production notes: make `loading`, `disabled`, `label`, `tone`, `theme` configurable; avoid running animation when not loading.
- Source files: `snippets/ai-loading-button/light.html`, `snippets/ai-loading-button/dark.html`.

## `layout-loading-loop`

- Intent: communicate AI/data layout processing with a deterministic looping illustration.
- Use when: page/card/module is loading or AI is reorganizing content.
- Avoid when: loading lasts under 500ms or appears in many repeated cells.
- Current implementation: 11s CSS timeline, 3 morphing cards, line sweep, icon pop.
- Production notes: split timeline CSS from demo shell; expose theme tokens; add static end-state for reduced motion.
- Source file: `snippets/layout-loading-loop/index.html`.

## `create-card-hover`

- Intent: lightweight hover affordance for create/new entry.
- Use when: entry card or icon has a visible hover state.
- Avoid when: element already has strong hover styling.
- Current implementation: 150ms transform scale, subtle shadow.
- Production notes: direct copy candidate; replace inline icon and colors with app tokens.
- Source file: `snippets/create-card-hover/index.html`.

## `upload-card-hover`

- Intent: lightweight hover affordance for upload/import entry.
- Use when: upload/import action needs discoverable tactile feedback.
- Avoid when: upload is a destructive or high-risk action requiring calm confirmation.
- Current implementation: 200ms transform transitions, stacked icon cards.
- Production notes: direct copy candidate after replacing SVG icons with product icons.
- Source file: `snippets/upload-card-hover/index.html`.

## `create-card-scale-hover`

- Intent: refined create/new hover with restrained scale.
- Use when: create entry needs a compact polished interaction.
- Avoid when: layout cannot tolerate visual overflow.
- Current implementation: default scale 0.9, hover scale 0.96, icon scale 1.133, 150ms transition.
- Production notes: best default for new-entry affordance because it is smaller and easier to control than `create-card-hover`.
- Source file: `snippets/create-card-scale-hover/index.html`.
