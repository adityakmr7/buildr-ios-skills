# Asynchronous Testing & Event Confirmations

Testing asynchronous tasks and event dispatching in Swift Testing.

---

## 1. Asynchronous Functions

Simply write `async throws` functions. No need to fulfill expectations or call completion handlers:

```swift
@Test func fetchUserProfile() async throws {
    let client = APIClient()
    let profile = try await client.fetchProfile(userId: "u_101")
    #expect(profile.isActive)
}
```

---

## 2. Event Confirmations (`confirmation`)

To verify that a callback or delegate method is invoked a specific number of times, use `confirmation`:

```swift
@Test func testNotificationBroadcasting() async {
    let emitter = EventEmitter()
    
    // Expect the confirmation closure to be called exactly 1 time
    await confirmation("Event should be received", expectedCount: 1) { eventConfirmed in
        emitter.onEvent = { _ in
            eventConfirmed()
        }
        
        emitter.trigger()
    }
}
```

---

## 3. Testing Timeouts

Prevent stalled network mocks or infinite async loops with `.timeLimit`:

```swift
@Test("Fast response required", .timeLimit(.seconds(2)))
func queryCache() async throws {
    let result = try await CacheService.shared.lookup("key")
    #expect(result != nil)
}
```
