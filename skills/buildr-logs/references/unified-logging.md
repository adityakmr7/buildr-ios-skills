# Unified Logging: `os.Logger`

Apple's Unified Logging (`import OSLog`) is low-overhead, power-efficient, and integrates directly with Xcode Console and Console.app.

---

## 1. Setting Up Subsystems and Categories

Centralize your loggers in an extension:

```swift
import OSLog

extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.mycompany.myapp"
    
    static let ui = Logger(subsystem: subsystem, category: "UI")
    static let network = Logger(subsystem: subsystem, category: "Network")
    static let database = Logger(subsystem: subsystem, category: "Database")
    static let auth = Logger(subsystem: subsystem, category: "Authentication")
}
```

---

## 2. Choosing Log Levels

| Level | Method | Persistence & When to Use |
| :--- | :--- | :--- |
| **Debug** | `logger.debug(...)` | High-frequency diagnostic info during development. Not persisted to disk. |
| **Info** | `logger.info(...)` | Helpful for troubleshooting; stored in memory, persisted only during log capture. |
| **Notice** | `logger.notice(...)` | Default level. Normal operational milestones (e.g. screen appeared, task queued). Persisted to disk. |
| **Error** | `logger.error(...)` | Recoverable errors, handled network failures. Persisted to disk. |
| **Fault** | `logger.fault(...)` | Critical bugs or system-level corruptions indicating a bug in your code. Persisted and highlighted in red in Console.app. |
