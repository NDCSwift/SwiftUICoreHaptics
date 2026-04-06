# 📳 Core Haptics Demo — SwiftUI

A SwiftUI demo showing how to design custom haptic feedback patterns on iPhone using Core Haptics — going far beyond the basic `UIFeedbackGenerator`.

---

## 🤔 What this is

This project demonstrates how to use `CHHapticEngine` to play fully custom haptic patterns in a SwiftUI app. It includes a `HapticsManager` that wraps engine lifecycle management, a `CustomPattern` builder for composing haptic events, and a UI to trigger different sequences — covering intensity, sharpness, and timing control.

## ✅ Why you'd use it

- **`HapticsManager`** — handles `CHHapticEngine` start/stop, reset on interruption, and pattern playback
- **`CustomPattern`** — compose `CHHapticEvent` arrays with precise intensity and sharpness parameters
- **Fine-grained control** — set exact haptic timing, intensity curves, and sharpness values
- **Capability check** — shows how to guard against devices that don't support Core Haptics
- **SwiftUI integrated** — trigger haptics from button taps or gesture callbacks

## 📺 Watch on YouTube

[![Watch on YouTube](https://img.shields.io/badge/YouTube-Watch%20the%20Tutorial-red?style=for-the-badge&logo=youtube)](https://youtu.be/yHQbVoEwk_0)

> This project was built for the [NoahDoesCoding YouTube channel](https://www.youtube.com/@NoahDoesCoding97).

---

## 🚀 Getting Started

### 1. Clone the Repo
```bash
git clone https://github.com/NDCSwift/SwiftUICoreHaptics.git
cd SwiftUICoreHaptics
```

### 2. Open in Xcode
Double-click `SwiftUICoreHaptics.xcodeproj`.

### 3. Set Your Development Team
TARGET → Signing & Capabilities → Team

### 4. Update the Bundle Identifier
Change `com.example.MyApp` to a unique identifier.

### 5. Run on a Physical Device
Core Haptics does not work in the Simulator — a real iPhone with Taptic Engine is required.

---

## 🛠️ Notes
- Always check `CHHapticEngine.capabilitiesForHardware().supportsHaptics` before playing patterns.
- Restart the engine in `scenePhase .active` if your app goes to the background.

## 📦 Requirements
- Xcode 16+
- iOS 13+
- Physical iPhone (6S or later) with Taptic Engine

📺 [Watch the guide on YouTube](https://youtu.be/yHQbVoEwk_0)
