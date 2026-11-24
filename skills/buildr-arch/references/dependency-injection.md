# Dependency Injection & Dependency Clients

Decoupling dependencies makes code modular, preview-friendly, and effortlessly testable.

---

## 1. The Client Struct Pattern (Alternative to Protocols)

Popularized by modern Swift architecture, the client struct pattern provides high flexibility without protocol boilerplate:

```swift
import Foundation

// 1. Declare the dependency client
struct UserClient: Sendable {
    var fetchProfile: @Sendable (String) async throws -> UserProfile
    var updateStatus: @Sendable (String, Bool) async throws -> Void
}

// 2. Live production implementation
extension UserClient {
    static let live = UserClient(
        fetchProfile: { id in
            // Network call using URLSession
            try await APIEndpoint.profile(id).request()
        },
        updateStatus: { id, active in
            // Network update
            try await APIEndpoint.setStatus(id, active).request()
        }
    )
}

// 3. Mock preview/test implementation
extension UserClient {
    static let mock = UserClient(
        fetchProfile: { id in
            UserProfile(id: id, name: "Preview User", email: "preview@example.com")
        },
        updateStatus: { _, _ in }
    )
}
```

---

## 2. Injection via SwiftUI Environment

Inject the client at app root:

```swift
private struct UserClientKey: EnvironmentKey {
    static let defaultValue: UserClient = .live
}

extension EnvironmentValues {
    var userClient: UserClient {
        get { self[UserClientKey.self] }
        set { self[UserClientKey.self] = newValue }
    }
}
```
