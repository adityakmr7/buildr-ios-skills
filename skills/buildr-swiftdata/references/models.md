# SwiftData Model Schemas & Relationships

Defining clean, reliable `@Model` schemas is the foundation of SwiftData persistence.

---

## 1. Defining a Model

```swift
import SwiftData
import Foundation

@Model
final class Project {
    // Unique constraint: SwiftData automatically upserts based on this key
    // Note: Do NOT use @Attribute(.unique) if syncing with CloudKit!
    @Attribute(.unique) var id: String
    var title: String
    var createdAt: Date
    var isArchived: Bool
    
    // Explicit relationship with inverse and delete rule
    @Relationship(deleteRule: .cascade, inverse: \TaskItem.project)
    var tasks: [TaskItem] = []
    
    init(id: String = UUID().uuidString, title: String, createdAt: Date = .now, isArchived: Bool = false) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.isArchived = isArchived
    }
}

@Model
final class TaskItem {
    var id: String
    var text: String
    var isCompleted: Bool
    var project: Project?
    
    init(id: String = UUID().uuidString, text: String, isCompleted: Bool = false, project: Project? = nil) {
        self.id = id
        self.text = text
        self.isCompleted = isCompleted
        self.project = project
    }
}
```

---

## 2. Relationship Delete Rules

Always specify an explicit `deleteRule:`

| Delete Rule | Behavior when Parent is Deleted | When to Use |
| :--- | :--- | :--- |
| **`.cascade`** | Automatically deletes all related child records. | Parent-child ownership (e.g., deleting a Project deletes its Tasks). |
| **`.nullify`** | Sets child's foreign key reference to `nil`. | Shared or optional relationships (e.g., deleting a Tag removes it from Posts without deleting Posts). |
| **`.deny`** | Blocks deletion of the parent if any related children exist. | Critical referential integrity (e.g., cannot delete Account while Transactions exist). |
| **`.noAction`** | Does nothing; leaves child pointing to deleted ID. | Rarely used; can cause dangling pointers. |
