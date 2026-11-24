# Biometric Authentication (`LocalAuthentication`)

Authenticate users with Face ID, Touch ID, or Optic ID.

---

## 1. Performing Biometric Authentication

```swift
import LocalAuthentication

@MainActor
final class BiometricsService {
    static func authenticateUser(reason: String = "Authenticate to unlock your account") async -> Bool {
        let context = LAContext()
        context.localizedCancelTitle = "Cancel"
        
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            print("Biometrics unavailable: \(error?.localizedDescription ?? "None")")
            return false
        }
        
        do {
            return try await context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason
            )
        } catch {
            print("Authentication failed: \(error.localizedDescription)")
            return false
        }
    }
}
```

> [!IMPORTANT]
> Always add `NSFaceIDUsageDescription` to your app's `Info.plist` explaining why the app requests Face ID.
