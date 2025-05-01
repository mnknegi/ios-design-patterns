
/*
 * Chian of Responsibility

 Chain of responsibility is a behavioral design pattern that `allows a request to be passed along a chain of handlers`. Each handler desides either to process the request or to pass it to the next handler in the chain.

 Key Idea:
 - It avoid coupling the sender of the request to its receiver.
 - We can build flexible, dynamic chains of objects at runtime.

 One of real world scenario in iOS is responder chaing in UIKit.
 - Events like touch, motion or action messages get passed up the responder chain.
 - If the UIView doesn't handle an event, it passes it up to its superview, then to the view controller and so on.

 example:

 `UIButton` -> `UIView` -> `UIViewController` -> `UIApplication` -> `AppDelegate`
 */

// Logging handler: ConsoleLogger -> FileLogger -> EmailLogger

protocol Logger {
    var next: Logger? { get set }
    func log(message: String)
}

final class ConsoleLogger: Logger {
    var next: Logger?

    func log(message: String) {
        if message.contains("INFO") {
            print("Console: \(message)")
        } else {
            next?.log(message: message)
        }
    }
}

final class FileLogger: Logger {
    var next: Logger?

    func log(message: String) {
        if message.contains("DEBUG") {
            print("File: \(message)")
        } else {
            next?.log(message: message)
        }
    }
}

final class EmailLogger: Logger {
    var next: Logger?

    func log(message: String) {
        print("Email: \(message)")
    }
}

// set up chain
let console = ConsoleLogger()
let file = FileLogger()
let email = EmailLogger()

console.next = file
file.next = email

// Usage
console.log(message: "INFO: All good")
console.log(message: "Debug: Something to watch")
console.log(message: "Error: Something went wrong")


// Build in iOS example

/*
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
}
*/
