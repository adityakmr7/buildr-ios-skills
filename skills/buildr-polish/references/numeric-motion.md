# Tabular Numerics & Choreographed Motion

Preventing UI jitter when numbers change, and animating views with intentional rhythm.

---

## 1. Preventing Number Jitter with `.monospacedDigit()`

Proportional fonts assign different widths to different numbers (e.g., `"1"` is narrower than `"8"`). As countdowns, stopwatches, or prices change, proportional numbers cause labels and surrounding views to shake horizontally:

```swift
// ❌ Shakes horizontally on every tick:
Text("\(timeRemaining)s")
    .font(.title)

// ✅ Rock-solid: Digits take equal width without changing the letter font
Text("\(timeRemaining)s")
    .font(.title)
    .monospacedDigit()
```

---

## 2. Smooth Number Transitions (iOS 17+)

Roll numbers up and down smoothly when state updates:

```swift
Text(score, format: .number)
    .font(.largeTitle.bold())
    .monospacedDigit()
    .contentTransition(.numericText(value: Double(score)))
    .animation(.snappy, value: score)
```

---

## 3. Staggered Entrance Choreography

When loading a dashboard or feed, animating elements simultaneously creates a wall of visual noise. Staggering entrances by ~40-60ms feels natural and fluid:

```swift
struct StaggeredCardList: View {
    let items: [Item]
    @State private var didAppear = false
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                CardRow(item: item)
                    .opacity(didAppear ? 1 : 0)
                    .offset(y: didAppear ? 0 : 20)
                    .animation(
                        .spring(response: 0.4, dampingFraction: 0.8)
                        .delay(Double(index) * 0.05), // Stagger delay!
                        value: didAppear
                    )
            }
        }
        .onAppear { didAppear = true }
    }
}
```
