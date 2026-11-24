# Core Data Stack & Thread Concurrency

`NSManagedObjectContext` instances are strictly bound to the queue/thread that created them.

---

## 1. Modern Stack Setup

```swift
import CoreData

final class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DataModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        // Enable persistent history tracking
        container.persistentStoreDescriptions.first?.setOption(
            true as NSNumber,
            forKey: NSPersistentHistoryTrackingKey
        )
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved Core Data error: \(error), \(error.userInfo)")
            }
        }
        
        // Automatically merge background writes into main viewContext
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
```

---

## 2. The `perform` Pattern

Never access managed properties without `perform`:

```swift
// ❌ Dangerous: Accessing background object directly on main thread
func updateTitle(item: MyEntity) {
    item.title = "New Title" // 💥 Thread violation crash!
}

// ✅ Safe: Explicit context block
func updateTitle(item: MyEntity) {
    let context = item.managedObjectContext
    context?.perform {
        item.title = "New Title"
        try? context?.save()
    }
}
```

---

## 3. Passing Data Across Contexts via `NSManagedObjectID`

```swift
func processItemInBackground(objectID: NSManagedObjectID) {
    PersistenceController.shared.container.performBackgroundTask { context in
        do {
            let item = try context.existingObject(with: objectID) as! MyEntity
            item.processed = true
            try context.save()
        } catch {
            print("Failed to fetch object: \(error)")
        }
    }
}
```
