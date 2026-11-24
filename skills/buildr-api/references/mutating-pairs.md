# Mutating and Non-Mutating Method Pairs

Swift has strict rules for naming method pairs that differ only in whether they mutate the receiver in place or return a new copy.

---

## 1. The Verb Rule

When the operation is naturally described by a **verb**:
- The **mutating** variant is the plain imperative verb.
- The **non-mutating** variant uses the `-ed` or `-ing` suffix.

| Mutating (In-place) | Non-Mutating (Returns copy) |
| :--- | :--- |
| `array.sort()` | `let s = array.sorted()` |
| `array.reverse()` | `let r = array.reversed()` |
| `path.stripLeadingWhitespace()` | `let p = path.strippingLeadingWhitespace()` |
| `string.append(suffix)` | `let s = string.appending(suffix)` |

---

## 2. The Noun Rule

When the operation is naturally described by a **noun**:
- The **non-mutating** variant is the plain noun.
- The **mutating** variant uses the `form-` prefix.

| Non-Mutating (Returns copy) | Mutating (In-place) |
| :--- | :--- |
| `let u = setA.union(setB)` | `setA.formUnion(setB)` |
| `let i = setA.intersection(setB)` | `setA.formIntersection(setB)` |
| `let d = setA.symmetricDifference(setB)` | `setA.formSymmetricDifference(setB)` |

---

## 3. Boolean Properties and Methods

Non-mutating boolean queries should read as assertions about the receiver:
- `isEmpty`
- `hasPrefix(_:)`
- `canPerformAction(_:)`
- `supportsHaptics`
