# SVGAnimationKit — Implementation Plan

This plan tracks how SVGAnimationKit evolves from a minimal scene graph into a reusable animated SVG engine for FountainKit instruments.

The goal is to keep the core small and deterministic, while providing enough expressive power to support isometric “scenery” and basic animations (camera moves, tile transitions, fades).

## Phase 1 — Minimal scene graph and SVG output

What
- Define a small, UI‑agnostic scene graph:
  - shapes (rect, circle, path),
  - text,
  - grouping and layers,
  - 2D transforms.
- Provide an API for building scenes in Swift and rendering them to SVG strings/files.

Steps
- Add core types under `Sources/SVGAnimationKit`:
  - `SVGScene`, `SVGNode`, concrete node types (`SVGRect`, `SVGCircle`, `SVGText`, `SVGLayer`).
  - Basic transform support (translate/scale/rotate).
- Implement an `SVGRenderer` that:
  - walks a scene graph,
  - serialises it to well‑formed SVG,
  - exposes `render(scene:) -> String` and `render(scene:to url: URL)`.
- Add unit tests that:
  - build small scenes,
  - assert on key SVG substrings (tag names, attributes),
  - keep output stable enough for diff‑based review.

## Phase 2 — Isometric projection helpers

What
- Introduce a thin isometric layer for “isometric scenery”:
  - projection math from tile/world coordinates to 2D,
  - helpers for grids and tiles.

Steps
- Add an `Iso` namespace or types:
  - `IsoPoint`, `IsoGridConfig`, `IsoProjector`.
  - Projection functions: `(x, y, z) -> (screenX, screenY)`.
- Provide convenience builders:
  - `IsoGridScene(config:)` that produces an `SVGScene` with a grid drawn in isometric projection.
  - `IsoTile` helpers that become positioned rectangles/paths in the scene.
- Tests:
  - assert that known world points project to expected screen coordinates,
  - sanity‑check grid layouts for a few configurations.

## Phase 3 — Timeline / animation model

What
- Add a minimal animation model for properties such as position, opacity, and camera.
- Keep the model generic enough to support both inline SVG animations and frame‑by‑frame rendering.

Steps
- Introduce core types:
  - `AnimationTimeline`, `Keyframe<T>`, `AnimatedProperty`.
  - A simple “from/to over duration” constructor for common cases.
- Attach timelines to scenes or nodes:
  - e.g. `SVGScene.timeline`, `SVGNode.animations`.
- Decide on initial output strategy:
  - Phase 3a: frame‑by‑frame rendering (`renderFrames(scene:timeline:fps:) -> [SVGScene]`).
  - Phase 3b: optional generation of `<animate>` / `<animateTransform>` elements.
- Tests:
  - assert that interpolated values at key times are correct,
  - verify that generated frames or animation tags match expectations.

## Phase 4 — Integration hooks (Teatro & FountainKit)

What
- Make it easy for other packages to feed scenes into SVGAnimationKit without coupling them tightly.

Steps
- Provide helper APIs for:
  - building scenes from higher‑level descriptions (e.g. isometric tile maps),
  - integrating with Teatro (optional convenience layer that maps Teatro views/storyboards into `SVGScene` + `AnimationTimeline`).
- Document expected integration points for FountainKit:
  - which types are stable to depend on,
  - how instruments should treat SVGAnimationKit (as an engine behind an instrument, not as an instrument itself).

## Phase 5 — Polishing and performance

What
- Once initial use‑cases (isometric scenes in FountainKit) are wired up, refine:
  - API ergonomics,
  - performance and allocation behaviour,
  - SVG size/structure.

Steps
- Profile rendering on representative scenes.
- Simplify APIs that turn out to be awkward in real use.
- Add documentation and small examples (`Examples/` directory) showing:
  - a static isometric scene,
  - a simple animated camera pan,
  - a tile fade‑in/out sequence.

