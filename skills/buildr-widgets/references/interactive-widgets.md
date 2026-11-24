# Interactive Widgets & Widget Reloads

In iOS 17+, buttons and toggles in widgets trigger `AppIntent` directly without launching the app.

---

## 1. Triggering Reload After Intent Execution

Whenever an intent modifies data shown on a widget, tell `WidgetCenter` to reload:

```swift
import AppIntents
import WidgetKit

struct ToggleTaskIntent: AppIntent {
    static var title: LocalizedStringResource = "Toggle Task"
    
    @Parameter(title: "Task ID")
    var taskId: String
    
    init(taskId: String) { self.taskId = taskId }
    init() { }
    
    func perform() async throws -> some IntentResult {
        await TaskStore.shared.toggle(id: taskId)
        
        // ⚡️ Essential: Invalidate widget cache so UI refreshes immediately!
        WidgetCenter.shared.reloadTimelines(ofKind: "TaskWidget")
        
        return .result()
    }
}
```
