# App Groups & Shared Extension Storage

Extensions have separate file containers. Use App Groups to share data.

---

## 1. Shared `UserDefaults`

```swift
extension UserDefaults {
    static let shared = UserDefaults(suiteName: "group.com.mycompany.myapp")!
}
```

---

## 2. Shared SwiftData / SQLite Container

Point the SQLite database to the App Group folder:

```swift
extension URL {
    static var sharedStoreURL: URL {
        FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.com.mycompany.myapp")!
            .appendingPathComponent("SharedDatabase.sqlite")
    }
}
```
