# WidgetKit Design Principles & Glanceability

Widgets are **not mini-apps**; they are glanceable projections of timely, personal content.

---

## 1. The 3-Second Rule

A user looks at a widget for an average of 2 to 3 seconds. 
- Show **one clear piece of information** or at most 2–3 high-priority metrics.
- Avoid cluttered rows, tiny font walls, or interactive inputs (beyond buttons / toggles in iOS 17+).

---

## 2. Corner Radiuses & Geometry

Never hardcode corner radiuses for widgets or widget elements:
- Use `.containerBackground(for: .widget) { ... }` (iOS 17+).
- Use `ContainerRelativeShape()` for inner cards so their curvature matches the widget's hardware corners exactly.

```swift
struct TaskWidgetEntryView: View {
    var entry: TaskEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "checklist")
                    .foregroundStyle(.tint)
                Text("Next Up")
                    .font(.headline)
            }
            
            Text(entry.topTaskTitle)
                .font(.body.weight(.medium))
                .lineLimit(2)
            
            Spacer()
        }
        .containerBackground(for: .widget) {
            Color(uiColor: .secondarySystemBackground)
        }
    }
}
```

---

## 3. Accessory Widgets (Lock Screen & Apple Watch)

- Always test in monochrome / tinted environments.
- Use `.accessoryInline`, `.accessoryCircular`, and `.accessoryRectangular`.
- Use gauges and SF Symbols with clear semantic shapes.
