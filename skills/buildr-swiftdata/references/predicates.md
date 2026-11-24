# Safe `#Predicate` Macros & Querying

SwiftData converts `#Predicate` closures into underlying CoreData/SQLite SQL queries. If an unsupported Swift expression is used, it will either fail to compile or throw a runtime crash.

---

## 1. Supported Predicate Operations

```swift
// ✅ Case-insensitive localized string matching
let query = "urgent"
let predicate = #Predicate<TaskItem> { task in
    task.text.localizedStandardContains(query) && !task.isCompleted
}

// ✅ Number and Date comparisons
let cutoff = Date.now.addingTimeInterval(-86400 * 7)
let recentPredicate = #Predicate<Project> { project in
    project.createdAt > cutoff && project.isArchived == false
}

// ✅ Sub-collection checking
let hasUrgentTasks = #Predicate<Project> { project in
    project.tasks.contains { $0.text.contains("Urgent") }
}
```

---

## 2. Expressions That Crash or Fail

### ❌ Regex matching directly inside predicate:
```swift
// ❌ FAILS: SwiftData cannot translate NSRegularExpression into SQL
let bad = #Predicate<TaskItem> { $0.text.matches(of: regex).count > 0 }
```

### ❌ Calling arbitrary Swift methods or closures:
```swift
// ❌ FAILS: Custom Swift methods cannot be converted to SQLite WHERE clauses
let bad = #Predicate<TaskItem> { customValidationFunction($0.text) }
```

### ❌ Nil-coalescing with complex expressions:
```swift
// ⚠️ Can fail: Prefer explicit optional binding or checks
let safe = #Predicate<TaskItem> { ($0.project != nil) }
```

---

## 3. Querying with `FetchDescriptor`

```swift
func fetchActiveProjects(context: ModelContext) throws -> [Project] {
    var descriptor = FetchDescriptor<Project>(
        predicate: #Predicate { !$0.isArchived },
        sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
    )
    descriptor.fetchLimit = 50
    return try context.fetch(descriptor)
}
```
