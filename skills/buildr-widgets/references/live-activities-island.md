# Live Activities & Dynamic Island Presentations

Live Activities project active progress (e.g., food delivery, sports game, workouts) onto the Lock Screen and Dynamic Island.

---

## 1. Defining Attributes & Content State

```swift
import ActivityKit
import SwiftUI
import WidgetKit

struct OrderDeliveryAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var driverName: String
        var estimatedDeliveryTime: Date
        var status: String
    }
    
    // Fixed static attributes
    var orderNumber: String
}
```

---

## 2. Dynamic Island Layout Configuration

```swift
struct OrderDeliveryWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: OrderDeliveryAttributes.self) { context in
            // Lock Screen presentation
            LockScreenLiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded View (on long press)
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "box.truck.fill").font(.title2)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.estimatedDeliveryTime, style: .timer)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.state.status).font(.headline)
                }
            } compactLeading: {
                // Left pill
                Image(systemName: "box.truck.fill")
            } compactTrailing: {
                // Right pill
                Text(context.state.estimatedDeliveryTime, style: .timer)
            } minimal: {
                // When multiple activities are active
                Image(systemName: "box.truck.fill")
            }
        }
    }
}
```
