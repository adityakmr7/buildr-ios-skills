# Base-4 and Base-8 Grid Spacing System

Consistent spatial rhythm is what gives iOS interfaces their polished, calm, and organized feel. 

---

## 1. The Token Scale

Only use spacing and padding values from the strict Base-4 / Base-8 scale:

| Token | Points (pt) | Typical Application |
| :--- | :--- | :--- |
| **`xxxSmall`** | `2` | Micro-alignments (badges, dot indicators) |
| **`xxSmall`** | `4` | Tight icon-to-text spacing, caption gaps |
| **`xSmall`** | `8` | Gaps between related text elements (headline to subheadline), inner chip padding |
| **`small`** | `12` | Inner component padding, tight list item gaps |
| **`medium`** | `16` | **Standard screen margin**, standard card padding, horizontal form margins |
| **`large`** | `20` | Section separation in compact layouts |
| **`xLarge`** | `24` | Primary section gaps, modal sheet top padding |
| **`xxLarge`** | `32` | Major container margins, hero block spacing |
| **`xxxLarge`** | `40` | Large header to content spacing |
| **`huge`** | `48` | Onboarding hero illustration margins |

---

## 2. Forbidden Values

Never use arbitrary numbers:
- ❌ Do NOT use `3`, `7`, `11`, `13`, `15`, `17`, `19`, `22`, `25`, `27`, `35`
- Keep every padding or spacing token divisible by 4 (and for values ≥ 8, divisible by 8 where possible).

---

## 3. Structural Margins & Insets

```swift
struct LayoutMetrics {
    static let screenHorizontalMargin: CGFloat = 16
    static let cardPadding: CGFloat = 16
    static let sectionSpacing: CGFloat = 24
    static let itemSpacing: CGFloat = 12
    static let textGap: CGFloat = 4
}

struct ExampleView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: LayoutMetrics.sectionSpacing) {
                // Section 1
                VStack(alignment: .leading, spacing: LayoutMetrics.textGap) {
                    Text("Activity")
                        .font(.title2.bold())
                    Text("Daily summary")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Content Card
                VStack(spacing: LayoutMetrics.itemSpacing) {
                    // Items...
                }
                .padding(LayoutMetrics.cardPadding)
                .background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, LayoutMetrics.screenHorizontalMargin)
            .padding(.vertical, LayoutMetrics.sectionSpacing)
        }
    }
}
```
