# SwiftData Schema Versioning & Migrations

When your data model changes between app releases, you must version the schema to prevent data loss or crashes.

---

## 1. Defining Versioned Schemas

```swift
import SwiftData

// Step 1: Version 1 Schema
enum SchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] { [Project.self] }
    
    @Model
    final class Project {
        var title: String = ""
        var isArchived: Bool = false
        
        init(title: String, isArchived: Bool = false) {
            self.title = title
            self.isArchived = isArchived
        }
    }
}

// Step 2: Version 2 Schema (Added 'priority' field)
enum SchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(2, 0, 0)
    static var models: [any PersistentModel.Type] { [Project.self] }
    
    @Model
    final class Project {
        var title: String = ""
        var isArchived: Bool = false
        var priority: Int = 1 // New property with default
        
        init(title: String, isArchived: Bool = false, priority: Int = 1) {
            self.title = title
            self.isArchived = isArchived
            self.priority = priority
        }
    }
}
```

---

## 2. Schema Migration Plan

```swift
enum ProjectMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [SchemaV1.self, SchemaV2.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
    // Lightweight migration stage (adding non-conflicting property with default)
    static let migrateV1toV2 = MigrationStage.lightweight(
        fromVersion: SchemaV1.self,
        toVersion: SchemaV2.self
    )
}
```

---

## 3. Initializing with the Migration Plan

```swift
let container = try ModelContainer(
    for: SchemaV2.Project.self,
    migrationPlan: ProjectMigrationPlan.self,
    configurations: ModelConfiguration()
)
```
