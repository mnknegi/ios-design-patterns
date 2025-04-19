
/**
 * It is a structural design pattern that lets you split a large class or closely related classes into two sets of hierarchies - Abstraction and Implementation.
 * These two classes can be developed independently of each other.
 * `Bridge` is a structural design pattern that is aimed to decoupled the abstraction from the implementation.
 * This is done to allow both vary independently.
 * Bridge pattern adds an additional layer of abstraction that saves the code-base from unneeded refactoring and class hierarchy explosion.
 *
 * Class hierarchy explosion means that overtime when the requirements change and more classes are added to hierarchies, it becomes hard to control complexities and the code managable.
 */

enum PhoneNumber: Int {
    case mom = 12345
    case dad = 23456
    case sister = 34567
    case brother = 45678
    case other = 56789
}

protocol MobilePhone {

    var name: String { get }
    var model: String { get }

    func turnOn()
    func turnOff()
}

protocol Chargable {

    var device: MobilePhone { get }

    func charge()
}

protocol Callable {

    func call(number: PhoneNumber)
    func hangOut()
}

final class Apple: MobilePhone, Callable {

    var name: String = "iPhone"
    var model: String = "14"

    func turnOn() {
        print("Turned on : \(name)")
    }

    func turnOff() {
        print("Turned off : \(name)")
    }

    private(set) var callConnected: PhoneNumber?

    func call(number: PhoneNumber) {
        print("Calling to number: \(number)")
    }

    func hangOut() {
        print("Hang out call: \(String(describing: callConnected))")
    }
}

final class Samsung: MobilePhone, Callable {

    var name: String = "Samsung"
    var model: String = "Galaxy S 24"

    func turnOn() {
        print("Turned on : \(name)")
    }

    func turnOff() {
        print("Turned off : \(name)")
    }

    private(set) var callConnected: PhoneNumber?

    func call(number: PhoneNumber) {
        print("Calling to number: \(number)")
    }

    func hangOut() {
        print("Hang out call: \(String(describing: callConnected))")
    }
}

final class Charger: Chargable {
    
    var device: MobilePhone

    init(device: MobilePhone) {
        self.device = device
    }

    func charge() {
        print("Charging : \(self.device.name) - \(self.device.model)")
    }
}

let iPhone = Apple()
iPhone.call(number: .mom)

// After the conversation with our mom, the phone is dead and needs to be recharged

let samsung = Samsung()
samsung.call(number: .dad)

// After the conversation with our dad, the phone is dead and needs to be recharged

// Create a single charger and attach iPhone to it

let charger = Charger(device: iPhone)
charger.charge()

charger.device = samsung
charger.charge()

/**
 * Here Abstraction is represented by `MobilePhone` protocol. `Chargable` protocol represents the implementation, since it knows about abstraction part and can perform some actions for it. The concrete implementation for `Chargable` protocol called `Charger` is often called as `implementor` because it provides means to interfare with abstraction part.
 */

// -----------------------------  Example 2  ----------------------------- //

// Imagine you're developing a drawing application where you have different shapes (e.g., circle, square) and you want to draw them on different platforms (e.g., iOS, macOS). You can use the Bridge pattern to separate the shape abstraction from the platform-specific drawing implementation.

// Abstraction Protocol
protocol Shape {
    var renderer: Renderer { get }
    func draw()
}

// Implementor Protocol
protocol Renderer {
    func renderCircle(radius: Double)
    func renderSquare(side: Double)
}

// Concrete Implementation
final class IOSRenderer: Renderer {
    func renderCircle(radius: Double) {
        print("Drawing a circle with radius \(radius) on iOS")
    }
    
    func renderSquare(side: Double) {
        print("Drawing a square with side \(side) on iOS")
    }
}

final class MacOSRenderer: Renderer {
    func renderCircle(radius: Double) {
        print("Drawing a circle with radius \(radius) on iOS")
    }

    func renderSquare(side: Double) {
        print("Drawing a square with side \(side) on iOS")
    }
}

// Refined Abstraction
final class Circle: Shape {
    var renderer: Renderer
    var radius: Double

    init(renderer: Renderer, radius: Double) {
        self.renderer = renderer
        self.radius = radius
    }

    func draw() {
        self.renderer.renderCircle(radius: radius)
    }
}

final class Square: Shape {
    var renderer: Renderer
    var radius: Double

    init(renderer: Renderer, radius: Double) {
        self.renderer = renderer
        self.radius = radius
    }

    func draw() {
        self.renderer.renderCircle(radius: radius)
    }
}

let iOSRenderer = IOSRenderer()
let macOSRenderer = MacOSRenderer()

let circle = Circle(renderer: iOSRenderer, radius: 12.0)
circle.draw()

let square = Square(renderer: macOSRenderer, radius: 15.0)
square.draw()

circle.renderer = macOSRenderer
circle.draw()

/**
 * The Shape protocol represents the `abstraction`. It holds a reference to a Renderer and defines a draw method.
 * The Renderer protocol represents the` implementation`. It defines methods for rendering different shapes.
 * IOSRenderer and MacOSRenderer are `concrete implementors` that provide platform-specific implementations of the Renderer protocol.
 * Circle and Square are `refined abstractions` that implement the Shape protocol. They delegate the actual drawing work to the renderer.
 * The Bridge pattern is particularly useful when you need to combine different abstractions and implementations dynamically, making your code more flexible and maintainable.
 */

// -----------------------------  Example 2  ----------------------------- //
/*
 Imagine you have a class called Geometry and two subclasses of this Geometry class is Circle and Square. Now we need to add colors to these Geometry and for that we will extend the subclasses as well as we also require to add two new classes. We now have total four subclasses - RedCircle, RedSquare, BlueCircle and BlueSquare.
 */

/* violation */
class Geometry {
    func draw() {
        print("draw shape")
    }
}

class RedCircle: Geometry {
    override func draw() {
        print("Draw red circle")
    }
}

class RedSquare: Geometry {
    override func draw() {
        print("Draw red square")
    }
}

class BlueCircle: Geometry {
    override func draw() {
        print("Draw blue circle")
    }
}

class BlueSquare: Geometry {
    override func draw() {
        print("Draw blue square")
    }
}

/* The number of subclasses will grow as a new geometry or a color is added. */

/* Solution */
/*
 * The problem occures because we are trying to extend the shape classes into two independent dimentions: form or color.
 * We can solve this problem by switching from `inheritence` to the `object composition`.
 * We need to extract one of the dimention into a separate class hierarchy, so that the original class will reference an object of the new hierarchy, instead of having all of its state and behaviour within one class.
 */

// Implementation side(this implementation is different from the protocol implementation)
protocol Color {
    func fill() -> String
}

class Red: Color {
    func fill() -> String {
        "Red"
    }
}

class Blue: Color {
    func fill() -> String {
        "Blue"
    }
}

class Black: Color {
    func fill() -> String {
        "Black"
    }
}

class Gray: Color {
    func fill() -> String {
        "Gray"
    }
}

// Abstraction side
class NewGeometry {
    let color: Color

    init(color: Color) {
        self.color = color
    }

    func draw() {
        // implemented by subclasses.
    }
}

final class CircleGeometry: NewGeometry {
    override func draw() {
        print("Drawing a \(color.fill()) Circle")
    }
}

final class SquareGeometry: NewGeometry {
    override func draw() {
        print("Drawing a \(color.fill()) Square")
    }
}

var geometry: NewGeometry = CircleGeometry(color: Red())
geometry.draw()

geometry = CircleGeometry(color: Black())
geometry.draw()
