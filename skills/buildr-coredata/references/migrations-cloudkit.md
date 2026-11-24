# Migrations & `NSPersistentCloudKitContainer`

---

## 1. Lightweight Migrations

Core Data performs lightweight migration automatically if you add optional attributes or new entities. Ensure your persistent store description enables:
```swift
description.shouldMigrateStoreAutomatically = true
description.shouldInferMappingModelAutomatically = true
```

---

## 2. `NSPersistentCloudKitContainer`

Syncs Core Data stores across user devices via CloudKit:

```swift
container = NSPersistentCloudKitContainer(name: "DataModel")
```

### Constraints:
- No unique constraints (`@Attribute(.unique)`).
- All relationships must be optional.
- Undefined or non-optional attributes without defaults will prevent cloud sync initialization.
