# Swift Testing Fundamentals: `@Test`, `@Suite`, `#expect` & `#require`

Apple's Swift Testing framework provides an expressive, macro-driven testing system built from the ground up for modern Swift and concurrency.

---

## 1. Basic Test Structure

No need to subclass `XCTestCase` or prefix function names with `test`:

```swift
import Testing
@testable import MyApp

@Suite("Authentication Engine Tests")
struct AuthTests {
    let authService = AuthService()
    
    @Test("Valid email and password logs in successfully")
    func loginSuccess() async throws {
        let session = try await authService.login(email: "user@example.com", password: "SecretPassword123")
        
        // Non-fatal check: continues executing remaining assertions on failure
        #expect(session.isValid)
        #expect(session.userId == "user@example.com")
    }
}
```

---

## 2. `#expect` vs `try #require`

| Macro | Behavior on Failure | Typical Use Case |
| :--- | :--- | :--- |
| **`#expect(condition)`** | Records a failure, but **continues executing** the rest of the test function. | Verifying independent fields (name, age, status). |
| **`try #require(optional)`** | Records a failure and **immediately terminates** test function execution. Unwraps optionals. | Unwrapping required tokens or data models before accessing sub-fields. |

### Example:
```swift
@Test func userProfileParsing() throws {
    let json = ["id": "123", "name": "Aditya"]
    let user = User(json: json)
    
    // If user is nil, stop here immediately to avoid crashing!
    let unwrapped = try #require(user)
    
    // Both are evaluated even if the first fails
    #expect(unwrapped.id == "123")
    #expect(unwrapped.name == "Aditya")
}
```

---

## 3. Test Traits & Tags

Add metadata, custom display names, bug links, or conditional skips:

```swift
extension Tag {
    @Tag static var network: Self
    @Tag static var database: Self
}

@Suite(.tags(.network))
struct RemoteSyncTests {
    @Test(
        "Syncs with remote server",
        .bug("https://github.com/myorg/myapp/issues/42", "Fixes sync collision"),
        .timeLimit(.minutes(1))
    )
    func performSync() async throws {
        // ...
    }
}
```
