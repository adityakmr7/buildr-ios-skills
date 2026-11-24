# 🚀 BuildrStudio iOS AI Skills Suite (`buildr-*`)

**Official Website**: [https://buildrstudio.in](https://buildrstudio.in)  
A production-grade, modular, and highly reusable collection of **21 AI Agent Skills** for modern iOS development (Swift 6+, iOS 17/18+, SwiftUI, SwiftData, StoreKit 2, Core Data, Concurrency, App Intents, Architecture, Security, Multiplatform, Interface Polish, and Apple HIG).

All skills follow the consistent **`buildr-*`** naming convention, making them instant to trigger, easy to remember, and universally compatible with **Antigravity**, **Claude Code**, **Cursor**, **Codex**, and OpenCode.

---

## 🧭 Complete Skills Catalog (21 Skills)

### 🎨 Architecture, UI & Design Polish
| Skill | Command | Focus Areas | Key References |
| :--- | :--- | :--- | :--- |
| **Buildr SwiftUI Pro** | **`buildr-ui`** | Modern SwiftUI (iOS 17/18+), `@Observable`, `NavigationStack`, Dynamic Type, 44x44pt touch targets, API deprecations | [API](skills/buildr-ui/references/api.md), [Views](skills/buildr-ui/references/views.md), [Data](skills/buildr-ui/references/data.md), [Nav](skills/buildr-ui/references/navigation.md), [A11y](skills/buildr-ui/references/accessibility.md) |
| **Buildr SwiftUI Design** | **`buildr-design`** | Apple HIG, "Restraint over decoration", 4/8-pt grid system (`4, 8, 12, 16, 20, 24, 32, 40, 48`), semantic system colors, WidgetKit | [Philosophy](skills/buildr-design/references/philosophy.md), [Grid](skills/buildr-design/references/grid-spacing.md), [Colors](skills/buildr-design/references/typography-colors.md), [Native](skills/buildr-design/references/native-components.md) |
| **Buildr Interface Polish** | **`buildr-polish`** | Micro-interactions (*make-interfaces-feel-better*): concentric corner radii, tactile spring scale feedback, sensory haptics (iOS 17+), optical vs geometric alignment, tabular digits | [Concentric](skills/buildr-polish/references/concentric-radii.md), [Tactile](skills/buildr-polish/references/tactile-feedback.md), [Optical](skills/buildr-polish/references/optical-alignment.md), [Numerics](skills/buildr-polish/references/numeric-motion.md) |
| **Buildr Architecture** | **`buildr-arch`** | Architectural patterns (MVVM, Clean Architecture, TCA, Coordinator), dependency injection, unidirectional data flow (UDF), SPM modularization | [Matrix](skills/buildr-arch/references/pattern-matrix.md), [DI](skills/buildr-arch/references/dependency-injection.md), [UDF](skills/buildr-arch/references/unidirectional-data-flow.md), [Modularization](skills/buildr-arch/references/modularization.md) |
| **Buildr UIKit Bridge** | **`buildr-uikit-bridge`** | UIKit-SwiftUI interoperability, `UIViewRepresentable`, `UIViewControllerRepresentable`, Coordinator delegate patterns, `UIHostingController` | [UIView](skills/buildr-uikit-bridge/references/view-representable.md), [UIViewController](skills/buildr-uikit-bridge/references/controller-representable.md), [UIHostingController](skills/buildr-uikit-bridge/references/hosting-controller.md) |
| **Buildr Multiplatform** | **`buildr-multiplatform`** | iPadOS & macOS adaptations: Stage Manager multitasking, Split View, Drag & Drop (`Transferable`), pointer styles, keyboard shortcuts | [Multitasking](skills/buildr-multiplatform/references/ipad-multitasking.md), [Drag & Drop](skills/buildr-multiplatform/references/drag-and-drop.md), [Pointer](skills/buildr-multiplatform/references/pointer-keyboard.md) |

### ⚡ Concurrency & Performance
| Skill | Command | Focus Areas | Key References |
| :--- | :--- | :--- | :--- |
| **Buildr Concurrency Pro** | **`buildr-concurrency`** | Swift 6 language mode, strict concurrency, actor isolation & reentrancy traps, `Sendable`, structured concurrency, diagnostics | [Swift 6](skills/buildr-concurrency/references/swift6-mode.md), [Actors](skills/buildr-concurrency/references/actors.md), [Structured](skills/buildr-concurrency/references/structured.md), [Sendable](skills/buildr-concurrency/references/sendable.md) |
| **Buildr Performance Audit** | **`buildr-perf`** | SwiftUI view invalidation churn (`Self._printChanges()`), `List` vs `LazyVStack`, memory leaks (`[weak self]`, task leaks), Instruments | [View Churn](skills/buildr-perf/references/view-churn.md), [Collections](skills/buildr-perf/references/collections.md), [Memory Leaks](skills/buildr-perf/references/memory-leaks.md), [Instruments](skills/buildr-perf/references/instruments.md) |

### 💾 Data & Persistence
| Skill | Command | Focus Areas | Key References |
| :--- | :--- | :--- | :--- |
| **Buildr SwiftData Pro** | **`buildr-swiftdata`** | Modern SwiftData `@Model`, safe `#Predicate` queries, `ModelActor` background concurrency, CloudKit sync constraints, migrations | [Models](skills/buildr-swiftdata/references/models.md), [Predicates](skills/buildr-swiftdata/references/predicates.md), [Concurrency](skills/buildr-swiftdata/references/concurrency.md), [CloudKit](skills/buildr-swiftdata/references/cloudkit.md) |
| **Buildr Core Data Expert** | **`buildr-coredata`** | Enterprise Core Data, context thread confinement (`perform`), `NSBatchInsertRequest`, persistent history tracking, migrations, CloudKit | [Stack & Concurrency](skills/buildr-coredata/references/stack-concurrency.md), [Batch Operations](skills/buildr-coredata/references/batch-operations.md), [History](skills/buildr-coredata/references/persistent-history.md) |

### 💰 Monetization & App Store
| Skill | Command | Focus Areas | Key References |
| :--- | :--- | :--- | :--- |
| **Buildr StoreKit 2** | **`buildr-storekit`** | StoreKit 2 in-app purchases, subscriptions, `SubscriptionStoreView` native paywalls, JWS verification, `Transaction.updates`, `.storekit` testing | [Products](skills/buildr-storekit/references/storekit2-products.md), [Paywalls](skills/buildr-storekit/references/subscriptions-paywalls.md), [Testing](skills/buildr-storekit/references/storekit-testing.md) |
| **Buildr App Store & Privacy** | **`buildr-appstore`** | Privacy Manifests (`PrivacyInfo.xcprivacy`), required reasons APIs, rejection prevention checklist, ASO metadata, export compliance | [Privacy](skills/buildr-appstore/references/privacy-manifests.md), [Checklist](skills/buildr-appstore/references/submission-checklist.md), [ASO](skills/buildr-appstore/references/metadata-aso.md) |

### 🧩 Language, Foundation & Systems
| Skill | Command | Focus Areas | Key References |
| :--- | :--- | :--- | :--- |
| **Buildr API Guidelines** | **`buildr-api`** | Official Swift API Design Guidelines: call-site clarity, grammatical argument labels, mutating/non-mutating pairs (`sort`/`sorted`), DocC | [Call-Site](skills/buildr-api/references/call-site-clarity.md), [Naming](skills/buildr-api/references/naming-conventions.md), [Mutating](skills/buildr-api/references/mutating-pairs.md) |
| **Buildr FormatStyle Pro** | **`buildr-format`** | Modern Foundation `FormatStyle` and `.formatted()`: currencies, dates, relative time, durations, measurements, lists, numbers | [Anti-Patterns](skills/buildr-format/references/anti-patterns.md), [Numeric](skills/buildr-format/references/numeric-styles.md), [Dates](skills/buildr-format/references/date-styles.md), [Durations](skills/buildr-format/references/duration-measurements.md) |
| **Buildr Background Tasks** | **`buildr-background`** | `BGTaskScheduler` (refresh & processing tasks), background `URLSession`, `beginBackgroundTask` expiration assertions, silent pushes | [BGTaskScheduler](skills/buildr-background/references/bgtaskscheduler.md), [Transfers](skills/buildr-background/references/background-transfers.md), [Short Tasks](skills/buildr-background/references/short-tasks-assertions.md) |
| **Buildr App Intents** | **`buildr-intents`** | Apple App Intents framework (iOS 16+, 17, 18+), `AppIntent`, `AppEntity`, `EntityQuery`, `AppShortcutsProvider`, interactive controls | [Intents](skills/buildr-intents/references/intents-fundamentals.md), [Entities](skills/buildr-intents/references/entities-queries.md), [Shortcuts](skills/buildr-intents/references/shortcuts-siri.md) |
| **Buildr Widgets & Island** | **`buildr-widgets`** | WidgetKit & ActivityKit: TimelineProvider, interactive widgets, Live Activities, Dynamic Island (4 presentations), App Groups | [Timelines](skills/buildr-widgets/references/timeline-providers.md), [Interactive](skills/buildr-widgets/references/interactive-widgets.md), [Live Activities](skills/buildr-widgets/references/live-activities-island.md) |

### 🛡️ Quality, Security & Debugging
| Skill | Command | Focus Areas | Key References |
| :--- | :--- | :--- | :--- |
| **Buildr Swift Testing** | **`buildr-testing`** | Apple Swift Testing framework (`import Testing`), `@Test`, `@Suite`, `#expect` vs `#require`, parameterized tables, async testing | [Fundamentals](skills/buildr-testing/references/fundamentals.md), [Parameterized](skills/buildr-testing/references/parameterized.md), [Async](skills/buildr-testing/references/async-testing.md), [XCTest](skills/buildr-testing/references/xctest-migration.md) |
| **Buildr Debugger Agent** | **`buildr-debugger`** | Crash triage (`EXC_BAD_ACCESS`, `SIGABRT`, `0x8badf00d`), LLDB variable inspection (`v`, `po`), Thread/Address Sanitizers (TSan, ASan) | [Crash Analysis](skills/buildr-debugger/references/crash-analysis.md), [LLDB Recipes](skills/buildr-debugger/references/lldb-recipes.md), [Sanitizers](skills/buildr-debugger/references/sanitizer.md) |
| **Buildr Logging & Metrics** | **`buildr-logs`** | Unified Logging (`os.Logger`), privacy redactions (`mask: .hash`), `OSSignposter` Instruments tracing, `MetricKit` telemetry | [Unified Logging](skills/buildr-logs/references/unified-logging.md), [Privacy](skills/buildr-logs/references/privacy-redaction.md), [Signposts](skills/buildr-logs/references/signposts-tracing.md) |
| **Buildr Security Expert** | **`buildr-security`** | iOS Keychain wrapper (`SecItem`), `CryptoKit` (AES-GCM, Secure Enclave), `LocalAuthentication` (Face ID / Touch ID), certificate pinning | [Keychain](skills/buildr-security/references/keychain-services.md), [CryptoKit](skills/buildr-security/references/cryptokit-primitives.md), [Biometrics](skills/buildr-security/references/biometrics-auth.md) |

---

## 🚀 How to Install in Any Project

### Method 1: Global Install (Available everywhere on your Mac)
```bash
./install.sh --global
```
Installs to `~/.gemini/antigravity-cli/skills`, `~/.claude/skills`, and `~/.cursor/skills`.

### Method 2: Project-Specific Install (Committed to Git for your team)
```bash
# Install all 21 Buildr skills into your iOS project
./install.sh --project /path/to/MyAwesomeApp

# Or install only specific skills (e.g. Polish & Design)
./install.sh --project /path/to/MyAwesomeApp --skill buildr-polish
./install.sh --project /path/to/MyAwesomeApp --skill buildr-design
```

---

## 💡 Example Prompt Invocations

Once installed, trigger any skill directly with natural commands:

- *"Polish this card component with **`buildr-polish`** to ensure concentric corner radii, tactile spring feedback on press, and sensory haptics."*
- *"Use **`buildr-polish`** to fix the jitter in this timer label using tabular numbers."*
- *"Set up StoreKit 2 auto-renewable subscriptions with **`buildr-storekit`**."*
- *"Audit our app for App Store submission using **`buildr-appstore`**."*
- *"Review this view with **`buildr-ui`** for modern iOS 17/18 Observation and touch targets."*
- *"Check this view model with **`buildr-concurrency`** for Swift 6 data-race safety."*

---

## 🧪 Validating the Skills Suite

Run the built-in validation script to verify all 21 skills:

```bash
python3 scripts/validate-skills.py
```
