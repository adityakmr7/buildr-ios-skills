# Runtime Sanitizers: TSan, ASan & UBSan

Xcode includes powerful LLVM-based sanitizers that intercept memory errors and concurrency violations at runtime before they reach production.

---

## 1. Thread Sanitizer (TSan)

Detects data races where two threads access the same memory location simultaneously without synchronization, and at least one access is a write.

### How to Enable:
1. In Xcode, click the scheme selector → **Edit Scheme...** (⌘<).
2. Select **Run** (or **Test**) on the left.
3. Go to the **Diagnostics** tab.
4. Check **Thread Sanitizer**.

### TSan Report Interpretation:
When a race occurs, Xcode pauses execution and displays:
```text
WARNING: ThreadSanitizer: Swift access race (read vs write)
  Read of size 8 at 0x00010423 on Thread 3
  Previous write of size 8 at 0x00010423 on Thread 1
```
Use the backtraces to identify the shared mutable variable and isolate it with an `actor` or `@MainActor`.

---

## 2. Address Sanitizer (ASan)

Detects memory corruption issues:
- Use-after-free
- Buffer overflow (heap and stack)
- Memory access out of bounds in C/C++/Objective-C bridges

### How to Enable:
- In **Edit Scheme...** → **Diagnostics**, check **Address Sanitizer**.
*(Note: TSan and ASan cannot be enabled at the same time).*

---

## 3. Undefined Behavior Sanitizer (UBSan)

Detects undefined behavior such as integer overflow, null pointer arithmetic, or misaligned pointers. Check **Undefined Behavior Sanitizer** in the Diagnostics tab.
