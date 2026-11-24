# Legacy Formatters vs Modern `FormatStyle`

Why you must stop using legacy formatters:
1. `DateFormatter` and `NumberFormatter` are heavyweight reference classes that are expensive to allocate.
2. They are **not thread-safe** across concurrent threads.
3. Hardcoding date strings like `"dd/MM/yyyy"` breaks in regions with different conventions.

---

## Side-by-Side Comparison

### 1. Currency Formatting
```swift
// ❌ Legacy & Slow:
let formatter = NumberFormatter()
formatter.numberStyle = .currency
formatter.currencyCode = "USD"
let string = formatter.string(from: NSNumber(value: 49.99))

// ✅ Modern & Fast (FormatStyle):
let string = 49.99.formatted(.currency(code: "USD"))
```

### 2. Date Formatting
```swift
// ❌ Legacy & Fragile:
let formatter = DateFormatter()
formatter.dateStyle = .medium
formatter.timeStyle = .short
let string = formatter.string(from: Date.now)

// ✅ Modern (FormatStyle):
let string = Date.now.formatted(date: .abbreviated, time: .shortened)
```

### 3. SwiftUI Integration
```swift
// ❌ Legacy String Interpolation:
Text(formatter.string(from: order.date) ?? "")

// ✅ Modern Declarative Format Binding:
Text(order.date, format: .dateTime.month().day().year())
Text(order.total, format: .currency(code: "USD"))
```
