# High-Performance Batch Operations

Traditional Core Data imports instantiate thousands of managed objects into memory, causing high RAM usage and CPU stalls. Batch operations operate directly at the SQLite store level.

---

## 1. `NSBatchInsertRequest`

Insert thousands of dictionaries in milliseconds:

```swift
func batchInsertUsers(dictionaries: [[String: Any]]) async throws {
    let container = PersistenceController.shared.container
    
    try await container.performBackgroundTask { context in
        let batchInsert = NSBatchInsertRequest(
            entity: UserEntity.entity(),
            objects: dictionaries
        )
        batchInsert.resultType = .statusOnly
        
        try context.execute(batchInsert)
    }
}
```

---

## 2. `NSBatchDeleteRequest`

Delete entire collections without fetching entities into memory:

```swift
func purgeExpiredSessions() throws {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = SessionEntity.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "expiresAt < %@", Date.now as NSDate)
    
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    deleteRequest.resultType = .resultTypeObjectIDs
    
    let result = try context.execute(deleteRequest) as? NSBatchDeleteResult
    if let objectIDs = result?.result as? [NSManagedObjectID] {
        // Merge deleted IDs to notify viewContext
        let changes = [NSDeletedObjectsKey: objectIDs]
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [PersistenceController.shared.container.viewContext])
    }
}
```
