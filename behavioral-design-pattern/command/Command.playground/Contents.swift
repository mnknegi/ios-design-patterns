
/*
 Command design pattern is a behavioral desine pattern that encapsulate a request as an object and allow us to:
 - Pass request as a method arguments.
 - Delay or queue request's execution.
 - Support undoable operations.
 - Support undo/redo operations.
 - decouple the sender of the request from its receiver.

 Key Idea

 - The command object contains all information needed to perform an action(method, receiver or parameter).
 - The invoker calls the command, and the receiver does the actual work.

 Real world scenario in iOS:

 Target-Action pattern

 - A UIButton's .addTarget(_:action:for) is like a simplified version of command. It tells which object(target) to invoke which method(action) when the event occurs.
 */

// Smart Home Command
// Imagine you have device: light and Fan

protocol Command {
    func execute()
}

// Receiver class
class Light {
    func turnOn() {
        print("Light is on")
    }

    func turnOff() {
        print("Light is on")
    }
}

class Fan {
    func start() {
        print("Fan is on")
    }

    func stop() {
        print("Fan is on")
    }
}

// Commands
class LightOnCommand: Command {
    private let light: Light

    init(light: Light) {
        self.light = light
    }

    func execute() {
        self.light.turnOn()
    }
}

class FanStartCommand: Command {
    private let fan: Fan

    init(fan: Fan) {
        self.fan = fan
    }

    func execute() {
        self.fan.start()
    }
}

// Invoker
class RemoteControl {
    private var command: Command?

    func setCommand(_ command: Command){
        self.command = command
    }

    func pressButton() {
        command?.execute()
    }
}

let light = Light()
let fan = Fan()

let lightOn = LightOnCommand(light: light)
let fanStart = FanStartCommand(fan: fan)

let remoteControl = RemoteControl()

remoteControl.setCommand(lightOn)
remoteControl.pressButton()

remoteControl.setCommand(fanStart)
remoteControl.pressButton()
