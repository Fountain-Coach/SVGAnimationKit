# SVGAnimationKit — Implementation Plan

This plan tracks how SVGAnimationKit evolves from a minimal scene graph into a reusable animated SVG engine for FountainKit instruments.

The goal is to keep the core small and deterministic, while providing enough expressive power to support isometric “scenery” and basic animations (camera moves, tile transitions, fades).

## Phase 1 — Minimal scene graph and SVG output (MVP)

What
- Define a small, UI‑agnostic scene graph:
  - core shapes (rect, circle, text),
  - grouping and layers,
  - a clear path to richer shapes (paths, lines, polygons) in later phases.
- Provide an API for building scenes in Swift and rendering them to SVG strings/files.

Steps
- Add core types under `Sources/SVGAnimationKit`:
  - `SVGScene`, `SVGNode`, concrete node types (`SVGRect`, `SVGCircle`, `SVGText`, `SVGGroup`).
  - (Later) basic transform helpers (translate/scale/rotate) as the scene graph grows.
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

## Phase 3 — Timeline / animation model (1D)

What
- Add a minimal animation model for properties such as position, opacity, and camera.
- Keep the model generic enough to support both inline SVG animations and frame‑by‑frame rendering.

Steps
- Introduce core types:
  - `Keyframe1D`, `AnimationCurve1D`, `AnimationTimeline1D` for scalar properties.
  - A simple “from/to over duration” constructor for common cases.
- Provide two consumption paths:
  - frame‑by‑frame rendering (`AnimationFrames.renderScenes`) that produces a sequence of `SVGScene` instances, to be turned into SVG frames;
  - helpers to encode curves into SVG animation attributes (`SVGAnimationEncoding.encode` → `values`, `keyTimes`, `duration`) for `<animate>` / `<animateTransform>`.
- Leave the attachment of timelines to concrete nodes or scenes to higher‑level packages, so the core stays transport‑agnostic.
- Tests:
  - assert that interpolated values at key times are correct,
  - verify that generated frames and encoded animation attributes match expectations.

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

## Phase 6 — Broader SVG coverage and raw elements

What
- Extend SVGAnimationKit toward “full SVG” in a pragmatic way:
  - provide strong, focused types for the shapes and constructs we use most,
  - while offering a safe escape hatch for the rest of the SVG spec.

Steps
- Add additional primitives as needed by real callers:
  - lines, polygons, and a minimally ergonomic `SVGPath` representation.
  - attributes for opacity, z‑ordering helpers (layering), and basic style objects.
- Introduce support for common defs:
  - gradients, clip paths, masks, and symbols, where they materially improve instrument rendering.
- Add a generic, well‑documented `SVGRawElement` / `SVGNode.raw` case:
  - lets callers embed arbitrary SVG snippets (unknown elements/attributes) when they need features not yet wrapped by the core API.
  - keeps the library forward‑compatible with the full SVG spec without bloating the type system prematurely.
- Back these additions with snapshot‑style tests:
  - ensure that complex scenes render to stable SVG,
  - make it easy to review and reason about more advanced SVG constructs over time.

