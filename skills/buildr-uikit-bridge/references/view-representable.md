# `UIViewRepresentable` & Coordinator Delegate Pattern

Wrapping UIKit views for use in declarative SwiftUI hierarchies.

---

## 1. Complete Example: Custom `UITextView` with Auto-Height

```swift
import SwiftUI
import UIKit

struct CustomTextView: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    
    // 1. Create Coordinator to handle delegates
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // 2. Instantiate View ONCE
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.backgroundColor = .clear
        return textView
    }
    
    // 3. Update view when SwiftUI @State changes
    func updateUIView(_ uiView: UITextView, context: Context) {
        // Prevent cursor jumping: only update if text differs
        if uiView.text != text {
            uiView.text = text
        }
    }
    
    // 4. The Coordinator handles UIKit callbacks
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextView
        
        init(_ parent: CustomTextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            // Update parent SwiftUI binding
            self.parent.text = textView.text
        }
    }
}
```

---

## 2. Preventing Feedback Loops in `updateUIView`

> [!WARNING]
> Always verify whether the UIKit property already matches the SwiftUI binding before setting it in `updateUIView`. Blindly assigning values in `updateUIView` causes infinite feedback loops and cursor jumping in text views!
