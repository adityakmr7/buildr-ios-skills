# SwiftData Concurrency & `ModelActor`

SwiftData objects are bound to the `ModelContext` that created them. Accessing a model from another thread or actor causes data corruption and crashes.

---

## 1. The `ModelActor` Pattern

Use the `@ModelActor` macro to safely isolate background database operations:

```swift
import SwiftData
import Foundation

@ModelActor
actor DataIngestionService {
    // The @ModelActor macro automatically provides:
    // - nonisolated let modelExecutor: any ModelExecutor
    // - nonisolated let modelContainer: ModelContainer
    // - var modelContext: ModelContext { get }
    
    func importRemotePayloads(_ payloads: [RemoteTaskDTO]) throws {
        for dto in payloads {
            let item = TaskItem(
                id: dto.id,
                text: dto.text,
                isCompleted: dto.isCompleted
            )
            modelContext.insert(item)
        }
        
        // Save the isolated background context
        try modelContext.save()
    }
    
    func deleteOldTasks(before date: Date) throws {
        try modelContext.delete(model: TaskItem.self, where: #Predicate { $0.isCompleted })
        try modelContext.save()
    }
}
```

---

## 2. Crossing Actor Boundaries with `PersistentIdentifier`

Never return or pass `@Model` instances directly between actors:

```swift
// ❌ Dangerous: Passing model across actor boundaries
let task = try await ingestionService.getTask()
print(task.title) // 💥 Crash! Accessed from different actor

// ✅ Safe: Pass PersistentIdentifier (it conforms to Sendable)
actor TaskService {
    func createTask(text: String) throws -> PersistentIdentifier {
        let task = TaskItem(text: text)
        modelContext.insert(task)
        try modelContext.save()
        return task.id // PersistentIdentifier is Sendable!
    }
}

// On @MainActor:
let taskId = try await taskService.createTask(text: "Buy Milk")
let mainContext = container.mainContext
if let localTask = mainContext.model(for: taskId) as? TaskItem {
    // Safe to use on MainActor
    print(localTask.text)
}
```
