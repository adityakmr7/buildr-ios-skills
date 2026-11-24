# iOS Crash Log Analysis & Exception Types

Deciphering common iOS crash exception codes and diagnosing their root causes.

---

## 1. Common Exception Codes

| Code / Signal | Name | Root Cause |
| :--- | :--- | :--- |
| **`EXC_BAD_ACCESS`** (`SIGBUS` / `SIGSEGV`) | Bad Memory Access | Attempting to access memory that was deallocated (use-after-free), a dangling pointer, or dereferencing `nil` through unsafe pointers. |
| **`SIGABRT`** | Abort Signal | The app or OS deliberately aborted execution. Common causes: Uncaught Objective-C exception (e.g. `NSInvalidArgumentException`), or container index out of bounds. |
| **`SIGTRAP`** / `EXC_BREAKPOINT` | Trace Trap | Swift runtime safety checks: Force-unwrapping a `nil` optional (`!`), failed force-cast (`as!`), or hitting `fatalError()`. |
| **`0x8badf00d`** ("ate bad food") | Watchdog Timeout | The app blocked the main thread for too long (typically > 10 seconds during launch or > 5 seconds in background) and was killed by iOS SpringBoard. |
| **`0xdeadfa11`** ("dead fall") | User Force Quit | The user held down power and force-quit the application. |
| **`0xc00010ff`** ("cool off") | Thermal Throttling | Device overheated and OS killed background/foreground processes. |

---

## 2. Step-by-Step Triage Workflow

1. **Locate the Crashing Thread**: Look for `Crashed:` in the thread backtrace list.
2. **Inspect the Top Frame**: The lowest frame number (Frame 0 or 1) in your own module is where the error triggered.
3. **Check Exception Reason**: Look at the header of the crash log:
   ```text
   Application Specific Information:
   Fatal error: Unexpectedly found nil while unwrapping an Optional value
   ```
4. **Symbolicate if un-symbolicated**:
   ```bash
   atos -o MyApp.app/MyApp -l <LoadAddress> <AddressToSymbolicate>
   ```
