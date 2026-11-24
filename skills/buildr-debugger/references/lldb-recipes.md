# LLDB Command Recipes & Practical Cheatsheet

Mastering LLDB speeds up debugging and eliminates the need to sprinkle `print()` statements across your code.

---

## 1. Inspecting Variables

| Command | Description | Notes |
| :--- | :--- | :--- |
| `v <variable>` | **Frame Variable**: Reads memory directly from stack frame without compiling code. | **Fastest & safest**. Does not run expression evaluator. |
| `po <variable>` | **Print Object**: Calls the object's `description` or `debugDescription`. | Evaluates in runtime; safe for Swift objects. |
| `p <variable>` | Evaluates expression and prints raw type structure. | Useful for primitive types and struct layouts. |
| `expr <expression>` | Evaluates arbitrary Swift code and can modify variables on the fly! | e.g. `expr self.isLoggedIn = true` |

---

## 2. Navigating the Stack & Threads

```text
# Show backtrace of current thread
(lldb) bt

# Show backtrace of all threads
(lldb) thread backtrace all

# Switch to thread 3
(lldb) thread select 3

# Inspect frame 2 in current thread
(lldb) frame select 2

# List all local variables in the current frame
(lldb) frame variable
```

---

## 3. Advanced Breakpoints

Set breakpoints that log and automatically continue without pausing execution:

```text
# Set breakpoint on specific function
(lldb) breakpoint set --name "placeOrder"

# Add command to run when hit
(lldb) breakpoint command add 1
> po order.id
> continue
> DONE
```
