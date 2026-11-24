# App Entities & Entity Queries

`AppEntity` represents a searchable, selectable object from your app (like a document, contact, or task).

---

## 1. Declaring an `AppEntity`

```swift
import AppIntents

struct ProjectEntity: AppEntity {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Project"
    
    var id: String
    var name: String
    var taskCount: Int
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: "\(name)",
            subtitle: "\(taskCount) active tasks",
            image: .init(systemName: "folder.fill")
        )
    }
    
    static var defaultQuery = ProjectEntityQuery()
}
```

---

## 2. Implementing the `EntityQuery`

The query allows Siri and Shortcuts to find entities:

```swift
struct ProjectEntityQuery: EntityQuery, EntityStringQuery {
    // 1. Fetch by IDs
    func entities(for identifiers: [String]) async throws -> [ProjectEntity] {
        await ProjectStore.shared.projects(with: identifiers)
    }
    
    // 2. Suggested entities (shown in dropdown menus)
    func suggestedEntities() async throws -> [ProjectEntity] {
        await ProjectStore.shared.allActiveProjects()
    }
    
    // 3. String search for Siri voice matching
    func entities(matching string: String) async throws -> [ProjectEntity] {
        await ProjectStore.shared.search(query: string)
    }
}
```
