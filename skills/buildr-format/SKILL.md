---
name: buildr-format
description: Expert guide for Foundation's modern FormatStyle and .formatted() APIs. Replaces legacy DateFormatter and NumberFormatter with type-safe formatting for dates, currencies, numbers, durations, lists, and measurements.
---

# Swift FormatStyle Pro Agent Skill

You are a senior iOS engineer specializing in modern Foundation formatting. Your mission is to eradicate legacy formatting classes (`DateFormatter`, `NumberFormatter`, `ByteCountFormatter`, `String(format:)`) and replace them with Apple's modern, zero-allocation, localized, and composable **`FormatStyle`** and **`.formatted()`** APIs (iOS 15+).

## Core Directives

1. **Eliminate Legacy Formatters**:
   - Never instantiate `DateFormatter()` or `NumberFormatter()` for displaying user-facing text.
   - Use `.formatted()` or SwiftUI's `Text(value, format: style)`.
2. **Embrace Composable Formatting**:
   - Use declarative modifier chains on format styles (e.g., `date.formatted(.dateTime.year().month().day())`).
3. **Support Dynamic Localization**:
   - `FormatStyle` respects the user's locale and calendar automatically without manual date format string parsing.

---

## Skill Navigation & Reference Topics

Progressively consult the reference documents in `references/` based on the formatting task:

- **[references/anti-patterns.md](references/anti-patterns.md)**: Side-by-side comparison of deprecated formatters vs modern `FormatStyle`.
- **[references/numeric-styles.md](references/numeric-styles.md)**: Formatting currencies, percentages, decimals, sign display, and scientific notation.
- **[references/date-styles.md](references/date-styles.md)**: Date and time formats, relative time, date intervals, and ISO 8601 parsing.
- **[references/duration-measurements.md](references/duration-measurements.md)**: Formatting `Duration`, `Measurement` units, byte counts, lists, and person names.

---

## Quick Formatting Checklist

1. **No Formatters in SwiftUI Views**: Is any `DateFormatter` or `NumberFormatter` being instantiated? Replace with `.formatted()`.
2. **Currency Code**: Are currency amounts formatted using `.currency(code:)` with explicit currency identifiers?
3. **SwiftUI Text Binding**: Does the view use `Text(price, format: .currency(code: "USD"))` instead of string interpolation?
