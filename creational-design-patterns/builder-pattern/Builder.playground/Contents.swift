
import Foundation

/**
// Creatinal Design Pattern:  Builder Pattern
/**
 * Builds an object step-by-step.
 *
 * It has three components:
 * `Director:` Accepts input and coordintes with the builder. It takes builder as a parameter and returns a product.
 * `Builder:` It is the one which accepts step-by-step inputs and handles the creation of the product. This is the place where we setup our `setters`.
 * `Product:` It is the complex object to be created and it is usually a model class.
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

    public func addSauces(_ sauce: Sauces) -> Self {
        sauces.insert(sauce)
        return self
    }

    public func removeSauces(_ sauce: Sauces) -> Self {
        sauces.remove(sauce)
        return self
    }

    public func addTopping(_ topping: Toppings) -> Self {
        toppings.insert(topping)
        return self
    }

    public func removeTopping(_ topping: Toppings) -> Self {
        toppings.remove(topping)
        return self
    }

    public func setMeat(_ meat: Meat) -> Self {
        self.meat = meat
        return self
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

// MARK: - My Custom Burger Using FluentBuilder

let mammasHamburgerBuilder = HamburgerBuilder()
    .setMeat(.tofu)
    .addSauces([.ketchup, .mayonnaise, .mustard])
    .addTopping([.cheese, .lettuce, .onion, .pickles, .tomatoes])
    .removeSauces(.mayonnaise)
    .removeTopping(.lettuce)

let mammasBurger = mammasHamburgerBuilder.build()

print(mammasBurger.description)
*/

/**
 * A builder design pattern is a creational design pattern that allow step-by-step creation of the complex object. It is particularly useful when you need to construct an object with many configuration options, and you want to insure that the object is immutable once it is fully constructed.
 */

// Product
struct User {
    let name: String
    let age: Int
    var email: String? = nil
    var address: String? = nil
    var phoneNumber: String? = nil
}

// Builder
final class ProfileBuilder {

    private var user: User

    init(name: String, age: Int) {
        self.user = User(name: name, age: age)
    }

    func setEmail(_ email: String) -> Self {
        self.user.email = email
        return self
    }

    func setAddress(_ address: String) -> Self {
        self.user.address = address
        return self
    }

    func setPhoneNumber(_ phoneNumber: String) -> Self {
        self.user.phoneNumber = phoneNumber
        return self
    }

    func build() -> User {
        self.user
    }
}

let basicUserProfile = ProfileBuilder(name: "John Doe", age: 32)
let basicUser = basicUserProfile
    .build()
print(basicUser)

let detailedUserProfile = ProfileBuilder(name: "Jane Doe", age: 28)
let detailedUser = detailedUserProfile
    .setEmail("jane.doe@xyz.com")
    .setPhoneNumber("9876543210")
    .setAddress("New York, USA")
    .build()
print(detailedUser)


/* Optional - director can host multiple functions which can return customized object.
// Director
final class UserProfile {

    func createUserProfile(using builder: ProfileBuilder) -> User {
//        builder.setEmail("abc@gmail.com")
//        builder.setAddress("New York, USA")
//        builder.setPhoneNumber("123 456 789")
        return builder.build()
    }
}

let userProfile = UserProfile()
let builder = ProfileBuilder(name: "abc", age: 30)
builder.setEmail("abc@gmail.com")
userProfile.createUserProfile(using: builder)


let userProfileBuilder = ProfileBuilder(name: "xyz", age: 32)
    .setEmail("xyz@gmail.com")
    .setAddress("Melbourne, AUS")
    .setPhoneNumber("987 654 321")
    .build()
 */
