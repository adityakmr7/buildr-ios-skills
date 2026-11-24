# Call-Site Clarity & Argument Labels

The primary goal of Swift API design is **clarity at the point of use**.

---

## 1. Grammatical Phrases

Methods should form grammatical English phrases at the call site:

```swift
// ❌ Poor: Awkward English, redundant type names
list.addNewItem(item: newItem)
database.findRecordMatchingID(id: 123)

// ✅ Clean: Reads naturally at point of use
list.append(newItem)
database.record(matching: 123)
```

---

## 2. Prepositions and Argument Labels

When the first argument forms part of a prepositional phrase, give it an argument label starting with the preposition:

```swift
// ❌ Poor: Preposition buried in method name
func moveTo(point: CGPoint)
func writeTo(url: URL)

// ✅ Clean: Preposition serves as the argument label
func move(to point: CGPoint)
func write(to url: URL)

// Call site:
shape.move(to: origin)
document.write(to: destinationURL)
```

---

## 3. Omitting Argument Labels

Omit argument labels only when the arguments are indistinguishable or obvious from the base name:

```swift
// ✅ Good omissions:
min(10, 20)
zip(names, scores)

// ❌ Bad omission: Unclear what the argument represents
user.update("John") // Is "John" the first name, last name, or username?

// ✅ Correct with explicit label:
user.update(firstName: "John")
```
