# AGENT — SVGAnimationKit (Fountain Coach)

This repository hosts **SVGAnimationKit**, a small SwiftPM library for constructing 2D scenes + timelines and rendering them to SVG. It is part of the Fountain Coach toolchain and is designed to be consumed by FountainKit and other packages as a pure rendering core — no MIDI, no HTTP, no FountainStore.

## Position in the ecosystem

- Teatro: full rendering engine (Fountain parser, stage semantics, SVG/HTML/PNG, MIDI, GUI).
- FountainKit: workspace of services and apps that orchestrate agents, instruments and MIDI 2.0 hosts.
- SVGAnimationKit: a focused “SVG + time” module that:
  - accepts scene + animation descriptions from clients (including Teatro),
  - emits static or animated SVG,
  - exposes a stable API for instrument surfaces that need isometric or animated views.

FountainKit owns **instrumentalisation** (agent ids, OpenAPI, facts, MIDI 2.0 PE). SVGAnimationKit remains transport‑agnostic and does not depend on MIDI or FountainStore.

## Implementation guidelines

- Keep the core small and deterministic:
  - Scene graph + transforms in pure Swift.
  - SVG encoding with no side effects beyond string/file writing.
  - No GUI frameworks, no SDL, no AppKit/SwiftUI.
- Dependencies:
  - Prefer Foundation only; avoid external dependencies unless they are clearly justified and small.
  - This package should be safe to use from server‑side code and tools.
- Isometric support:
  - Provide a minimal isometric projection layer (world → screen) and convenience types for isometric grids and tiles.
  - Keep the isometric math UI‑agnostic so it can be reused by different hosts.
- Animation model:
  - Start with simple property animations (position, opacity, camera).
  - Design the API so it can target both:
    - inline SVG animation primitives, and
    - frame‑by‑frame rendering (storyboards) for hosts that prefer discrete frames.

## Planning and evolution

- The high‑level plan for this library lives in `implementation_plan.md` at the repo root.
  - Keep that file current; update it in the same PR as any structural change.
  - The plan should describe phases (MVP scene graph, isometric helpers, animation encoding, integration with Teatro/FountainKit) and call out open questions.
- Use small, focused branches/PRs:
  - One concept per change (e.g. “add isometric projection”, “add timeline API”, “encode SVG animations”).
  - Keep public API surface stable; document any breaking changes explicitly.

## Coding standards

- Swift 6.1, SwiftPM only.
- No global mutable state; prefer value types and pure functions in the core.
- Avoid premature generalisation: optimise for the isometric/animated use cases we know we need (Infinity, instrument inspectors), then generalise when real callers appear.

