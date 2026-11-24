# Xcode Instruments Profiling Workflow

Instruments is Apple's gold-standard performance analysis application.

---

## 1. Time Profiler (CPU & Main Thread Hitches)

1. **Build in Release**: In Xcode, select **Product** → **Profile** (⌘I) using a **physical device** (simulators have different CPU throttling and GPU rendering characteristics).
2. **Record Trace**: Select the **Time Profiler** template.
3. **Inspect the Call Tree**:
   - In the bottom bar, select **Call Tree**.
   - Check **Separate by Thread**.
   - Check **Invert Call Tree** (shows leaves where the CPU spent the most time).
   - Check **Hide System Libraries** (isolates your app's code from system frameworks).

---

## 2. Allocations & Leaks (Memory Growth)

1. Select the **Allocations** instrument.
2. Mark generations (**Mark Generation** button) before and after opening a screen:
   - Mark Gen A → Push View → Pop View → Mark Gen B.
   - Any objects surviving between Gen A and Gen B that shouldn't are persistent leaks.
3. Look for remaining view models, view controllers, or image buffers.

---

## 3. SwiftUI Instrument

Use the **SwiftUI** instrument template in Xcode 15+:
- Monitors **View Body** execution count and duration.
- Identifies exact view structures that evaluate excessively during gesture interaction.
