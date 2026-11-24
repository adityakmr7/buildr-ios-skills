# Concentric Corner Radii in Nested Layouts

When a rounded card sits inside a padded container, giving both elements the same corner radius looks distorted and amateurish.

---

## 1. The Concentric Formula

To make outer and inner curves concentric (parallel arcs):

$$R_{\text{inner}} = \max(0, R_{\text{outer}} - \text{padding})$$

### Concrete Example:
- **Outer Card**: Radius = `20pt`, Padding = `8pt`
- **Inner Image**: Radius must be $20 - 8 = \mathbf{12pt}$!

```swift
// ❌ Distorted: Both use 20pt radius. The corners look awkward and thick.
VStack {
    Image("hero")
        .clipShape(RoundedRectangle(cornerRadius: 20))
}
.padding(8)
.background(.secondarySystemBackground, in: RoundedRectangle(cornerRadius: 20))

// ✅ Concentric & Harmonious:
VStack {
    Image("hero")
        .clipShape(RoundedRectangle(cornerRadius: 12)) // 20 - 8 = 12
}
.padding(8)
.background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 20))
```

---

## 2. Using `ContainerRelativeShape`

SwiftUI provides `ContainerRelativeShape()`, which calculates concentric corner radii automatically:

```swift
ZStack {
    RoundedRectangle(cornerRadius: 24)
        .fill(Color(uiColor: .secondarySystemBackground))
    
    // Automatically calculates correct radius based on outer container and inset
    Image("avatar")
        .clipShape(ContainerRelativeShape())
        .padding(8)
}
```
