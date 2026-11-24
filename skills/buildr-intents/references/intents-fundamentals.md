# App Intents Fundamentals: `AppIntent` & `perform()`

`AppIntent` is the foundational protocol for exposing actions to the system.

---

## 1. Creating a Basic Intent

```swift
import AppIntents
import SwiftUI

struct LogWaterIntakeIntent: AppIntent {
    static var title: LocalizedStringResource = "Log Water Intake"
    static var description = IntentDescription("Records a glass of water to your daily hydration log.")
    
    // Configurable parameter
    @Parameter(title: "Milliliters", default: 250)
    var amount: Int
    
    // Main execution point
    func perform() async throws -> some IntentResult & ProvidesDialog {
        // Perform data update (e.g. through SwiftData ModelActor or database)
        await HydrationManager.shared.addWater(milliliters: amount)
        
        // Return spoken / visual confirmation
        return .result(dialog: "Logged \(amount) ml of water.")
    }
}
```

---

## 2. Confirmation Dialogs & Snippet Views

For sensitive actions (like making payments or deleting items), require confirmation before proceeding:

```swift
struct DeleteProjectIntent: AppIntent {
    static var title: LocalizedStringResource = "Delete Project"
    
    @Parameter(title: "Project")
    var project: ProjectEntity
    
    func perform() async throws -> some IntentResult {
        // Request interactive user confirmation
        try await requestConfirmation(result: .result(dialog: "Are you sure you want to delete \(project.name)?"))
        
        await ProjectManager.shared.delete(id: project.id)
        return .result(dialog: "Project deleted.")
    }
}
```
