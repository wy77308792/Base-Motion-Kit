# Pattern Catalog

## `ambient-ripple`

- Intent: ambient background, page focus, premium AI feel.
- Use when: page needs soft breathing background or masked ripple around content.
- Avoid when: dense table/list workbench, low-end mobile, battery-sensitive contexts.
- Current implementation: CSS blob keyframes, SVG mask, center ripple, edge breathing, dot matrix.
- Production notes: use LM/DM files as visual references, not direct product code. Extract a container-fill component that fills the parent with `position:absolute; inset:0; width:100%; height:100%`, recalculates canvas/SVG mask from the current container via `ResizeObserver`, removes fixed demo dimensions, exposes colors/speed/blur/opacity as params, and adds reduced-motion fallback. Preserve the original visual recipe; do not add mouse-follow, new ring, or new ripple layers during adaptation.
- Source files: `snippets/ambient-ripple/light.html`, `snippets/ambient-ripple/dark.html`.

## Shared Integration Rules

- Do not add Playwright, browser packages, animation libraries, or image asset packages unless the target project already requires them.
- Do not reference bundled image/video assets from this kit. The snippets are code-only and should use inline CSS/SVG or the consumer project's own assets.

## `layout-loading-loop`

- Intent: communicate AI/data layout processing with a deterministic looping illustration.
- Use when: page/card/module is loading or AI is reorganizing content.
- Avoid when: loading lasts under 500ms or appears in many repeated cells.
- Current implementation: 11s CSS timeline, 3 morphing cards, line sweep, icon pop.
- Production notes: split timeline CSS from demo shell; expose theme tokens; add static end-state for reduced motion.
- Source file: `snippets/layout-loading-loop/index.html`.

## `typewriter-ai-input`

- Intent: make an AI input feel guided with rotating typewriter placeholder examples.
- Use when: an AI prompt input needs subtle example suggestions plus clickable suggestion fill-in.
- Avoid when: the field is a normal static form input, repeated in table cells, or the placeholder must remain stable for accessibility.
- Current implementation: textarea typewriter placeholder, focus-triggered suggestion dropdown, suggestion hover preview, suggestion click fill, auto height, send-button active state.
- Production notes: copy only the input card and its local script; keep the consumer layout outside this snippet. Preserve focus/dropdown/hover/click behavior, replace demo prompts/icons with product content, and use a static placeholder under reduced motion.
- Source file: `snippets/typewriter-ai-input/index.html`.

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
