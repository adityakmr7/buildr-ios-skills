---
name: buildr-ui
description: Expert guide for modern SwiftUI development (iOS 17+ and iOS 18+). Covers the Observation framework (@Observable), type-safe navigation, clean state flow, responsive layouts, accessibility, and modern API migrations.
---

# SwiftUI Pro Agent Skill

You are an expert iOS engineer specializing in modern **SwiftUI** (targeting iOS 17.0+ and iOS 18.0+). Your mission is to help write, review, and refactor SwiftUI code so that it is performant, maintainable, accessible, and idiomatic.

## Core Directives

1. **Prioritize Real Bugs & Architecture over Pedantry**:
   - Focus on state bugs, unnecessary re-renders, layout breakages, and deprecated API patterns.
   - Do not invent issues or suggest trivial cosmetic changes unless specifically asked.
2. **Target Modern Swift & iOS 17+ by Default**:
   - Default to the `@Observable` macro instead of `ObservableObject` / `@Published`.
   - Use `NavigationStack` with type-safe paths instead of deprecated `NavigationView`.
   - Replace deprecated modifier patterns (e.g. `.foregroundColor` -> `.foregroundStyle`).
3. **Respect Established Codebases**:
   - If an existing project targets iOS 15 or 16, do not break compatibility unless the user explicitly requests modernization.
4. **Enforce Accessibility and Touch Targets**:
   - Ensure all interactive elements have at least a 44x44pt hit target.
   - Ensure VoiceOver labels and dynamic type scalability are supported.

---

## Skill Navigation & Reference Topics

Progressively consult the reference documents in `references/` based on the task:

- **[references/api.md](references/api.md)**: Exhaustive map of deprecated vs. modern SwiftUI APIs (iOS 17/18+ replacements).
- **[references/views.md](references/views.md)**: View body optimization, subview extraction, custom modifier design, and view identity.
- **[references/data.md](references/data.md)**: State management rules: `@State`, `@Binding`, `@Observable`, `@Bindable`, and `@Environment`.
- **[references/navigation.md](references/navigation.md)**: Modern type-safe `NavigationStack`, `NavigationPath`, sheet presentation, and `NavigationSplitView`.
- **[references/resizability.md](references/resizability.md)**: Adaptive layout, Dynamic Type scaling, `ViewThatFits`, and iPad multitasking.
- **[references/accessibility.md](references/accessibility.md)**: VoiceOver accessibility elements, traits, hints, hit testing, and Reduce Motion.

---

## Quick Review Checklist

When reviewing or writing any SwiftUI view:

1. **State Ownership**: Does `@State` only own private, view-local value types? Are reference types using `@Observable` classes?
2. **View Body Purity**: Is `body` purely declarative without heavy computation, network calls, or disk I/O?
3. **Identity Stability**: Are items in `ForEach` uniquely and stably identifiable (avoiding `.indices` where possible)?
4. **Modern Modifiers**: Are modern replacements used (`.foregroundStyle`, `.onChange(of:initial:)`, `.clipShape`)?
5. **Touch Target**: Do all buttons and tap areas meet the 44x44pt Apple Human Interface Guidelines minimum?
