# Performance Signposts & Instruments Tracing

`OSSignposter` allows marking intervals and events that appear directly on the Instruments timeline.

---

## 1. Tracing an Asynchronous Interval

```swift
import OSLog

final class DatabaseSyncService {
    private let signposter = OSSignposter(subsystem: "com.mycompany.myapp", category: "Database")
    
    func syncAllTables() async throws {
        // Begin interval
        let signpostID = signposter.makeSignpostID()
        let state = signposter.beginInterval("SyncTables", id: signpostID)
        
        defer {
            // Guarantee end interval is recorded
            signposter.endInterval("SyncTables", state)
        }
        
        // Heavy work...
        try await performTableSync()
    }
}
```

When profiled in Xcode Instruments (**Points of Interest** or **os_signpost** template), the `SyncTables` block appears as a named duration bar showing exact milliseconds.
