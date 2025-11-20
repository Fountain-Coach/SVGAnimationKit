import Foundation

/// Describes a 2D scene that can be rendered to SVG.
public struct SVGScene: Sendable {
    public var width: Double
    public var height: Double
    public var background: String?
    public var nodes: [SVGNode]

    public init(width: Double, height: Double, background: String? = nil, nodes: [SVGNode] = []) {
        self.width = width
        self.height = height
        self.background = background
        self.nodes = nodes
    }
}

/// A node in the SVG scene graph.
public enum SVGNode: Sendable {
    case rect(SVGRect)
    case circle(SVGCircle)
    case text(SVGText)
    case group(SVGGroup)
}

/// Axis‑aligned rectangle.
public struct SVGRect: Sendable {
    public var x: Double
    public var y: Double
    public var width: Double
    public var height: Double
    public var fill: String?
    public var stroke: String?
    public var strokeWidth: Double?

    public init(
        x: Double,
        y: Double,
        width: Double,
        height: Double,
        fill: String? = nil,
        stroke: String? = nil,
        strokeWidth: Double? = nil
    ) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.fill = fill
        self.stroke = stroke
        self.strokeWidth = strokeWidth
    }
}

/// Circle primitive.
public struct SVGCircle: Sendable {
    public var cx: Double
    public var cy: Double
    public var r: Double
    public var fill: String?
    public var stroke: String?
    public var strokeWidth: Double?

    public init(
        cx: Double,
        cy: Double,
        r: Double,
        fill: String? = nil,
        stroke: String? = nil,
        strokeWidth: Double? = nil
    ) {
        self.cx = cx
        self.cy = cy
        self.r = r
        self.fill = fill
        self.stroke = stroke
        self.strokeWidth = strokeWidth
    }
}

/// Text primitive.
public struct SVGText: Sendable {
    public var x: Double
    public var y: Double
    public var content: String
    public var fill: String?
    public var fontSize: Double?

    public init(
        x: Double,
        y: Double,
        content: String,
        fill: String? = nil,
        fontSize: Double? = nil
    ) {
        self.x = x
        self.y = y
        self.content = content
        self.fill = fill
        self.fontSize = fontSize
    }
}

/// Group node with optional transform.
public struct SVGGroup: Sendable {
    public var transform: String?
    public var children: [SVGNode]

    public init(transform: String? = nil, children: [SVGNode]) {
        self.transform = transform
        self.children = children
    }
}

/// Renders scenes to SVG strings.
public enum SVGRenderer {
    public static func render(scene: SVGScene) -> String {
        var parts: [String] = []
        let width = scene.width
        let height = scene.height
        parts.append("""
        <svg xmlns="http://www.w3.org/2000/svg" width="\(width)" height="\(height)" viewBox="0 0 \(width) \(height)">
        """)

        if let bg = scene.background {
            parts.append(#"<rect width="100%" height="100%" fill="\#(escapeAttribute(bg))"/> "#)
        }

        for node in scene.nodes {
            parts.append(render(node: node))
        }

        parts.append("</svg>")
        return parts.joined(separator: "\n")
    }

    private static func render(node: SVGNode) -> String {
        switch node {
        case .rect(let r):
            return renderRect(r)
        case .circle(let c):
            return renderCircle(c)
        case .text(let t):
            return renderText(t)
        case .group(let g):
            return renderGroup(g)
        }
    }

    private static func renderRect(_ r: SVGRect) -> String {
        var attrs: [String] = []
        attrs.append(#"x="\#(r.x)""#)
        attrs.append(#"y="\#(r.y)""#)
        attrs.append(#"width="\#(r.width)""#)
        attrs.append(#"height="\#(r.height)""#)
        if let fill = r.fill {
            attrs.append(#"fill="\#(escapeAttribute(fill))""#)
        }
        if let stroke = r.stroke {
            attrs.append(#"stroke="\#(escapeAttribute(stroke))""#)
        }
        if let sw = r.strokeWidth {
            attrs.append(#"stroke-width="\#(sw)""#)
        }
        return "<rect \(attrs.joined(separator: " "))/>"
    }

    private static func renderCircle(_ c: SVGCircle) -> String {
        var attrs: [String] = []
        attrs.append(#"cx="\#(c.cx)""#)
        attrs.append(#"cy="\#(c.cy)""#)
        attrs.append(#"r="\#(c.r)""#)
        if let fill = c.fill {
            attrs.append(#"fill="\#(escapeAttribute(fill))""#)
        }
        if let stroke = c.stroke {
            attrs.append(#"stroke="\#(escapeAttribute(stroke))""#)
        }
        if let sw = c.strokeWidth {
            attrs.append(#"stroke-width="\#(sw)""#)
        }
        return "<circle \(attrs.joined(separator: " "))/>"
    }

    private static func renderText(_ t: SVGText) -> String {
        var attrs: [String] = []
        attrs.append(#"x="\#(t.x)""#)
        attrs.append(#"y="\#(t.y)""#)
        if let fill = t.fill {
            attrs.append(#"fill="\#(escapeAttribute(fill))""#)
        }
        if let size = t.fontSize {
            attrs.append(#"font-size="\#(size)""#)
        }
        let escaped = escapeText(t.content)
        return "<text \(attrs.joined(separator: " "))>\(escaped)</text>"
    }

    private static func renderGroup(_ g: SVGGroup) -> String {
        var attrs: [String] = []
        if let transform = g.transform {
            attrs.append(#"transform="\#(escapeAttribute(transform))""#)
        }
        let header = attrs.isEmpty ? "<g>" : "<g \(attrs.joined(separator: " "))>"
        var out: [String] = [header]
        for child in g.children {
            out.append(render(node: child))
        }
        out.append("</g>")
        return out.joined(separator: "\n")
    }

    private static func escapeAttribute(_ s: String) -> String {
        s.replacingOccurrences(of: "\"", with: "&quot;")
    }

    private static func escapeText(_ s: String) -> String {
        var out = s
        out = out.replacingOccurrences(of: "&", with: "&amp;")
        out = out.replacingOccurrences(of: "<", with: "&lt;")
        out = out.replacingOccurrences(of: ">", with: "&gt;")
        return out
    }
}
