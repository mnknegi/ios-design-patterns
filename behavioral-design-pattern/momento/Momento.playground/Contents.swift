
/*
 Momento is a behavioural design pattern that lets you `save and restore the previous state of an object` without revealing the details of its implementation.

 - Capture and store an object's internal state.
 - Restore it later without violating encapsulation.

 Key Idea:
 - You can save snapshots of an object's state and restore them when needed.
 - This pattern is useful for undo/redo functionality, checkpoints and rollback scenarios.

 Real world scenario:
 NSCoder & Archiving: Saving and restoring object state using NSCoding/Codable protocol acts like a momento - you encode state and decode it later.

 Text Editor: undo-redo stacks(e.g. in a drawing app or form)typically rely on this pattern.

 iOS usecase:
 - State Restoration: UIKit's state restoration mechanism can be modeled after the momento pattern.
 - Form/Data entry: Apps that allow uses to save drafts and restore them later.
 - NSUndoManager: allows undoing changes - behind the scene it can use momentos to restore prior states.
 */

/* Text Editor with Undo */

// Momento (snapshot)
class TextMomento {
    let state: String

    init(state: String) {
        self.state = state
    }
}

// Originator
class TextEditor {
    private var text = ""

    func type(_ newText: String) {
        text += newText
        print("Current text: \(text)")
    }

    func save() -> TextMomento {
        return TextMomento(state: text)
    }

    func restore(momento: TextMomento) {
        text = momento.state
        print("Restored text: \(text)")
    }
}

// Caretaker
class History {
    private var momentos: [TextMomento] = []

    func saveMomento(_ momento: TextMomento) {
        momentos.append(momento)
    }

    func undo() -> TextMomento? {
        return momentos.popLast()
    }
}

// Usage
let editor = TextEditor()
let history = History()

editor.type("Hello")
history.saveMomento(editor.save())

editor.type(" World!")
history.saveMomento(editor.save())

editor.type("Goodbye!")

if let momento = history.undo() {
    editor.restore(momento: momento)
}

if let momento = history.undo() {
    editor.restore(momento: momento)
}
