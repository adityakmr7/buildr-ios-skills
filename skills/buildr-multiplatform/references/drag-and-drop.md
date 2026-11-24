# Drag and Drop with the `Transferable` Protocol

Modern SwiftUI handles drag and drop using the `Transferable` protocol (iOS 16+).

---

## 1. Making Models `Transferable`

```swift
import SwiftUI
import CoreTransferable

struct NoteItem: Identifiable, Codable, Transferable {
    var id: UUID = UUID()
    var title: String
    var content: String
    
    // Define how this item transfers across apps
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .json)
        ProxyRepresentation(exporting: \.title) // Fallback as plain text
    }
}
```

---

## 2. Adding Drag and Drop Modifiers in SwiftUI

```swift
struct NoteCardView: View {
    let note: NoteItem
    
    var body: some View {
        Text(note.title)
            .padding()
            .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 8))
            .draggable(note) // Makes item draggable!
    }
}

struct TrashDropZoneView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [6]))
            .frame(height: 100)
            .overlay(Text("Drop here to archive"))
            .dropDestination(for: NoteItem.self) { droppedNotes, location in
                for note in droppedNotes {
                    ArchiveManager.shared.archive(note)
                }
                return true
            }
    }
}
```
