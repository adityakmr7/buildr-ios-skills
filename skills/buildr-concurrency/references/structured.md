# Structured Concurrency & Task Cancellation

Structured concurrency ties the lifecycle of concurrent tasks to their lexical scope, guaranteeing that child tasks complete or cancel before the parent function returns.

---

## 1. `async let` for Fixed Parallel Operations

When running a known number of distinct asynchronous operations in parallel:

```swift
func fetchDashboardData() async throws -> Dashboard {
    // Both network calls run concurrently
    async let profile = api.fetchProfile()
    async let notifications = api.fetchNotifications()
    
    // Await both results together
    return try await Dashboard(
        profile: profile,
        notifications: notifications
    )
}
```

---

## 2. Task Groups for Dynamic Parallel Work

When parallelizing over an arbitrary collection of items:

```swift
func downloadAllImages(urls: [URL]) async -> [URL: UIImage] {
    await withTaskGroup(of: (URL, UIImage?).self) { group in
        for url in urls {
            group.addTask {
                let image = try? await downloadImage(from: url)
                return (url, image)
            }
        }
        
        var results: [URL: UIImage] = [:]
        for await (url, image) in group {
            if let image {
                results[url] = image
            }
        }
        return results
    }
}
```

---

## 3. Cooperative Cancellation

Swift concurrency tasks do **not** forcefully terminate when cancelled. Your code must cooperate:

```swift
func processLargeBatch(items: [DataItem]) async throws -> [ProcessedItem] {
    var output: [ProcessedItem] = []
    
    for item in items {
        // Throws CancellationError immediately if cancelled
        try Task.checkCancellation()
        
        let processed = try await transform(item)
        output.append(processed)
    }
    
    return output
}
```
