# Swift 6 Language Mode & Strict Concurrency

Swift 6 turns compile-time data race safety from a warning into an enforced guarantee.

---

## 1. Enabling Swift 6 Language Mode

In Xcode 16+ / SwiftPM `Package.swift`:

```swift
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "MyPackage",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [...],
    targets: [
        .target(
            name: "MyTarget",
            swiftSettings: [
                .swiftLanguageMode(.v6) // Enforces Swift 6 rules
            ]
        )
    ]
)
```

In Xcode build settings for app targets:
- Set **Swift Language Version** to **Swift 6**.
- Set **Strict Concurrency Checking** to **Complete**.

---

## 2. Core Tenets of the Swift 6 Safety Model

1. **Isolation by Default**: Code executes in a specific isolation context (either on a specific actor, on `@MainActor`, or nonisolated).
2. **Sendable Boundaries**: Any value passed across isolation domains (between actors or between tasks) must conform to `Sendable`.
3. **Compile-Time Verification**: The compiler mathematically proves that no two threads can access mutable memory simultaneously.
