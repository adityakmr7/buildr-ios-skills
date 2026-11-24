# CloudKit & iCloud Sync Constraints in SwiftData

When enabling CloudKit sync (`ModelConfiguration(cloudKitDatabase: .private)`), SwiftData enforces strict schema constraints to maintain compatibility with CloudKit's record model.

---

## 1. The CloudKit Compatibility Rules

1. **All Attributes Must Be Optional OR Have Default Values**:
   - CloudKit records can arrive partially populated during sync.
   - Non-optional properties without default values cause runtime synchronization failure.
   ```swift
   // ❌ Incompatible with CloudKit
   var title: String // Missing default value!
   
   // ✅ Compatible with CloudKit
   var title: String = ""
   var notes: String? = nil
   ```

2. **No `@Attribute(.unique)`**:
   - CloudKit does not support distributed uniqueness constraints.
   - Using `@Attribute(.unique)` will cause CloudKit schema initialization to abort.

3. **Relationships Must Be Optional**:
   - Relationships must be optional (`var project: Project?`) because records can be synced out-of-order over the network.

---

## 2. CloudKit Model Container Setup

```swift
import SwiftData
import SwiftUI

@main
struct TaskApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Project.self, TaskItem.self])
        let config = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false,
            cloudKitDatabase: .private("iCloud.com.mycompany.taskapp")
        )
        
        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Failed to configure SwiftData CloudKit Container: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
```
