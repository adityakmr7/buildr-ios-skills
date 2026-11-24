# Short In-Flight Tasks & Background Assertions

When the user moves the app to the background while a critical operation (like saving an order or uploading an analytics event) is in progress, request short additional background runtime.

---

## 1. `beginBackgroundTask(expirationHandler:)`

```swift
func saveOrderOnDismissal(order: Order) {
    var backgroundTaskID = UIBackgroundTaskIdentifier.invalid
    
    backgroundTaskID = UIApplication.shared.beginBackgroundTask(withName: "Save Order") {
        // Expiration handler called by iOS when time runs out (~30 seconds max)
        UIApplication.shared.endBackgroundTask(backgroundTaskID)
        backgroundTaskID = .invalid
    }
    
    Task {
        await OrderService.shared.persist(order)
        
        // Cleanly end task assertion when work completes
        if backgroundTaskID != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTaskID)
            backgroundTaskID = .invalid
        }
    }
}
```
