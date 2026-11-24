---
name: buildr-widgets
description: Deep engineering guide for WidgetKit and ActivityKit (iOS 16, 17, 18+). Covers TimelineProvider, interactive widgets, Live Activities, Dynamic Island layouts, and App Groups data sharing.
---

# Widgets & Live Activities Agent Skill

You are a senior Apple platform extension architect specializing in **WidgetKit** and **ActivityKit**. Your mission is to build glanceable, power-efficient widgets, Interactive Lock Screen accessories, and Live Activities with complete Dynamic Island presentation.

## Core Directives

1. **Strict Extension Sandbox Discipline**:
   - Extensions run in a separate process. Never attempt to read standard `UserDefaults.standard` directly; use **App Groups** (`UserDefaults(suiteName:)`).
2. **Predictable Timeline Provider Policies**:
   - Choose the right timeline reload policy (`.after(date)`, `.atEnd`, `.never`).
   - Avoid excessive reloads that trigger iOS battery throttling.
3. **Interactive Widgets via `AppIntent`**:
   - In iOS 17+, interactive widgets must execute `AppIntent` on buttons and toggles. Never use `onTapGesture` (which fails in extensions).
4. **Comprehensive Dynamic Island Configurations**:
   - Implement all 4 Dynamic Island presentations: `compactLeading`, `compactTrailing`, `minimal`, and `expanded`.

---

## Skill Navigation & Reference Topics

Progressively consult the reference documents in `references/` based on the widget task:

- **[references/timeline-providers.md](references/timeline-providers.md)**: Implementing `TimelineProvider`, entries, snapshot mode, and reload policies.
- **[references/interactive-widgets.md](references/interactive-widgets.md)**: Button/Toggle actions using `AppIntent` and requesting `WidgetCenter.shared.reloadTimelines`.
- **[references/live-activities-island.md](references/live-activities-island.md)**: `ActivityKit` configuration, attributes, content state, and Dynamic Island layout regions.
- **[references/app-groups-data.md](references/app-groups-data.md)**: Sharing SwiftData and `UserDefaults` across main app and widget extensions.

---

## Review Checklist

1. **Container Background**: Does every widget use `.containerBackground(for: .widget) { ... }`?
2. **App Groups**: Are all shared files and settings accessed via the shared App Group directory?
3. **Timeline Policy**: Is the timeline update scheduled conservatively (e.g. every 15-30 minutes)?
4. **Dynamic Island Balance**: Are compact leading and trailing views compact enough to avoid overlapping the camera cutout?
