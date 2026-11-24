# Architecture Pattern Decision Matrix

Choose the pattern that matches your project's scale and state complexity.

---

## 1. Comparison Matrix

| Architecture | Best Suited For | Strengths | Trade-offs |
| :--- | :--- | :--- | :--- |
| **MVVM (Model-View-ViewModel)** | Small to medium apps; standard form and list screens. | Low boilerplate; native SwiftUI integration via `@Observable`. | Can become bloated ("Massive ViewModel") if routing and business logic mix. |
| **Clean Architecture / Ports & Adapters** | Enterprise apps with multiple external APIs, complex business rules, and multiplatform targets (iOS, macOS). | Strict separation between domain entities, use cases, and presentation. Fully testable without UI. | Higher file count and mapping overhead between domain and UI layers. |
| **The Composable Architecture (TCA)** | Large apps with complex shared state, parallel async flows, and deep navigation trees. | Uncompromising UDF, state isolation, time-travel debugging, and testability. | Steep learning curve; library dependency (`swift-composable-architecture`). |
| **Coordinator Pattern** | Apps with complex routing, dynamic deep links, and flow switching (e.g. auth flow vs onboard flow). | Decouples navigation from views; views know nothing about destination views. | Slightly more wiring in pure SwiftUI (often combined with `NavigationPath`). |

---

## 2. Recommendation Guide

- **Simple CRUD or Content App**: Standard **SwiftUI + `@Observable` ViewModel**.
- **Regulated, Long-Lived Enterprise App**: **Clean Architecture with Use Cases**.
- **Highly Interactive Multi-step User Flows**: **UDF / State Machine / TCA**.
