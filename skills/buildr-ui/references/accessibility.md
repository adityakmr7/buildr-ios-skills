# SwiftUI Accessibility Reference

Building accessible apps is a core requirement of Apple platform excellence.

---

## 1. The 44x44pt Touch Target Rule

Every tappable element must have a minimum interactive hit area of 44x44 points, regardless of how small the visual glyph is.

```swift
// ❌ Bad: Visual icon is 16x16; hit target is only 16x16!
Button(action: deleteItem) {
    Image(systemName: "trash")
        .frame(width: 16, height: 16)
}

// ✅ Correct: Visual icon stays 16x16, but hit testing expands to 44x44
Button(action: deleteItem) {
    Image(systemName: "trash")
        .frame(width: 16, height: 16)
        .frame(minWidth: 44, minHeight: 44)
        .contentShape(Rectangle()) // Ensures transparent padding remains tappable
}
```

---

## 2. VoiceOver Elements & Compound Labels

Group related visual information into a single cohesive VoiceOver announcement:

```swift
// ❌ Bad: VoiceOver reads 3 disjointed elements: "5", "Stars", "482 Reviews"
HStack {
    Text("5")
    Image(systemName: "star.fill")
    Text("482 Reviews")
}

// ✅ Correct: Combined accessibility element with semantic label
HStack {
    Text("5")
    Image(systemName: "star.fill")
    Text("(482)")
}
.accessibilityElement(children: .combine)
.accessibilityLabel("Rating: 5 out of 5 stars from 482 reviews")
```

---

## 3. Accessibility Traits & Values

Always ensure custom interactive controls behave like standard controls for assistive technologies:

```swift
Toggle(isOn: $isEnabled) {
    Text("Dark Mode")
}
// Native Toggle handles traits automatically.

// If building a custom toggle/stepper:
CustomCheckmarkView(isChecked: isCompleted)
    .accessibilityAddTraits(isCompleted ? [.isButton, .isSelected] : .isButton)
    .accessibilityLabel("Task completed")
```

---

## 4. Supporting Reduce Motion

Respect user preferences when animating:

```swift
struct SmoothCardView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            // View content...
        }
        .animation(reduceMotion ? nil : .spring(duration: 0.3), value: isExpanded)
    }
}
```
