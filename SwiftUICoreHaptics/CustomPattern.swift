//
//    Project: SwiftUICoreHaptics
//    File: CustomPattern.swift
//    Created by Noah Carpenter
//    🐱 Follow me on YouTube! 🎥
//    https://www.youtube.com/@NoahDoesCoding97
//    Like and Subscribe for coding tutorials and fun! 💻✨
//    Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
//    Dream Big, Code Bigger
//

import Foundation
import CoreHaptics

/// Example utilities for building reusable Core Haptics patterns.
/// You can move pattern-building code out of `HapticsManager` into helpers like these
/// to reuse across different parts of the app.
struct CustomPattern {
    /// Builds a quick success pattern: two crisp taps.
    /// - Parameters:
    ///   - intensity: Overall strength (0.0 - 1.0). Higher feels stronger.
    ///   - sharpness: Texture/brightness (0.0 - 1.0). Higher feels crisper.
    ///   - spacing: Time between taps in seconds. Smaller feels more immediate.
    /// - Returns: A `CHHapticPattern` you can play with an engine/player.
    static func success(intensity: Float = 0.9, sharpness: Float = 0.8, spacing: TimeInterval = 0.08) throws -> CHHapticPattern {
        // Two transients separated by `spacing` seconds.
        let first = CHHapticEvent(eventType: .hapticTransient,
                                  parameters: [
                                    CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
                                    CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
                                  ],
                                  relativeTime: 0)
        let second = CHHapticEvent(eventType: .hapticTransient,
                                   parameters: [
                                    CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
                                    CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
                                   ],
                                   relativeTime: spacing)
        return try CHHapticPattern(events: [first, second], parameters: [])
    }
}
