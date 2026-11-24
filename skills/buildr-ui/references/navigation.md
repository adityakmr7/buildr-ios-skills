# Modern SwiftUI Navigation Architecture

Modern SwiftUI (iOS 16.0+, standard in iOS 17+) utilizes `NavigationStack` with explicit type-based path routing.

---

## 1. Type-Safe Path Navigation Pattern

Define destinations as hashable Swift enums:

```swift
enum AppRoute: Hashable {
    case orderDetail(orderId: String)
    case userProfile(userId: String)
    case settings
}

struct MainContainerView: View {
    @State private var navPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            List {
                Button("View Order #1024") {
                    navPath.append(AppRoute.orderDetail(orderId: "1024"))
                }
                Button("My Profile") {
                    navPath.append(AppRoute.userProfile(userId: "user_42"))
                }
            }
            .navigationTitle("Dashboard")
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .orderDetail(let orderId):
                    OrderDetailView(orderId: orderId)
                case .userProfile(let userId):
                    UserProfileView(userId: userId)
                case .settings:
                    SettingsView()
                }
            }
        }
    }
}
```

### Benefits:
- **Pop to Root**: `navPath.removeLast(navPath.count)` effortlessly resets the navigation tree.
- **Deep Linking**: Decode an array of routes directly from a push notification payload or URL and assign to `navPath`.

---

## 2. Multi-Column Navigation (`NavigationSplitView`)

For iPad, Mac, and large-screen adaptability, use `NavigationSplitView`:

```swift
struct AdaptiveRootView: View {
    @State private var selectedCategory: Category?
    @State private var selectedItem: Item?
    
    var body: some View {
        NavigationSplitView {
            // Sidebar
            List(Category.allCases, id: \.self, selection: $selectedCategory) { category in
                Text(category.title)
            }
            .navigationTitle("Categories")
        } content: {
            // Column 2: Items list
            if let category = selectedCategory {
                List(category.items, id: \.self, selection: $selectedItem) { item in
                    Text(item.name)
                }
                .navigationTitle(category.title)
            } else {
                ContentUnavailableView("Select a Category", systemImage: "folder")
            }
        } detail: {
            // Column 3: Detail view
            if let item = selectedItem {
                ItemDetailView(item: item)
            } else {
                ContentUnavailableView("Select an Item", systemImage: "doc.text")
            }
        }
    }
}
```
