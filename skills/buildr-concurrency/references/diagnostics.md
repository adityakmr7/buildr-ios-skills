# Swift 6 Concurrency Diagnostics Playbook

Common compiler errors in Swift 6 and their idiomatic solutions.

---

## Error 1: "Main actor-isolated property cannot be mutated from nonisolated context"

### ❌ Cause:
Calling a `@MainActor` property or method from an unstructured background task.

```swift
// ❌ Error
func downloadData() async {
    let data = await api.fetch()
    viewModel.items = data // Error: Mutation of @MainActor property from nonisolated context
}
```

### ✅ Solution:
Mark the enclosing function or class `@MainActor`, or wrap the UI update in `await MainActor.run { ... }`:
```swift
// ✅ Solution 1: Isolate function
@MainActor
func downloadData() async {
    let data = await api.fetch()
    viewModel.items = data // Safe on MainActor
}

// ✅ Solution 2: Explicit MainActor scope
func downloadData() async {
    let data = await api.fetch()
    await MainActor.run {
        viewModel.items = data
    }
}
```

---

## Error 2: "Capture of non-Sendable type in a `@Sendable` closure"

### ❌ Cause:
Passing an ordinary class instance into a `Task` closure.

```swift
class OrderSession {
    var id: String = ""
}

func sync(session: OrderSession) {
    Task {
        // ❌ Error: Capture of non-Sendable type 'OrderSession'
        print(session.id)
    }
}
```

### ✅ Solution:
Convert the type to a `struct`, make it an `actor`, or extract the primitive immutable value before dispatching:
```swift
// ✅ Solution: Extract primitive value
func sync(session: OrderSession) {
    let sessionId = session.id // String is Sendable
    Task {
        print(sessionId) // Safe!
    }
}
```

---

## Error 3: "Passing argument of non-Sendable type into actor-isolated method"

### ❌ Cause:
Passing an array of mutable objects into an actor.

### ✅ Solution:
Ensure the payload conforms to `Sendable` by using structs or snapshots rather than live object graphs.
