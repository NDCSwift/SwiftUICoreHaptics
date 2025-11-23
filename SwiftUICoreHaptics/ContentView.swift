//
//    Project: SwiftUICoreHaptics
//    File: ContentView.swift
//    Created by Noah Carpenter
//    🐱 Follow me on YouTube! 🎥
//    https://www.youtube.com/@NoahDoesCoding97
//    Like and Subscribe for coding tutorials and fun! 💻✨
//    Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
//    Dream Big, Code Bigger
//

import SwiftUI // SwiftUI provides declarative UI components.

/// The main view that demonstrates triggering a haptic from a button press.
struct ContentView: View {
    // Create a haptics manager instance for this view.
    // - `private let` means it's immutable and scoped to this view.
    // - Consider `@StateObject` if your manager publishes state; here it's a simple helper.
    private let haptics = HapticsManager()
    
    var body: some View {
        // VStack stacks children vertically. `spacing` defines the gap between items.
        VStack(spacing: 24) {
            // A simple title text.
            Text("Core Haptics Demo")
                .font(.title2) // Try `.largeTitle` or `.headline` to change emphasis.
            
            // A button that plays a custom haptic pattern when tapped.
            Button("Play Custom Haptic") {
                // Action closure executed on tap.
                haptics.playCustomHaptic()
            }
            .buttonStyle(.borderedProminent) // Try `.plain` or `.bordered` to alter appearance.
        }
        .padding() // Adds default padding around the VStack. Increase for more whitespace.
    }
}

#Preview {
    // Xcode preview for rapid iteration. Does not execute on device hardware.
    ContentView()
}
