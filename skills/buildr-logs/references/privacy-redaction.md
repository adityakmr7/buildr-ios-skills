# Privacy Redaction & String Interpolation

By default, the unified logging system redacts dynamic strings in production to protect user privacy.

---

## 1. Public vs Private

```swift
import OSLog

let userId = "user_9421"
let email = "aditya@example.com"
let statusCode = 200

// ❌ Insecure: If marked public, user email is leaked in device logs!
Logger.auth.info("User \(email, privacy: .public) logged in")

// ✅ Secure: Private values are displayed as <private> in release logs
Logger.auth.info("User \(email, privacy: .private) logged in with status \(statusCode, privacy: .public)")
```

---

## 2. Hashing for Correlation without Leaking PII

If you need to correlate multiple log lines belonging to the same user without exposing their actual identifier:

```swift
// Creates a deterministic SHA-256 hash in logs for correlation:
Logger.auth.info("Processing sync for user: \(userId, privacy: .private(mask: .hash))")
```
