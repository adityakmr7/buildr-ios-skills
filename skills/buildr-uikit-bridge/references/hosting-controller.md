# Embedding SwiftUI in UIKit via `UIHostingController`

Integrating SwiftUI views inside existing UIKit storyboards, navigation controllers, or table views.

---

## 1. Presenting as a Child View Controller

```swift
import UIKit
import SwiftUI

class DashboardViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Create SwiftUI view
        let swiftUIView = QuickStatsView()
        
        // 2. Wrap in UIHostingController
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        // 3. Add as child controller
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        // 4. Configure Auto Layout
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.heightAnchor.constraint(equalToConstant: 220)
        ])
        
        // 5. Notify child move
        hostingController.didMove(toParent: self)
    }
}
```

---

## 2. Using `UIHostingConfiguration` in Cells (iOS 16+)

Directly render SwiftUI inside `UITableViewCell` or `UICollectionViewCell`:

```swift
func configureCell(cell: UICollectionViewListCell, item: TaskItem) {
    cell.contentConfiguration = UIHostingConfiguration {
        HStack {
            Text(item.title)
            Spacer()
            Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(.tint)
        }
    }
}
```
