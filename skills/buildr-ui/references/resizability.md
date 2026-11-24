# SwiftUI Resizability, Layout Adaptability & Dynamic Type

iOS apps run across widely differing form factors: iPhone SE, Pro Max, iPad split views, Stage Manager, and Mac Catalyst.

---

## 1. Dynamic Type Scaling

Never hardcode fixed heights or truncate text with small line limits without accommodating accessibility text sizes.

- Use standard text styles (`.font(.body)`, `.font(.headline)`).
- If custom fonts are required, use `@ScaledMetric`:

```swift
struct CustomBadgeView: View {
    // Scales proportionally with user's Dynamic Type setting
    @ScaledMetric(relativeTo: .body) private var iconSize: CGFloat = 20
    @ScaledMetric(relativeTo: .body) private var badgePadding: CGFloat = 8
    
    var body: some View {
        HStack(spacing: badgePadding) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: iconSize, height: iconSize)
            Text("Pro Member")
                .font(.body)
        }
        .padding(badgePadding)
    }
}
```

---

## 2. Adaptive Layouts with `ViewThatFits`

Instead of checking geometry proxies or device orientation, use `ViewThatFits` to automatically switch between horizontal and vertical orientations when space is constrained:

```swift
struct ActionButtonsBar: View {
    var body: some View {
        ViewThatFits(in: .horizontal) {
            // Try side-by-side first
            HStack(spacing: 12) {
                Button("Cancel", role: .cancel) { }
                    .buttonStyle(.bordered)
                Button("Confirm", role: .none) { }
                    .buttonStyle(.borderedProminent)
            }
            
            // Fallback to stacked when horizontal space runs out
            VStack(spacing: 8) {
                Button("Confirm", role: .none) { }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                Button("Cancel", role: .cancel) { }
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
```

---

## 3. Size Classes

Check horizontal and vertical size classes to adapt layouts:

```swift
struct AdaptiveContainerView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .compact {
            // iPhone portrait or 1/3 iPad split screen
            CompactFeedView()
        } else {
            // iPad fullscreen, Mac, or iPhone landscape
            RegularGridView()
        }
    }
}
```
