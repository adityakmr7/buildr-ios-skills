# `TimelineProvider` & Reload Policies

The `TimelineProvider` controls when and what content WidgetKit displays.

---

## 1. Basic Provider Implementation

```swift
import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
    let score: Int
}

struct ScoreTimelineProvider: TimelineProvider {
    // 1. Placeholder shown during gallery loading
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: .now, score: 0)
    }
    
    // 2. Snapshot shown in widget gallery preview
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: .now, score: 95)
        completion(entry)
    }
    
    // 3. Generating the actual timeline
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let currentDate = Date.now
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: currentDate)!
        
        let entry = SimpleEntry(date: currentDate, score: ScoreStore.shared.latestScore())
        
        // Schedule next reload in 30 minutes
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}
```

---

## 2. Choosing Timeline Policies

- **`.after(date)`**: Use when you know when data changes next (e.g., calendar events, hourly weather).
- **`.atEnd`**: Use when entries represent a finite sequence (e.g., flight timeline) and you want a refresh when the last entry passes.
- **`.never`**: Use when updates only occur via external triggers (e.g. push notification, background fetch, or in-app intent).
