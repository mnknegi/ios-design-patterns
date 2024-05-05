
import Foundation

// Creatinal Design Pattern:  Builder Pattern
/**
 * Builds an object step-by-step.
 * Director: Accepts input and coordintes with the builder. It takes builder as a parameter and returns a product.
 * Builder: It is the one which accepts step-by-step inputs and handles the creation of the product. This is the place where we setup our `setters`.
 * Product: It is the complex object to be created and it is usually a model class.
 */

// MARK: - Product

public struct Hamburger {
    let meat: Meat
    let sauce: Sauces
    let toppings: Toppings
}

extension Hamburger: CustomStringConvertible {
    public var description: String {
        "Here is your burger. It has \(meat.rawValue) as meat; \(sauce.description) as sauce; and \(toppings.description) as topping in it. Bon Appetit!"
    }
}

public enum Meat: String {
    case beaf
    case chicken
    case tofu
}

public struct Sauces: OptionSet {

    public let rawValue: Int

    public static let mayonnaise = Sauces(rawValue: 1 << 0)
    public static let mustard = Sauces(rawValue: 1 << 1)
    public static let ketchup = Sauces(rawValue: 1 << 2)
    public static let barbeque = Sauces(rawValue: 1 << 3)

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

extension Sauces: CustomStringConvertible {

    public static var debugDescription: [(Self,String)] = [
        (.mayonnaise, "mayonnaise"),
        (.mustard, "mustard"),
        (.ketchup, "ketchup"),
        (.barbeque, "barbeque")
    ]

    public var description: String {
        let result = Self.debugDescription.filter { contains($0.0) }.map { $0.1 }
        let printable = result.joined(separator: ", ")

        return printable
    }
}

public struct Toppings: OptionSet {

    public var rawValue: Int

    public static let cheese = Toppings(rawValue: 1 << 0)
    public static let onion = Toppings(rawValue: 1 << 1)
    public static let lettuce = Toppings(rawValue: 1 << 2)
    public static let pickles = Toppings(rawValue: 1 << 3)
    public static let tomatoes = Toppings(rawValue: 1 << 4)

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

extension Toppings {

    private static var debugDescription: [(Self, String)] = [
        (.cheese, "cheese"),
        (.onion, "onion"),
        (.lettuce, "lettuce"),
        (.pickles, "pickles"),
        (.tomatoes, "tomatoes")
    ]

    public var description: String {
        let result = Self.debugDescription.filter { contains( $0.0) }.map { $0.1 }
        let printable = result.joined(separator: ", ")

        return printable
    }
}

// MARK: - Builder

public class HamburgerBuilder {

    public private(set) var meat: Meat = .chicken
    public private(set) var sauces: Sauces = []
    public private(set) var toppings: Toppings = []

    public func addSauces(_ sauce: Sauces) {
        sauces.insert(sauce)
    }

    public func removeSauces(_ sauce: Sauces) {
        sauces.remove(sauce)
    }

    public func addTopping(_ topping: Toppings) {
        toppings.insert(topping)
    }

    public func removeTopping(_ topping: Toppings) {
        toppings.remove(topping)
    }

    public func setMeat(_ meat: Meat) {
        self.meat = meat
    }

    public func build() -> Hamburger {
        Hamburger(
            meat: self.meat,
            sauce: self.sauces,
            toppings: self.toppings
        )
    }
}

// MARK: - Director

public class BurgerShop {

    func createCheeseBurger(using builder: HamburgerBuilder) -> Hamburger {
        builder.setMeat(.chicken)
        builder.addTopping([.cheese, .lettuce, .tomatoes])
        builder.addSauces([.barbeque, .ketchup, .mayonnaise])
        return builder.build()
    }

    func createVegetarianBurger(using builder: HamburgerBuilder) -> Hamburger {
        builder.setMeat(.tofu)
        builder.addTopping([.tomatoes, .lettuce, .pickles])
        builder.addSauces([.mustard, .mayonnaise])
        return builder.build()
    }
}

// MARK: - Driver code

let mcDonalds = BurgerShop()

let hamburgerBuilder = HamburgerBuilder()

let mcDonaldCheeseBurger = mcDonalds.createCheeseBurger(using: hamburgerBuilder)

print(mcDonaldCheeseBurger.description)

let unclePizza = BurgerShop()

let unclePizzaVegBurger = unclePizza.createVegetarianBurger(using: hamburgerBuilder)

print(unclePizzaVegBurger.description)
