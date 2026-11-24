# Memory Leaks, Retain Cycles & Task Leaks

Memory leaks in Swift typically stem from strong reference cycles in escaping closures or uncancelled asynchronous background tasks.

---

## 1. Closure Capture Lists (`[weak self]`)

```swift
final class NetworkMonitor {
    var onStatusChanged: ((Bool) -> Void)?
}

class DashboardViewModel {
    let monitor = NetworkMonitor()
    var isOnline = false
    
    init() {
        // ❌ Strong Retain Cycle:
        // monitor holds closure -> closure holds self -> self holds monitor
        monitor.onStatusChanged = { status in
            self.isOnline = status
        }
        
        // ✅ Correct: Break cycle with [weak self]
        monitor.onStatusChanged = { [weak self] status in
            guard let self else { return }
            self.isOnline = status
        }
    }
}
```

---

## 2. Asynchronous `Task` Leaks in SwiftUI

If an unstructured `Task` is started in a view and the user navigates away, the `Task` continues running in the background unless explicitly cancelled!

```swift
// ❌ Dangerous: Task continues running even after view is popped
struct DetailView: View {
    var body: some View {
        Text("Detail")
            .onAppear {
                Task {
                    while true {
                        await doHeavyBackgroundPoll()
                    }
                }
            }
    }
}

// ✅ Correct: SwiftUI's .task modifier cancels automatically when view disappears
struct DetailView: View {
    var body: some View {
        Text("Detail")
            .task {
                while !Task.isCancelled {
                    await doHeavyBackgroundPoll()
                }
            }
    }
}
```
