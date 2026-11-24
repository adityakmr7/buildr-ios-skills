# SwiftUI Deprecated vs Modern APIs Reference

Always replace deprecated SwiftUI APIs with their modern equivalents when targeting iOS 17+ / iOS 18+.

---

## 1. Colors & Styling

| Deprecated / Soft-Deprecated | Modern Replacement | Context / Notes |
| :--- | :--- | :--- |
| `.foregroundColor(Color)` | `.foregroundStyle(HierarchicalShapeStyle / Color)` | `.foregroundStyle` supports materials, gradients, and semantic hierarchy (`.primary`, `.secondary`, `.tertiary`). |
| `.cornerRadius(12)` | `.clipShape(RoundedRectangle(cornerRadius: 12))` | `.cornerRadius` is soft-deprecated; `.clipShape` provides explicit geometry and clipping control. |
| `.background(Color.blue)` | `.background(.blue, in: RoundedRectangle(cornerRadius: 8))` | Use shape-aware `.background(_:in:)` to avoid separate clip modifiers. |

### Example:
```swift
// ❌ Old / Deprecated
Text("Hello, World!")
    .foregroundColor(.secondary)
    .cornerRadius(8)

// ✅ Modern (iOS 17+)
Text("Hello, World!")
    .foregroundStyle(.secondary)
    .clipShape(RoundedRectangle(cornerRadius: 8))
```

---

## 2. State & Change Observation

| Deprecated / Soft-Deprecated | Modern Replacement | Context / Notes |
| :--- | :--- | :--- |
| `.onChange(of: value) { newValue in }` | `.onChange(of: value) { oldValue, newValue in }` or `.onChange(of: value, initial: true) { ... }` | iOS 17+ provides two-parameter closure and optional `initial: true` execution on view load. |
| `onReceive(NotificationCenter.default.publisher(...))` | `.onReceive` or modern `AsyncSequence` / `.task` | Prefer structured async tasks for streaming events where practical. |

### Example:
```swift
// ❌ Deprecated 1-parameter signature
.onChange(of: selectedFilter) { newFilter in
    applyFilter(newFilter)
}

// ✅ Modern iOS 17+ signature
.onChange(of: selectedFilter, initial: false) { oldValue, newValue in
    applyFilter(newValue)
}
```

---

## 3. Navigation Hierarchy

| Deprecated | Modern Replacement | Notes |
| :--- | :--- | :--- |
| `NavigationView { ... }` | `NavigationStack { ... }` or `NavigationSplitView { ... }` | `NavigationView` has severe memory leaks and path management issues on modern iOS. |
| `NavigationLink(destination: NextView())` | `NavigationLink(value: destinationItem)` + `.navigationDestination(for:)` | Decouples navigation trigger from destination view instantiations. |

### Example:
```swift
// ❌ Deprecated Navigation
NavigationView {
    NavigationLink("Detail", destination: DetailView(id: item.id))
}

// ✅ Modern Type-Safe Navigation
NavigationStack(path: $navigationPath) {
    List(items) { item in
        NavigationLink(item.title, value: item)
    }
    .navigationDestination(for: Item.self) { item in
        DetailView(item: item)
    }
}
```

---

## 4. Content Unavailable & Empty States

Instead of building ad-hoc `VStack` displays with custom SF Symbols and text for empty or error states:

```swift
// ✅ Modern iOS 17+ Empty State
if items.isEmpty {
    ContentUnavailableView(
        "No Orders Found",
        systemImage: "tray.fill",
        description: Text("When you place an order, it will appear here.")
    )
}
```

---

## 5. Sheets, Overlays & Materials

| Old Technique | Modern Replacement |
| :--- | :--- |
| `.background(Color.white.opacity(0.8))` | `.background(.ultraThinMaterial)` |
| Hardcoded sheet drag handles | `.presentationDragIndicator(.visible)` |
| Custom background behind sheet | `.presentationBackground(.ultraThinMaterial)` |
| Fixed sheet height calculation | `.presentationDetents([.fraction(0.3), .large])` |
