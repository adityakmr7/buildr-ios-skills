# Interactive Widgets & Control Center Controls

In iOS 17+, widgets and Control Center controls trigger `AppIntent` directly without launching the parent app into the foreground.

---

## 1. Interactive Button in a Widget

```swift
import SwiftUI
import AppIntents

struct TaskWidgetEntryView: View {
    var task: TaskItemEntry
    
    var body: some View {
        HStack {
            Text(task.title)
            Spacer()
            // Button executes CompleteTaskIntent in background
            Button(intent: CompleteTaskIntent(taskId: task.id)) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
            }
            .buttonStyle(.plain)
        }
    }
}

struct CompleteTaskIntent: AppIntent {
    static var title: LocalizedStringResource = "Complete Task"
    
    @Parameter(title: "Task ID")
    var taskId: String
    
    init(taskId: String) {
        self.taskId = taskId
    }
    
    init() { }
    
    func perform() async throws -> some IntentResult {
        await TaskManager.shared.markCompleted(id: taskId)
        return .result()
    }
}
```
