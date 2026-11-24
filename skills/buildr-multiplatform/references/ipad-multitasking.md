# iPadOS Multitasking & Stage Manager

With Stage Manager and Split View, iPad apps can be resized to arbitrary dimensions on the fly.

---

## 1. Dynamic Layouts

Never check device idiom (`UIDevice.current.userInterfaceIdiom == .pad`) to decide layout:
- An iPad app running in 1/3 Split Screen has the exact same compact width as an iPhone SE.
- Always check `@Environment(\.horizontalSizeClass)` or use `ViewThatFits`.

```swift
struct AdaptiveFeedView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            // 1-column list on iPhone portrait or 1/3 iPad split screen
            FeedListView()
        } else {
            // Multi-column grid on fullscreen iPad or Mac
            FeedGridView()
        }
    }
}
```
