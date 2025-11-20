import Foundation

/// A single keyframe for a scalar property.
public struct Keyframe1D: Sendable {
    public var time: Double    // seconds
    public var value: Double

    public init(time: Double, value: Double) {
        self.time = time
        self.value = value
    }
}

/// A simple piecewise‑linear animation curve for a scalar property.
public struct AnimationCurve1D: Sendable {
    public var keyframes: [Keyframe1D]

    public init(keyframes: [Keyframe1D]) {
        self.keyframes = keyframes.sorted { $0.time < $1.time }
    }

    /// Sample the curve at a given time in seconds.
    /// - If time is before the first keyframe, returns its value.
    /// - If time is after the last keyframe, returns its value.
    /// - Otherwise, returns a linear interpolation between surrounding keyframes.
    public func value(at time: Double) -> Double {
        guard !keyframes.isEmpty else { return 0 }
        if time <= keyframes[0].time { return keyframes[0].value }
        if let last = keyframes.last, time >= last.time { return last.value }

        // Find the segment that contains `time`
        for i in 0..<(keyframes.count - 1) {
            let a = keyframes[i]
            let b = keyframes[i + 1]
            if time >= a.time && time <= b.time {
                let t = (time - a.time) / (b.time - a.time)
                return a.value + (b.value - a.value) * t
            }
        }
        // Fallback (should not happen with sorted frames)
        return keyframes.last?.value ?? 0
    }
}

/// A minimal animation timeline mapping property names to curves.
public struct AnimationTimeline1D: Sendable {
    public var duration: Double
    public var tracks: [String: AnimationCurve1D]

    public init(duration: Double, tracks: [String: AnimationCurve1D]) {
        self.duration = duration
        self.tracks = tracks
    }

    /// Sample all tracks at a given time.
    public func sample(at time: Double) -> [String: Double] {
        tracks.mapValues { $0.value(at: time) }
    }
}

/// Helpers for working with timelines at the SVG level.
public enum AnimationFrames {
    /// Generate a list of scenes representing discrete frames for the given timeline.
    ///
    /// - Parameters:
    ///   - baseScene: scene to use as a starting point.
    ///   - timeline: animation curves to sample.
    ///   - fps: frames per second (e.g. 30).
    ///   - apply: mapping from sampled property values to a new scene for that frame.
    ///
    /// The mapping function is responsible for interpreting the sampled values
    /// (e.g. moving nodes, changing opacity) and returning a derived scene.
    public static func renderScenes(
        baseScene: SVGScene,
        timeline: AnimationTimeline1D,
        fps: Double,
        apply: (SVGScene, [String: Double]) -> SVGScene
    ) -> [SVGScene] {
        guard fps > 0, timeline.duration > 0 else { return [baseScene] }
        let frameCount = max(1, Int(timeline.duration * fps) + 1)
        var scenes: [SVGScene] = []
        for i in 0..<frameCount {
            let t = Double(i) / fps
            let values = timeline.sample(at: t)
            let scene = apply(baseScene, values)
            scenes.append(scene)
        }
        return scenes
    }
}

/// Helpers for encoding an AnimationCurve1D into SVG `<animate>` attributes.
public enum SVGAnimationEncoding {
    /// Encode a curve into `values` and `keyTimes` suitable for `<animate>`.
    /// Times are normalised into the range [0, 1] relative to the first/last keyframe.
    public static func encode(curve: AnimationCurve1D) -> (values: String, keyTimes: String, duration: Double) {
        guard let first = curve.keyframes.first, let last = curve.keyframes.last, last.time > first.time else {
            let v = curve.keyframes.first?.value ?? 0
            return (values: "\(v)", keyTimes: "0;1", duration: 0)
        }
        let total = last.time - first.time
        var values: [String] = []
        var times: [String] = []
        for k in curve.keyframes {
            values.append("\(k.value)")
            let norm = (k.time - first.time) / total
            times.append("\(norm)")
        }
        return (values: values.joined(separator: ";"),
                keyTimes: times.joined(separator: ";"),
                duration: total)
    }
}

