import Testing
@testable import SVGAnimationKit

@Test
func rendersSimpleSceneToSVG() {
    let rect = SVGNode.rect(.init(x: 10, y: 20, width: 100, height: 50, fill: "#ff0000"))
    let text = SVGNode.text(.init(x: 16, y: 40, content: "Hello", fill: "#ffffff", fontSize: 14))
    let scene = SVGScene(width: 200, height: 100, background: "#000000", nodes: [rect, text])

    let svg = SVGRenderer.render(scene: scene)

    #expect(svg.contains("<svg"))
    #expect(svg.contains("width=\"200.0\""))
    #expect(svg.contains("height=\"100.0\""))
    #expect(svg.contains("<rect"))
    #expect(svg.contains("fill=\"#ff0000\""))
    #expect(svg.contains("<text"))
    #expect(svg.contains(">Hello</text>"))
}

@Test
func isoProjectorProducesExpectedCoordinates() {
    let projector = IsoProjector(
        tileWidth: 40,
        tileHeight: 20,
        originX: 100,
        originY: 50
    )

    // Origin tile centered at originX/originY
    let (x0, y0) = projector.project(x: 0, y: 0)
    #expect(x0 == 100)
    #expect(y0 == 50)

    // Moving one step in +x should move right and down
    let (x1, y1) = projector.project(x: 1, y: 0)
    #expect(x1 == 120)
    #expect(y1 == 60)

    // Moving one step in +y should move left and down symmetrically
    let (x2, y2) = projector.project(x: 0, y: 1)
    #expect(x2 == 80)
    #expect(y2 == 60)

    // Elevation should move the tile upward visually
    let (_, yElevated) = projector.project(x: 0, y: 0, z: 1)
    #expect(yElevated == 30)
}

@Test
func isoGridBuilderCreatesExpectedTileCount() {
    let config = IsoGridConfig(
        columns: 3,
        rows: 2,
        tileWidth: 40,
        tileHeight: 20,
        originX: 100,
        originY: 50
    )
    let nodes = IsoGridBuilder.makeGridNodes(config: config, fill: nil)
    #expect(nodes.count == config.rows * config.columns)
}

@Test
func animationCurveInterpolatesLinearly() {
    let curve = AnimationCurve1D(
        keyframes: [
            .init(time: 0.0, value: 0.0),
            .init(time: 1.0, value: 10.0)
        ]
    )

    // Before first keyframe → clamp
    #expect(curve.value(at: -0.5) == 0.0)

    // At keyframes
    #expect(curve.value(at: 0.0) == 0.0)
    #expect(curve.value(at: 1.0) == 10.0)

    // Midpoint should be halfway
    #expect(curve.value(at: 0.5) == 5.0)

    // After last keyframe → clamp
    #expect(curve.value(at: 2.0) == 10.0)

    let timeline = AnimationTimeline1D(duration: 1.0, tracks: ["alpha": curve])
    let sampled = timeline.sample(at: 0.5)
    #expect(sampled["alpha"] == 5.0)
}
