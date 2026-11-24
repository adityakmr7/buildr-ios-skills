# Tactile Press Feedback & Sensory Haptics

Make buttons and cards feel like real physical objects responding to user touch.

---

## 1. The Tactile Scale Button Style

Buttons should depress slightly (`scaleEffect(0.96)`) when pressed, using an interruptible spring:

```swift
import SwiftUI

struct TactileButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.65), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == TactileButtonStyle {
    static var tactile: TactileButtonStyle { TactileButtonStyle() }
}

// Usage on any button or card:
Button(action: handleAction) {
    CardView()
}
.buttonStyle(.tactile)
```

---

## 2. Native Sensory Haptics (iOS 17+)

Attach crisp physical feedback directly to state changes:

```swift
struct TaskRow: View {
    @Binding var isCompleted: Bool
    
    var body: some View {
        HStack {
            Text("Complete onboarding")
            Spacer()
            Toggle("", isOn: $isCompleted)
        }
        // Triggers a light physical impact when toggled
        .sensoryFeedback(.impact(weight: .light), trigger: isCompleted)
    }
}
```

### Haptic Feedback Types:
- `.sensoryFeedback(.selection, trigger: tabIndex)`: For page/tab switches.
- `.sensoryFeedback(.impact(weight: .light), trigger: value)`: For normal buttons and toggles.
- `.sensoryFeedback(.success, trigger: orderConfirmed)`: For completed milestones or checkout.
- `.sensoryFeedback(.warning, trigger: nearLimit)`: For reaching quotas.
