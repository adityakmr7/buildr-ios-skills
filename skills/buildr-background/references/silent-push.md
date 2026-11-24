# Silent Push Notifications (`content-available: 1`)

Silent notifications wake an app in the background so it can update its content before the user opens it.

---

## 1. APNs Payload Structure

Must contain `"content-available": 1` and **must omit** `"alert"`, `"badge"`, or `"sound"`:

```json
{
  "aps": {
    "content-available": 1
  },
  "updateType": "new_messages"
}
```

---

## 2. Handling the Notification

```swift
func application(
    _ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable: Any],
    fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
) {
    Task {
        let hasNewData = await SyncService.shared.sync()
        completionHandler(hasNewData ? .newData : .noData)
    }
}
```
