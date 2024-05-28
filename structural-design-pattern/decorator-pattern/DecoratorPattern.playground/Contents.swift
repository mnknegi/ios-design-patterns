
/**
 * `Decorator pattern` is a `Structural desing pattern` that allows `adding new behaviours to object dynamically by placing them inside special wrapper objects called decorators`.
 * It has two components
 * `Core Object :` That will have its behaviour modified.
 * `Decorator :` That brings about the changes in core object's behaviour.
 *
 * Decorator enhance behavior that already exist in the core object. They share the same interface as the core object, but provide a different implementation.
 * Decorators do not simply modify behavior, but they do so dynamically. In other words, they change how objects work during run time instead of compile time.
 *
 * Provides dynamic way to change the object's behaviour through wrappers.
 * Dacorator share a base type with core object making them interchangable. This allow usage without braking client side code.
 * Multiple decorators can be applied to create complex chain of behaviour.
 * The order in which the decorators are applied may change the final output.
 */

/** `Racing Car Example`
protocol Transporting {
    func getSpeed() -> Double
    func getTraction() -> Double
}

// Core component
final class RaceCar: Transporting {

    private let speed = 10.0
    private let traction = 10.0

    func getSpeed() -> Double {
        speed
    }

    func getTraction() -> Double {
        traction
    }
}

// Abstract Decorator
class OffRoadTireDecorator: Transporting {

    // Reference to the wrapped object.
    private let transportable: Transporting

    init(transportable: Transporting) {
        self.transportable = transportable
    }

    func getSpeed() -> Double {
        self.transportable.getSpeed() - 3.0
    }

    func getTraction() -> Double {
        self.transportable.getTraction() + 3.0
    }
}

class ChainedTireDecorator: Transporting {

    private let transportable: Transporting

    init(transportable: Transporting) {
        self.transportable = transportable
    }

    func getSpeed() -> Double {
        self.transportable.getSpeed() - 1.0
    }

    func getTraction() -> Double {
        self.transportable.getTraction() * 1.1
    }
}

let raceCar = RaceCar()
let defaultSpeed = raceCar.getSpeed()
let defaultTraction = raceCar.getTraction()

let offRoadTireDecorator = OffRoadTireDecorator(transportable: raceCar)
let offRoadTireSpeed = offRoadTireDecorator.getSpeed()
let offRoadTireTraction = offRoadTireDecorator.getTraction()

// Decorating a decorator

let chainedTireDecorator = ChainedTireDecorator(transportable: offRoadTireDecorator)
let chainedTireSpeed = chainedTireDecorator.getSpeed()
let chainedTireTraction = chainedTireDecorator.getTraction()
*/

/**
 `Coffee Example`
 */

// Interface
protocol Coffee {
    func cost() -> Double
    func description() -> String
}

// Core component
final class SimpleCoffee: Coffee {

    func cost() -> Double {
        10.0
    }

    func description() -> String {
        "Simple Coffee"
    }
}

// Decorator
final class MilkDecorator: Coffee {

    private let decoratedCoffee: Coffee

    init(decoratedCoffee: Coffee) {
        self.decoratedCoffee = decoratedCoffee
    }

    func cost() -> Double {
        self.decoratedCoffee.cost() + 30.0
    }

    func description() -> String {
        self.decoratedCoffee.description() + " with added milk."
    }
}

final class SugarDecorator: Coffee {

    private let decoratedCoffee: Coffee

    init(decoratedCoffee: Coffee) {
        self.decoratedCoffee = decoratedCoffee
    }

    func cost() -> Double {
        self.decoratedCoffee.cost() + 40.0
    }

    func description() -> String {
        self.decoratedCoffee.description() + " with extra sugar."
    }
}

final class MilkPlusSugarDecorator: Coffee {

    private let decoratedCoffee: Coffee

    init(decoratedCoffee: Coffee) {
        self.decoratedCoffee = decoratedCoffee
    }

    func cost() -> Double {
        self.decoratedCoffee.cost() + 70.0
    }

    func description() -> String {
        self.decoratedCoffee.description() + " with extra milk and sugar."
    }
}

let simpleCoffee = SimpleCoffee()
let milkDecorator = MilkDecorator(decoratedCoffee: simpleCoffee)
let milkCoffeeCost = milkDecorator.cost()
let milkCoffeDescription = milkDecorator.description()

let sugarDecorator = SugarDecorator(decoratedCoffee: simpleCoffee)
let sugarCoffeeCost = sugarDecorator.cost()
let sugarCoffeeDescription = sugarDecorator.description()

let milkPlusSugarDecorator = MilkPlusSugarDecorator(decoratedCoffee: simpleCoffee)
let milkPlusSugarCoffeeCost = milkPlusSugarDecorator.cost()
let milkPlusSugarCoffeeDescription = milkPlusSugarDecorator.description()
