# Date, Relative Time & Interval Formatting

---

## 1. Standard Date & Time

```swift
let now = Date.now

// Preset convenience
now.formatted(date: .long, time: .omitted)        // "November 24, 2026"
now.formatted(date: .abbreviated, time: .standard) // "Nov 24, 2026, 5:30:15 PM"

// Granular custom composition
now.formatted(
    .dateTime
    .weekday(.wide)
    .month(.abbreviated)
    .day()
) // "Tuesday, Nov 24"
```

---

## 2. Relative Time (e.g. "3 hours ago")

```swift
let pastDate = Date.now.addingTimeInterval(-7200)

let relative = pastDate.formatted(
    .relative(presentation: .named, unitsStyle: .wide)
) // "2 hours ago"
```

---

## 3. Date Intervals & Ranges

```swift
let start = Date.now
let end = start.addingTimeInterval(3600 * 3)

// Formats as "5:00 – 8:00 PM"
let interval = (start..<end).formatted(date: .omitted, time: .shortened)
```

---

## 4. ISO 8601 Parsing and Formatting

```swift
let isoString = Date.now.formatted(.iso8601)

// Parsing ISO string directly into Date:
let parsedDate = try? Date(
    "2026-11-24T12:00:00Z",
    strategy: .iso8601
)
```
