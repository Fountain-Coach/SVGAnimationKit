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
