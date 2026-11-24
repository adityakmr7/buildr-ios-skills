# Actor Isolation & Reentrancy Hazards

Actors protect their mutable state by ensuring only one thread executes within their isolation domain at a time.

---

## 1. The Actor Reentrancy Trap

> [!WARNING]
> Actors do **not** lock across suspension points (`await`). While an actor is suspended awaiting a network request or I/O, other tasks can and will execute on that same actor and mutate its state!

### ❌ Dangerous Reentrancy Bug:
```swift
actor BankAccount {
    var balance: Decimal = 100
    
    func withdraw(amount: Decimal) async -> Bool {
        guard balance >= amount else { return false }
        
        // ⚠️ SUSPENSION POINT: Another task can execute withdraw() right here!
        await notifyFraudService(attemptedAmount: amount)
        
        // 💥 Bug: balance may no longer be >= amount!
        balance -= amount
        return true
    }
}
```

### ✅ Safe Reentrancy Architecture:
Re-verify invariants after every `await`, or perform the mutation synchronously before/after the async work:

```swift
actor BankAccount {
    var balance: Decimal = 100
    
    func withdraw(amount: Decimal) async -> Bool {
        guard balance >= amount else { return false }
        
        // Deduct state synchronously before suspension
        balance -= amount
        
        // Async notification after mutation
        await notifyFraudService(attemptedAmount: amount)
        return true
    }
}
```

---

## 2. `@MainActor` Isolation

Any type that touches the UI or drives SwiftUI views must be isolated to `@MainActor`:

```swift
@MainActor
@Observable
final class FeedViewModel {
    var posts: [Post] = []
    
    func loadPosts(api: APIClient) async {
        do {
            // Network fetch executes on background actor/thread
            let newPosts = try await api.fetchFeed()
            // Resumption is guaranteed to occur safely on @MainActor
            self.posts = newPosts
        } catch {
            // Handle error on main thread
        }
    }
}
```

---

## 3. `nonisolated` Functions

If an actor method or property only accesses immutable data, mark it `nonisolated` so callers do not have to `await`:

```swift
actor UserDatabase {
    let databaseIdentifier: UUID // Immutable 'let' constant
    var userCache: [String: User] = [:] // Mutable state
    
    // Can be called synchronously without suspension from anywhere
    nonisolated var idString: String {
        databaseIdentifier.uuidString
    }
}
```
