# Numeric Formatting: Currency, Percentages & Decimals

---

## 1. Currency

```swift
// Automatic currency formatting with locale symbol
let price: Decimal = 129.50
let display = price.formatted(.currency(code: "USD")) 
// Output in US: "$129.50"

// Custom grouping and fraction digits:
let precise = price.formatted(
    .currency(code: "EUR")
    .precision(.fractionLength(2...4))
    .presentation(.narrow)
)
```

---

## 2. Percentages

```swift
let progress = 0.854

// Formatted as 85%
let basic = progress.formatted(.percent)

// Formatted with decimals: "85.4%"
let detailed = progress.formatted(
    .percent.precision(.fractionLength(1))
)
```

---

## 3. Numbers & Sign Display

```swift
let delta = 42

// Force display of positive sign: "+42"
let withSign = delta.formatted(
    .number.sign(strategy: .always())
)

// Notation (Compact): "1.2M" instead of "1,200,000"
let subscribers = 1_234_567
let compact = subscribers.formatted(
    .number.notation(.compactName)
)
```
