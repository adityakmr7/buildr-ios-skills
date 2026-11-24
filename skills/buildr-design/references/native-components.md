# Native Components First

Before designing a bespoke custom UI element, always evaluate whether a native SwiftUI component already solves the problem with built-in accessibility, keyboard navigation, and platform familiarity.

---

## 1. Native Components Quick Reference

| Custom Tendency (Avoid) | Native SwiftUI Component | Advantage |
| :--- | :--- | :--- |
| Custom progress circle / ring | `Gauge(value:current, in: 0...100) { ... }` | Supports `.accessoryCircular`, `.linear`, `.battery` styles natively. |
| Custom dropdown popup | `Menu { ... } label: { ... }` | Full system menu behavior, haptics, and accessibility. |
| Custom segmented bar | `Picker("Filter", selection: $val) { ... }.pickerStyle(.segmented)` | Standard Apple segmented switch with haptics. |
| Custom key-value row layout | `LabeledContent("Storage", value: "64 GB")` | Automatically aligns and adapts to Dynamic Type. |
| Custom empty illustration | `ContentUnavailableView(...)` | Perfect Apple styling for zero-states and search results. |
| Custom form layout | `Form { Section(...) { ... } }` | Native grouped background, insets, and safe-area adjustments. |

---

## 2. Examples

### Native `LabeledContent`
```swift
// ✅ Clean, native, dynamic-type ready key-value pairs
List {
    Section("Device Specs") {
        LabeledContent("Model", value: "iPhone 16 Pro")
        LabeledContent("Battery Health", value: "98%")
        LabeledContent("iCloud Sync") {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
        }
    }
}
```

### Native `Gauge`
```swift
// ✅ Replaces complex custom circular drawing code
Gauge(value: batteryLevel, in: 0...100) {
    Text("Battery")
} currentValueLabel: {
    Text("\(Int(batteryLevel))%")
}
.gaugeStyle(.accessoryCircular)
.tint(batteryLevel < 20 ? .red : .green)
```
