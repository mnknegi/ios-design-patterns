
/*
 It is a behaviour design pattern that promotes loose coupling by having objects communicate through a mediator object rather than directly with each other.

 key Idea:

 - Instead of components talking to each other directly, they send messages to a mediator.
 - The mediator handles the communication and coordination between components.
 - This reduces dependencies and makes components easier to manage, modify or reuse.

 Real world scenario:
 NotificationCentre
 */

import NotificationCenter

extension NSNotification.Name {
    static let myCustomNootification = NSNotification.Name("MyCustomNotification")
}

NotificationCenter.default.post(name: .myCustomNootification, object: nil)

NotificationCenter.default.addObserver(forName: .myCustomNootification, object: nil, queue: .main) { notification in
    print("Received notification")
}

// Here, NotificationCentre is the mediator.

//------------------ Example 2 ------------------//

// Mediator Protocol
protocol ChatRoomMediator {
    func showMessage(sender: User, message: String)
}

class User {
    let name: String
    private let chatMediator: ChatRoomMediator

    init(name: String, chatMediator: ChatRoomMediator) {
        self.name = name
        self.chatMediator = chatMediator
    }

    func send(message: String) {
        chatMediator.showMessage(sender: self, message: message)
    }
}

// Concrete Mediator
class ChatRoom: ChatRoomMediator {
    func showMessage(sender: User, message: String) {
        print("\(sender.name): \(message)")
    }
}

// Usage

let chatRoom = ChatRoom()

let alice = User(name: "Alice", chatMediator: chatRoom)
let bob = User(name: "Bob", chatMediator: chatRoom)

alice.send(message: "Hi Bob!")
alice.send(message: "Hellow Alice!")
