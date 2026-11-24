# SwiftUI Views & Layout Optimization

## 1. View Body Purity & Performance

SwiftUI repeatedly evaluates the `body` property of views whenever state dependencies change.

### The Golden Rules of `body`:
1. **Never allocate long-lived objects inside `body`**:
   - `DateFormatter()`, `NumberFormatter()`, and database queries must never be instantiated directly within `body`.
   - Store formatters as static properties or cached helpers.
2. **Keep `body` pure**:
   - No side effects inside `body` (e.g., dispatching network requests, mutating variables).
   - Use `.task { ... }` or `.onAppear { ... }` for lifecycle events.
3. **Extract Subviews, Not Complex Computed Properties**:
   - Subviews (`struct ChildView: View`) have their own body evaluation boundaries.
   - If parent state changes, SwiftUI only re-evaluates `ChildView` if its specific inputs changed.
   - Computed properties (`var childView: some View { ... }`) re-evaluate every time the parent evaluates.

### Example: Subview Extraction
```swift
// ❌ Poor: Computed property re-runs every time any state in ParentView changes
struct ParentView: View {
    @State private var counter = 0
    @State private var text = ""
    
    var body: some View {
        VStack {
            TextField("Search", text: $text)
            heavyMetricsSection // Re-evaluated on every keystroke in TextField!
        }
    }
    
    var heavyMetricsSection: some View {
        VStack {
            Text("Metrics: \(calculateComplexScore())")
        }
    }
}

// ✅ Correct: Subview isolates updates
struct ParentView: View {
    @State private var text = ""
    
    var body: some View {
        VStack {
            TextField("Search", text: $text)
            HeavyMetricsSectionView() // Only evaluates when its own dependencies change
        }
    }
}

struct HeavyMetricsSectionView: View {
    var body: some View {
        Text("Isolated Metrics")
    }
}
```

---

## 2. Stable View Identity & `ForEach`

SwiftUI uses identifiers to reconcile view identity during animations and layout passes.

- **Always use stable IDs**: Identifiers must never change across renders for the same item.
- **Avoid `.indices` in `ForEach`**: If an element is inserted or deleted, all subsequent indices shift, causing catastrophic render churn and animation glitches.

```swift
// ❌ Dangerous: Index-based iteration breaks animations on insert/delete
ForEach(items.indices, id: \.self) { index in
    ItemRow(item: items[index])
}

// ✅ Stable: Models conform to Identifiable with UUID or unique database ID
ForEach(items) { item in
    ItemRow(item: item)
}
```

---

## 3. Custom View Modifiers

When grouping common styling or behavioral patterns:
- Prefer custom `ViewModifier` over copy-pasting multiple modifiers.
- Provide a clean extension on `View`.

```swift
struct CardStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(16)
            .background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.primary.opacity(0.06), lineWidth: 1)
            )
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyleModifier())
    }
}
```
