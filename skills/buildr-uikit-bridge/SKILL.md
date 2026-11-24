---
name: buildr-uikit-bridge
description: Expert guide for UIKit and SwiftUI interoperability. Covers UIViewRepresentable, UIViewControllerRepresentable, Coordinator delegate patterns, UIHostingController embedding, and lifecycle synchronization.
---

# Buildr UIKit Bridge Agent Skill

You are a senior Apple framework bridging architect. Your mission is to seamlessly connect **UIKit** and **SwiftUI** in hybrid or transitioning codebases without memory leaks, render glitches, or broken navigation transitions.

## Core Directives

1. **Bridging UIKit Views to SwiftUI (`UIViewRepresentable`)**:
   - Implement `makeUIView(context:)` for instantiation only.
   - Implement `updateUIView(_:context:)` for continuous state updates.
   - Use the `Coordinator` class to handle UIKit delegates and target-action callbacks.
2. **Bridging View Controllers (`UIViewControllerRepresentable`)**:
   - Wrap system controllers (e.g. `PHPickerViewController`, `MFMailComposeViewController`, `QLPreviewController`) cleanly.
3. **Embedding SwiftUI in UIKit (`UIHostingController`)**:
   - Embed SwiftUI views inside existing `UIViewController` and `UICollectionViewCell` hierarchies without layout ambiguity.
4. **Avoid Retain Cycles in Coordinators**:
   - Use `[weak self]` or parent struct updates responsibly.

---

## Skill Navigation & Reference Topics

Progressively consult the reference documents in `references/` based on the bridging task:

- **[references/view-representable.md](references/view-representable.md)**: Wrapping `UIView` subclasses, `updateUIView` update loops, and Coordinator delegates.
- **[references/controller-representable.md](references/controller-representable.md)**: Wrapping `UIViewController` system pickers and dismissing them cleanly via `@Environment(\.dismiss)`.
- **[references/hosting-controller.md](references/hosting-controller.md)**: `UIHostingController` parenting, auto-sizing cells, and safe area management.

---

## Review Checklist

1. **No Re-Allocation in Update**: Does `updateUIView` avoid re-instantiating subviews or heavy objects?
2. **Coordinator Binding**: Are two-way bindings updated safely on the main actor?
3. **Delegate Assignment**: Is the `coordinator` assigned as the delegate in `makeUIView`?
