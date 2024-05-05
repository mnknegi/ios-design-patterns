
import Foundation

/**
 * Abstract Factory Pattern is another creational design pattern that provides an interface for creating families of related or dependent objects without specifying their concrete classes.
 * It is an extension of the factory pattern where the factory is itself abstracted into an interface or base class, and concrete factories are responsible for instantiating specific types of related objects.
 */

// Abstract product A
protocol Button {
    func display()
}

// Concrete product A
final class iOSButton: Button {
    func display() {
        print("iPhone style button.")
    }
}

final class MacButton: Button {
    func display() {
        print("Mac style button.")
    }
}

final class WindowsButton: Button {
    func display() {
        print("Windows style button.")
    }
}

// Abstract product B
protocol CheckBox {
    func display()
}

// Concrete product B
final class iOSCheckbox: CheckBox {
    func display() {
        print("iPhone style checkBox.")
    }
}

final class MacCheckBox: CheckBox {
    func display() {
        print("Mac style checkBox.")
    }
}

final class WindowsCheckBox: CheckBox {
    func display() {
        print("Windows style checkBox.")
    }
}

// Abstract Factory
protocol GUIFactory {
    func createButton() -> Button
    func createCheckbox() -> CheckBox
}

// Concrete Factory 1
final class iOSFactory: GUIFactory {
    func createButton() -> Button {
        iOSButton()
    }
    
    func createCheckbox() -> CheckBox {
        iOSCheckbox()
    }
}

// Concrete Factory 2
final class MacFactory: GUIFactory {
    func createButton() -> Button {
        MacButton()
    }
    
    func createCheckbox() -> CheckBox {
        MacCheckBox()
    }
}

// Concrete Factory 3
final class WindowsFactory: GUIFactory {
    func createButton() -> Button {
        WindowsButton()
    }
    
    func createCheckbox() -> CheckBox {
        WindowsCheckBox()
    }
}

// Client Code

final class Application {

    let factory: GUIFactory

    init(factory: GUIFactory) {
        self.factory = factory
    }

    func createUI() {
        let button = factory.createButton()
        let checkBox = factory.createCheckbox()

        button.display()
        checkBox.display()
    }
}

// Usage
let iosApp = Application(factory: iOSFactory())
iosApp.createUI()

let macApp = Application(factory: MacFactory())
macApp.createUI()

let windowsApp = Application(factory: WindowsFactory())
windowsApp.createUI()
