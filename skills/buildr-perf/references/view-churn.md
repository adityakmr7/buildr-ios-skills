# SwiftUI View Invalidation & Render Churn

When SwiftUI views re-evaluate their `body` repeatedly (often dozens of times per second), battery drains and animations drop frames.

---

## 1. Diagnosing View Invalidations with `_printChanges()`

SwiftUI provides an internal diagnostic tool: `Self._printChanges()`.

```swift
struct FeedRowView: View {
    let post: Post
    
    var body: some View {
        #if DEBUG
        let _ = Self._printChanges() // Prints exactly which property triggered re-render
        #endif
        
        VStack {
            Text(post.title)
        }
    }
}
```

Console output will reveal the culprit:
```text
FeedRowView: @self changed.
FeedRowView: _post changed.
```

---

## 2. Common Causes of View Churn

### ❌ Inadvertent Value Equality Failure
If an `@Observable` model or input `struct` does not have value equality, SwiftUI considers every render a new value:

```swift
// ❌ Poor: Recomputed closure creates a new instance on every parent body run
struct ChildView: View {
    let onAction: () -> Void // Closures cannot be compared for equality!
    // ...
}

// ✅ Correct: Subview isolates state or passes an action enum
```

### ❌ Monolithic Parent Views
If a root view has 5 `@State` variables, changing any of them re-evaluates the entire tree if computed properties are used instead of child `struct` views.

---

## 3. View Boundary Isolation

Extracting child views creates evaluation boundaries:

```swift
// ChildView only re-renders if 'title' actually changes value
struct TitleHeaderView: View, Equatable {
    let title: String
    
    var body: some View {
        Text(title).font(.largeTitle)
    }
}
```
