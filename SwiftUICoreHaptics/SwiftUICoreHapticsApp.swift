//
//    Project: SwiftUICoreHaptics
//    File: SwiftUICoreHapticsApp.swift
//    Created by Noah Carpenter
//    🐱 Follow me on YouTube! 🎥
//    https://www.youtube.com/@noahdoescoding
//    Like and Subscribe for coding tutorials and fun! 💻✨
//    Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
//    Dream Big, Code Bigger
//

import SwiftUI // Required for the SwiftUI app lifecycle.

/// Entry point for the SwiftUI app.
/// - The `@main` attribute marks this as the app's starting type.
@main
struct SwiftUICoreHapticsApp: App {
    var body: some Scene {
        // `WindowGroup` creates the main app window on iOS and manages multiple windows on macOS/iPadOS when supported.
        WindowGroup {
            // The root view shown in the window.
            ContentView() // Replace with another view to change the app's initial screen.
        }
    }
}
