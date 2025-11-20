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

