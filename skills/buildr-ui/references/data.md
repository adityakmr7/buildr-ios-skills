# SwiftUI Modern State Flow & The Observation Framework

Targeting iOS 17+ and iOS 18+ unlocks the **Observation** framework (`import Observation`), completely obsoleting the legacy `ObservableObject` protocol, `@Published` property wrappers, and `@StateObject`.

---

## 1. Property Wrapper Decision Matrix

| Property Wrapper | Primary Use Case | Example |
| :--- | :--- | :--- |
| `@State` | **Value types** local to this view, or **instantiating an `@Observable` model** owned by this view. | `@State private var count = 0`<br/>`@State private var viewModel = ProfileViewModel()` |
| `@Binding` | Two-way connection to a value type owned by an ancestor. | `@Binding var isPresented: Bool` |
| `@Bindable` | Creates bindings to properties of an already-instantiated `@Observable` object. | `@Bindable var user: UserProfile` |
| `@Environment` | Accesses system values or dependency-injected `@Observable` objects. | `@Environment(\.dismiss) private var dismiss`<br/>`@Environment(AuthService.self) private var auth` |

---

## 2. Modern `@Observable` Architecture

```swift
import SwiftUI
import Observation

// 1. Declare the Observable class
@Observable
final class OrderViewModel {
    var items: [OrderItem] = []
    var isProcessing: Bool = false
    var promoCode: String = ""
    
    var totalPrice: Decimal {
        items.reduce(0) { $0 + $1.price }
    }
    
    func placeOrder() async {
        isProcessing = true
        defer { isProcessing = false }
        // Network execution...
    }
}

// 2. View Instantiation & Two-way Binding
struct OrderSummaryView: View {
    // View OWNS the lifecycle of the model using @State
    @State private var viewModel = OrderViewModel()
    
    var body: some View {
        // Use @Bindable to create $ bindings to properties of an @Observable instance
        @Bindable var vm = viewModel
        
        NavigationStack {
            Form {
                Section("Summary") {
                    Text("Total: \(viewModel.totalPrice.formatted(.currency(code: "USD")))")
                    TextField("Promo Code", text: $vm.promoCode)
                }
                
                Button("Place Order") {
                    Task { await viewModel.placeOrder() }
                }
                .disabled(viewModel.isProcessing)
            }
            .navigationTitle("Checkout")
        }
    }
}
```

---

## 3. Dependency Injection with `@Environment`

In iOS 17+, you do not need `environmentObject(_:)`. You inject and read types directly:

```swift
// Root or Ancestor
@main
struct MyApp: App {
    @State private var authService = AuthService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authService) // Direct type injection
        }
    }
}

// Child View
struct ProfileView: View {
    @Environment(AuthService.self) private var auth
    
    var body: some View {
        Text("Logged in as: \(auth.currentUser?.email ?? "Guest")")
    }
}
```

---

## 4. Key Differences from Legacy `ObservableObject`

1. **Granular Property Tracking**:
   - In `ObservableObject`, changing ANY `@Published` property invalidates EVERY view observing the object.
   - In `@Observable`, SwiftUI tracks **only the specific fields** accessed in a view's `body`. If property `A` changes, views reading only property `B` **do not re-render**.
2. **No `@Published`**:
   - Standard stored properties (`var name: String = ""`) are observed automatically.
   - Use `@ObservationIgnored` on properties that should not trigger view updates.
