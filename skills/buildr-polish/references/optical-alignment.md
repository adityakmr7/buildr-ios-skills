# Optical Alignment & SF Symbol Weight Matching

Human vision perceives visual weight differently from strict bounding-box geometry.

---

## 1. Optical Centering of Asymmetric Glyphs

Triangles, play icons, and chevron arrows have more visual mass on one side than the other. When placed inside a circle or square, centering them mathematically makes them appear too far to the left:

```swift
// ❌ Mathematically centered, but looks skewed left:
ZStack {
    Circle().fill(.tint).frame(width: 48, height: 48)
    Image(systemName: "play.fill")
        .foregroundStyle(.white)
}

// ✅ Optically centered: 1.5pt right offset balances the visual weight
ZStack {
    Circle().fill(.tint).frame(width: 48, height: 48)
    Image(systemName: "play.fill")
        .foregroundStyle(.white)
        .offset(x: 1.5) // Optical correction
}
```

---

## 2. Matching SF Symbol Stroke Weights to Typography

An icon placed beside bold text with default regular weight looks mismatched and thin:

```swift
// ❌ Mismatched: Font is bold headline, but icon has default regular stroke
HStack {
    Image(systemName: "flame.fill") // Regular weight
    Text("Trending Now")
        .font(.headline.weight(.bold))
}

// ✅ Harmonious: Icon weight explicitly matches text weight
HStack {
    Image(systemName: "flame.fill")
        .font(.headline.weight(.bold)) // Matched!
    Text("Trending Now")
        .font(.headline.weight(.bold))
}
```
