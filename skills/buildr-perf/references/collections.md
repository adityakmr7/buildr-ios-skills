# Scroll Performance & Collections: `List` vs `LazyVStack`

Scroll hitches occur when the main thread takes longer than 8.3ms (120Hz ProMotion) or 16.6ms (60Hz) to prepare a frame.

---

## 1. Choosing Between `List` and `LazyVStack`

| Feature | `List` (UIKit UICollectionView) | `LazyVStack` (Pure SwiftUI) |
| :--- | :--- | :--- |
| **Cell Recycling** | ✅ Full recycling of offscreen cells (Low memory). | ❌ Cells are created lazily on scroll, but **kept in memory** once instantiated! |
| **Performance with 1,000+ items** | ⭐ High speed, constant memory. | ⚠️ Memory climbs continuously; can cause OOM crash. |
| **Custom Layout Flexibility** | Moderate (standard iOS table styling). | High (freeform layouts, arbitrary animations). |
| **Separators & Swipe Actions** | Built-in (`.swipeActions`, separators). | Requires manual implementation. |

**Rule of Thumb**: For large or infinite feeds (>50 items), always use `List`. For small, custom dashboard layouts, use `LazyVStack`.

---

## 2. Eliminating Scroll Hitches

1. **Never Decode Images on the Main Thread**:
   - Use `AsyncImage` or background downsampling with `ImageIO` before assigning to SwiftUI `Image`.
2. **Stable Identifiers in `ForEach`**:
   - Avoid `ForEach(0..<items.count, id: \.self)`. Use unique stable IDs (`id: \.id`).
3. **Pre-Calculate Row Heights**:
   - Avoid rows that drastically expand or shrink during scrolling as this forces the collection to recalculate content offsets.
