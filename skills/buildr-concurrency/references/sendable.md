# Sendable Protocol & Safe Boundaries

`Sendable` indicates that a type's values can safely cross concurrent boundaries without causing data races.

---

## 1. What Is Automatically `Sendable`?

- **Value types** (structs, enums, tuples) where all stored properties are `Sendable`.
- **Actors** (because access to their mutable state is serialized).
- **Immutable classes** marked `final` with only `let` immutable stored properties of `Sendable` types:
  ```swift
  final class UserConfig: Sendable {
      let apiKey: String
      let timeout: TimeInterval
      
      init(apiKey: String, timeout: TimeInterval) {
          self.apiKey = apiKey
          self.timeout = timeout
      }
  }
  ```

---

## 2. What Is NOT `Sendable`?

- Standard mutable reference classes (`class MyModel { var name: String }`).
- Closures that capture mutable local variables.
- Pointer types, reference wrappers (`NSMutableDictionary`, `NSMutableArray`).

---

## 3. `@Sendable` Closures

Functions passed to `Task.init`, `TaskGroup.addTask`, or background dispatches must be `@Sendable`:

```swift
// A @Sendable closure cannot capture mutable variables by reference
var count = 0
Task {
    // ❌ Compile error in Swift 6: Mutation of captured var in concurrently-executing code
    count += 1
}
```

---

## 4. When to Use `@unchecked Sendable`

Use `@unchecked Sendable` **only** when a type internally synchronizes access using a lock (such as `OSAllocatedUnfairLock`) that the compiler cannot automatically verify:

```swift
import os

final class ThreadSafeCounter: @unchecked Sendable {
    private let lock = OSAllocatedUnfairLock(initialState: 0)
    
    func increment() {
        lock.withLock { $0 += 1 }
    }
    
    var value: Int {
        lock.withLock { $0 }
    }
}
```
