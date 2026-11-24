# Philosophy: Restraint Over Decoration

The hallmark of great iOS software is **clarity, deference, and depth** (Apple Human Interface Guidelines). Interfaces should step back and let the user's content shine.

---

## 1. Anti-Patterns of "AI-Generated" UI

AI code generation frequently introduces recurring visual flaws. Recognize and eliminate them:

### ❌ The "Card for Everything" Trap
- **Anti-pattern**: Wrapping every label, stat, and row in its own rounded rectangle card with an artificial drop shadow and stroke.
- **Apple Way**: Group related information into native `List` sections, `Form` sections, or simple divider-free vertical rhythm.

### ❌ The "Rainbow Gradient" Trap
- **Anti-pattern**: Applying angular or linear gradients behind every button, icon background, and header text.
- **Apple Way**: Use solid system tint colors (`.tint(.blue)` or `.foregroundStyle(.tint)`) or subtle native materials (`.ultraThinMaterial`). Gradients should be reserved for rare, deliberate hero moments (like onboarding or special milestones).

### ❌ Meaningless Borders & Dividers
- **Anti-pattern**: Stacking borders (`.stroke(Color.gray, lineWidth: 1)`) on containers that already have background distinction.
- **Apple Way**: Rely on contrast between background levels (`systemBackground` vs `secondarySystemGroupedBackground`). If a divider is needed, use SwiftUI's native `Divider()`.

### ❌ Verbose UI Copy
- **Anti-pattern**: Explaining every button with long paragraphs, repetitive subtitles, and cluttered instructional footers.
- **Apple Way**: Concise, confident copy. A button should say "Upgrade", not "Click here to upgrade your account to premium now".

---

## 2. Before & After Refactoring

### ❌ Cluttered "AI-Generated" Style:
```swift
VStack(spacing: 15) {
    HStack {
        Image(systemName: "bolt.fill")
            .font(.system(size: 28))
            .foregroundStyle(LinearGradient(colors: [.orange, .yellow], startPoint: .top, endPoint: .bottom))
            .padding(10)
            .background(Color.yellow.opacity(0.2))
            .clipShape(Circle())
        
        VStack(alignment: .leading) {
            Text("Fast Syncing Engine")
                .font(.system(size: 19, weight: .bold))
            Text("Syncs your data seamlessly to all devices in the cloud.")
                .font(.system(size: 13))
                .foregroundColor(.gray)
        }
    }
    .padding(20)
    .background(Color.white)
    .cornerRadius(18)
    .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 4)
    .overlay(
        RoundedRectangle(cornerRadius: 18)
            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
    )
}
```

### ✅ Clean Native Apple HIG Style:
```swift
HStack(spacing: 16) {
    Image(systemName: "bolt.fill")
        .font(.title2)
        .foregroundStyle(.tint)
        .frame(width: 40, height: 40)
        .background(.tint.opacity(0.12), in: Circle())
    
    VStack(alignment: .leading, spacing: 4) {
        Text("Fast Sync")
            .font(.headline)
        Text("Syncs across all your devices.")
            .font(.subheadline)
            .foregroundStyle(.secondary)
    }
    
    Spacer()
}
.padding(16)
.background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
```
