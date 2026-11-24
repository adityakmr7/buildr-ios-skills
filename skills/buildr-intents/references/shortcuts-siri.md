# App Shortcuts & Siri Voice Integration

`AppShortcutsProvider` exposes intents to Siri automatically upon installation without requiring manual configuration by the user in the Shortcuts app.

---

## 1. Declaring App Shortcuts

```swift
import AppIntents

struct MyAppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: LogWaterIntakeIntent(),
            phrases: [
                "Log water in \(.applicationName)",
                "Track a glass of water in \(.applicationName)",
                "Add water to \(.applicationName)"
            ],
            shortTitle: "Log Water",
            systemImageName: "drop.fill"
        )
    }
}
```

---

## 2. Dynamic Short Title & Siri Spotlight

The phrases configured above are automatically indexed by Spotlight and recognized by Siri. Ensure `\.applicationName` is placed in phrases so Siri reliably disambiguates your app.
