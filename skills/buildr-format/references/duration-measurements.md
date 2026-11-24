# Duration, Measurement, ByteCount & List Formatting

---

## 1. Swift `Duration` (iOS 16+)

```swift
let duration: Duration = .seconds(3725)

// Digital clock format: "1:02:05"
let digital = duration.formatted(.time(pattern: .hourMinuteSecond))

// Expanded textual description: "1 hr, 2 min, 5 sec"
let descriptive = duration.formatted(.units(width: .abbreviated))
```

---

## 2. Physical Measurements (`Measurement<Unit>`)

```swift
let distance = Measurement(value: 5.2, unit: UnitLength.kilometers)

// Automatically converts to user's local unit (miles in US, km in Europe)
let local = distance.formatted(.measurement(width: .abbreviated, usage: .asProvided))
```

---

## 3. Byte Counts (File Sizes)

```swift
let fileSize: Int64 = 15_485_760

let formattedBytes = fileSize.formatted(.byteCount(style: .file))
// "15.5 MB"
```

---

## 4. List Formatting (Natural Language Joins)

Joins arrays into grammatically correct language lists:

```swift
let names = ["Alice", "Bob", "Charlie"]

let listDisplay = names.formatted(.list(type: .and, width: .standard))
// English: "Alice, Bob, and Charlie"
// Spanish: "Alice, Bob y Charlie"
```
