# `BGTaskScheduler`: Refresh and Processing Tasks

`BGTaskScheduler` is iOS's modern API for scheduling opportunistic background work.

---

## 1. Registering Tasks at App Launch

Tasks **must** be registered before app launch completes:

```swift
import BackgroundTasks
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    static let refreshTaskID = "com.mycompany.myapp.refresh"
    static let processingTaskID = "com.mycompany.myapp.db-cleanup"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: Self.refreshTaskID,
            using: nil
        ) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        
        return true
    }
}
```

---

## 2. Handling the Task with Expiration Protection

```swift
func handleAppRefresh(task: BGAppRefreshTask) {
    // 1. Schedule next occurrence
    scheduleAppRefresh()
    
    let operationTask = Task {
        let success = await SyncEngine.shared.fetchLatestFeed()
        task.setTaskCompleted(success: success)
    }
    
    // 2. Set expiration handler
    task.expirationHandler = {
        operationTask.cancel()
        task.setTaskCompleted(success: false)
    }
}

func scheduleAppRefresh() {
    let request = BGAppRefreshTaskRequest(identifier: AppDelegate.refreshTaskID)
    request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60) // Earliest 15 mins later
    
    do {
        try BGTaskScheduler.shared.submit(request)
    } catch {
        print("Could not schedule app refresh: \(error)")
    }
}
```
