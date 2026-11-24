# Pointer Interactions & Keyboard Shortcuts

Elevate iPad and Mac usability with hardware keyboard and trackpad support.

---

## 1. Trackpad Hover Effects

```swift
Button(action: openFavorites) {
    Image(systemName: "star")
        .frame(width: 44, height: 44)
        .contentShape(Rectangle())
}
.hoverEffect(.highlight) // Pointer snaps and transforms to button shape
```

---

## 2. Keyboard Shortcuts

Add desktop-class keyboard navigation:

```swift
Button("New Document", systemImage: "plus") {
    createNewDocument()
}
.keyboardShortcut("n", modifiers: .command) // ⌘N

Button("Search", systemImage: "magnifyingglass") {
    openSearch()
}
.keyboardShortcut("f", modifiers: .command) // ⌘F

Button("Delete", role: .destructive) {
    deleteSelection()
}
.keyboardShortcut(.delete, modifiers: .command) // ⌘⌫
```
