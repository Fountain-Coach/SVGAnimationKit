# SVGAnimationKit

SVGAnimationKit is a small, focused Swift package for describing 2D scenes and timelines and rendering them to SVG. It is designed as a reusable building block for the Fountain Coach ecosystem: FountainKit can depend on it to generate static and animated SVG for instruments (canvas exports, inspectors, web mirrors) without pulling in the full Teatro rendering stack.

The library stays deliberately narrow:

- Scene graph: shapes, groups, text, layers.
- Transforms: 2D transforms plus a thin isometric projection layer for “isometric scenery”.
- Timeline: a minimal animation model for properties such as position, opacity and camera.
- Output: SVG strings or files, with an optional encoding for SVG animation primitives or frame‑by‑frame storyboards.

It does **not** know about MIDI, HTTP, or FountainStore. Instrumentalisation (agent ids, OpenAPI, facts, MIDI 2.0 PE) lives in FountainKit and related services; SVGAnimationKit focuses on rendering and time.

This separation keeps the rendering core portable (usable from any SwiftPM package) while letting FountainKit treat it as a stable “view engine” for instruments that need animated SVG.

