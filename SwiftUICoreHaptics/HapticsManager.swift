//
//    Project: SwiftUICoreHaptics
//    File: HapticsManager.swift
//    Created by Noah Carpenter
//    🐱 Follow me on YouTube! 🎥
//    https://www.youtube.com/@NoahDoesCoding97
//    Like and Subscribe for coding tutorials and fun! 💻✨
//    Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
//    Dream Big, Code Bigger
//

import Foundation
import CoreHaptics // Provides access to the Core Haptics engine, events, and parameters.

/// Manages creation and playback of Core Haptics patterns.
/// Notes:
/// - Core Haptics is available on devices with a Taptic Engine (most modern iPhones). Simulators typically don't support it.
/// - Always check `CHHapticEngine.capabilitiesForHardware().supportsHaptics` before attempting to play.
class HapticsManager {
    /// The haptics engine used to play patterns.
    /// - Type: `CHHapticEngine?` is optional because engine creation can fail (e.g., unsupported hardware).
    /// - If this is `nil`, attempting to create players will fail.
    private var engine: CHHapticEngine?

    /// Initializes the manager and prepares the haptics engine early.
    /// Calling this at app start reduces latency when first playing a pattern.
    init() {
        prepareHaptics()
    }

    /// Creates and starts the haptics engine if supported by hardware.
    /// - Changing behavior:
    ///   - Removing the guard will cause runtime errors on unsupported devices.
    ///   - You can defer `engine.start()` until just before playback to save power, but it increases latency.
    private func prepareHaptics() {
        // Early-out if the device doesn't support Core Haptics. On unsupported devices, do nothing.
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            // Create a new engine instance. This can throw if resources aren't available.
            engine = try CHHapticEngine()
            // Start the engine so it's ready for immediate playback.
            try engine?.start()
        } catch {
            // In production, consider logging or disabling haptics gracefully.
            print("Haptic engine failed to start: \(error.localizedDescription)")
        }
    }

    /// Plays a custom pattern: a sharp transient click followed by a short continuous vibration that fades out.
    /// Notes on parameters:
    /// - `hapticIntensity` (0.0 - 1.0): perceived strength. Higher = stronger.
    /// - `hapticSharpness` (0.0 - 1.0): texture/brightness. Higher = crisper/tick-like; lower = duller/rumble-like.
    func playCustomHaptic() {
        // Verify hardware support before attempting playback.
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        // A quick, sharp tap at time 0. Useful for immediate feedback.
        let sharpClick = CHHapticEvent(
            eventType: .hapticTransient, // Instantaneous event (no duration).
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0), // Max strength for a strong tap. Try 0.3 for a lighter click.
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)  // Very crisp. Try 0.2 for a softer feel.
            ],
            relativeTime: 0 // Play immediately when the pattern begins.
        )

        // A short continuous buzz that starts slightly after the transient.
        let continuous = CHHapticEvent(
            eventType: .hapticContinuous, // Has a duration; feels like a sustained vibration.
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5), // Medium strength. Increase toward 1.0 for stronger sensation.
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)  // Softer texture. Increase for a brighter tone.
            ],
            relativeTime: 0.02, // Start 20ms after the transient to avoid overlap harshness.
            duration: 0.4 // Total length of the continuous buzz. Shorten for snappier feedback.
        )

        // A parameter curve that fades the intensity of the continuous event down to zero.
        let fadeOut = CHHapticParameterCurve(
            parameterID: .hapticIntensityControl, // Controls intensity over time for matching events.
            controlPoints: [
                // Control points are (time, value) pairs relative to the pattern start.
                CHHapticParameterCurve.ControlPoint(relativeTime: 0.02, value: 0.5), // Start at the event's initial intensity.
                CHHapticParameterCurve.ControlPoint(relativeTime: 0.42, value: 0.0)  // End near the event's end at zero intensity.
            ],
            relativeTime: 0 // Curve timebase aligns with the pattern's start.
        )

        do {
            // Combine events and curves into a single pattern.
            let pattern = try CHHapticPattern(events: [sharpClick, continuous], parameterCurves: [fadeOut])
            // Create a player bound to this engine. Use `makeAdvancedPlayer` if you need precise scheduling/controls.
            let player = try engine?.makePlayer(with: pattern)
            // Start immediately. You can pass a positive time to schedule in the future.
            try player?.start(atTime: 0)
        } catch {
            print("Pattern failed: \(error.localizedDescription)")
        }
    }

    /// Demonstrates synchronizing an audio event with a haptic transient at the same `relativeTime`.
    /// - Notes:
    ///   - `.audioCustom` requires you to supply audio via `CHHapticAdvancedPatternPlayer` callbacks or resources.
    ///   - Keeping both events at `relativeTime: 0` aligns their onsets for tighter feel.
    func playAudioSyncedHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        // Placeholder audio event scheduled at time 0. In real usage, provide audio data via resources.
        let audioEvent = CHHapticEvent(
            eventType: .audioCustom,
            parameters: [], // Parameters like volume or pitch could be added for audio shaping.
            relativeTime: 0
        )

        // A matching haptic transient aligned to the audio onset.
        let hapticEvent = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0), // Strong click to match the audio attack.
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)  // Crisp character to feel synchronized.
            ],
            relativeTime: 0
        )

        do {
            // Use an advanced player for audio-haptic synchronization and finer control.
            let pattern = try CHHapticPattern(events: [audioEvent, hapticEvent], parameters: [])
            let player = try engine?.makeAdvancedPlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Audio-sync failed: \(error.localizedDescription)")
        }
    }
}
