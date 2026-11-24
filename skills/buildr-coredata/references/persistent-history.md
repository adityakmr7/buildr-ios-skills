# Persistent History Tracking

When data is inserted via background contexts or app extensions (like widgets), persistent history tracking captures and merges those changes into the main view context.

---

## 1. Merging History Changes

```swift
func processHistoryTransactions() {
    let context = PersistenceController.shared.container.newBackgroundContext()
    context.perform {
        let request = NSPersistentHistoryChangeRequest.fetchHistory(after: self.lastToken)
        guard let result = try? context.execute(request) as? NSPersistentHistoryResult,
              let transactions = result.result as? [NSPersistentHistoryTransaction] else {
            return
        }
        
        for transaction in transactions {
            PersistenceController.shared.container.viewContext.perform {
                PersistenceController.shared.container.viewContext.mergeChanges(fromContextDidSave: transaction.objectIDNotification())
            }
            self.lastToken = transaction.token
        }
    }
}
```
