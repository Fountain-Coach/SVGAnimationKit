import Foundation

/// Discrete grid configuration for an isometric floor.
public struct IsoGridConfig: Sendable {
    public var columns: Int
    public var rows: Int
    public var tileWidth: Double
    public var tileHeight: Double
    public var originX: Double
    public var originY: Double

    public init(
        columns: Int,
        rows: Int,
        tileWidth: Double,
        tileHeight: Double,
        originX: Double,
        originY: Double
    ) {
        self.columns = columns
        self.rows = rows
        self.tileWidth = tileWidth
        self.tileHeight = tileHeight
        self.originX = originX
        self.originY = originY
    }
}

/// Projects grid coordinates into screen coordinates for an isometric floor.
public struct IsoProjector: Sendable {
    public var tileWidth: Double
    public var tileHeight: Double
    public var originX: Double
    public var originY: Double

    public init(
        tileWidth: Double,
        tileHeight: Double,
        originX: Double,
        originY: Double
    ) {
        self.tileWidth = tileWidth
        self.tileHeight = tileHeight
        self.originX = originX
        self.originY = originY
    }

    /// Project grid coordinates `(x, y)` (with optional elevation `z`) into screen space.
    /// `x` and `y` are tile indices; `z` is elevation in tile units.
    public func project(x: Double, y: Double, z: Double = 0) -> (Double, Double) {
        let halfW = tileWidth / 2.0
        let halfH = tileHeight / 2.0
        let screenX = originX + (x - y) * halfW
        let screenY = originY + (x + y) * halfH - z * tileHeight
        return (screenX, screenY)
    }
}

/// Convenience helpers for building isometric grid scenes.
public enum IsoGridBuilder {
    /// Build a simple isometric floor grid as a list of rectangle nodes.
    /// Each tile becomes an axis‑aligned rectangle positioned using the isometric projection.
    public static func makeGridNodes(
        config: IsoGridConfig,
        fill: String? = nil,
        stroke: String = "#444444",
        strokeWidth: Double = 1.0
    ) -> [SVGNode] {
        let projector = IsoProjector(
            tileWidth: config.tileWidth,
            tileHeight: config.tileHeight,
            originX: config.originX,
            originY: config.originY
        )
        var nodes: [SVGNode] = []
        for row in 0..<config.rows {
            for col in 0..<config.columns {
                let (cx, cy) = projector.project(x: Double(col), y: Double(row))
                // Represent each tile as a rect anchored at its projected center.
                let x = cx - config.tileWidth / 2.0
                let y = cy - config.tileHeight / 2.0
                let rect = SVGRect(
                    x: x,
                    y: y,
                    width: config.tileWidth,
                    height: config.tileHeight,
                    fill: fill,
                    stroke: stroke,
                    strokeWidth: strokeWidth
                )
                nodes.append(.rect(rect))
            }
        }
        return nodes
    }
}

