# Semantic Colors, Materials & Typography

To ensure automatic, flawless Light Mode and Dark Mode support and high contrast accessibility, never hardcode colors or arbitrary font metrics.

---

## 1. Semantic System Colors

| Semantic Color | Purpose |
| :--- | :--- |
| `Color(uiColor: .systemBackground)` | Primary window or screen canvas in standard views. |
| `Color(uiColor: .secondarySystemBackground)` | Neutral layer above primary background. |
| `Color(uiColor: .systemGroupedBackground)` | Background for grouped tables, settings screens, and feeds. |
| `Color(uiColor: .secondarySystemGroupedBackground)` | The card surface on top of `systemGroupedBackground`. |
| `.primary` | Primary text and high-emphasis icons. |
| `.secondary` | Subtitles, labels, timestamps, and secondary metadata. |
| `.tertiary` | Placeholder text, disabled glyphs, subtle dividers. |
| `.tint` | Interactive accent color matching user/app theme. |

```swift
// ✅ Flawless grouped card pattern in Light & Dark mode
VStack {
    Text("Account")
        .foregroundStyle(.primary)
    Text("Active")
        .foregroundStyle(.secondary)
}
.padding(16)
.background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
```

---

## 2. Background Materials

SwiftUI materials create translucent frosted-glass depth that automatically blurs content beneath:

- `.background(.ultraThinMaterial)`: Subtle blur for toolbars, search bars, floating bars.
- `.background(.thinMaterial)`: Floating controls, quick action menus.
- `.background(.regularMaterial)`: Standard sheet or popover surfaces.
- `.background(.thickMaterial)`: High-opacity surfaces needing legible text over busy graphics.

```swift
// Floating bottom action bar
HStack {
    Button("Bookmark", systemImage: "bookmark") { }
    Spacer()
    Button("Share", systemImage: "square.and.arrow.up") { }
}
.padding(.horizontal, 24)
.padding(.vertical, 12)
.background(.ultraThinMaterial, in: Capsule())
.shadow(color: .black.opacity(0.08), radius: 10, y: 4)
```

---

## 3. Typography Hierarchy

Use Apple's semantic Dynamic Type styles:

```swift
Text("Large Title")  // .font(.largeTitle) -> Screen intros
Text("Screen Title") // .font(.title) / .title2 / .title3 -> Section headers
Text("Card Headline")// .font(.headline) -> Semibold row / card title
Text("Body Content") // .font(.body) -> Standard paragraphs
Text("Subheadline")  // .font(.subheadline) -> Supporting subtitles
Text("Footnote")     // .font(.footnote) -> Timestamps, micro-labels
Text("Caption")      // .font(.caption) / .caption2 -> Smallest metadata
```
