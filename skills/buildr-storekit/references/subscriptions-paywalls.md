# Subscriptions & Native SwiftUI Paywalls

StoreKit 2 provides out-of-the-box SwiftUI paywall views.

---

## 1. Native `SubscriptionStoreView` (iOS 17+)

```swift
import SwiftUI
import StoreKit

struct PaywallView: View {
    let subscriptionGroupID = "21049281"
    
    var body: some View {
        SubscriptionStoreView(groupID: subscriptionGroupID) {
            // Header content
            VStack(spacing: 8) {
                Image(systemName: "crown.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(.yellow)
                Text("Upgrade to Buildr Pro")
                    .font(.title2.bold())
                Text("Unlock unlimited cloud storage and advanced exports.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical)
        }
        .subscriptionStorePolicyDestination(url: URL(string: "https://buildrstudio.in/privacy")!, for: .privacyPolicy)
        .subscriptionStorePolicyDestination(url: URL(string: "https://buildrstudio.in/terms")!, for: .termsOfService)
    }
}
```

---

## 2. Presenting the Manage Subscriptions Sheet

Allow users to easily manage or cancel active subscriptions inside the app:

```swift
struct SettingsView: View {
    @State private var showManageSubscriptions = false
    
    var body: some View {
        List {
            Button("Manage Subscription") {
                showManageSubscriptions = true
            }
        }
        .manageSubscriptionsSheet(isPresented: $showManageSubscriptions)
    }
}
```
