# Naming Conventions for Types, Protocols & Properties

---

## 1. Types and Protocols

- **Types** (structs, classes, enums, actors) use `UpperCamelCase`:
  `NetworkManager`, `PaymentSession`, `TaskPriority`.
- **Protocols describing capabilities** should end in `-able`, `-ible`, or `-ing`:
  `Equatable`, `Comparable`, `Sendable`, `Identifiable`, `ProgressReporting`.
- **Protocols describing what something is** should be nouns:
  `Collection`, `Sequence`, `View`, `ModelActor`.

---

## 2. Methods and Properties

- **Properties** should be nouns describing what the property holds:
  ```swift
  var title: String // ✅ Noun
  var isEmpty: Bool // ✅ Boolean reads as assertion
  var hasUnsavedChanges: Bool // ✅
  ```
- **Avoid redundant type descriptions**:
  ```swift
  // ❌ Redundant
  var stringTitle: String
  var arrayCount: Int
  
  // ✅ Clean
  var title: String
  var count: Int
  ```

---

## 3. Factory Methods

Methods that produce and return a new object without mutating should start with `make`:

```swift
// ✅ Idiomatic factory naming
func makeIterator() -> Iterator
func makePaymentRequest() -> PaymentRequest
```
