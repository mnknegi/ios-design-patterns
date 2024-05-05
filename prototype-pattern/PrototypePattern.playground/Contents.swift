
import Foundation

/**
 * The prototype pattern is used to instantiate a new object by copying all of the properties of an existing object, creating an independent clone.
 * This practise is particularly useful when the construction of a new object is inefficient.
 */

protocol Prototype {
    func clone() -> Prototype
}

final class SmartPhone: CustomStringConvertible, Prototype {
    var name: String
    var color: String
    var capacity: Int

    init(name: String, color: String, capacity: Int) {
        self.name = name
        self.color = color
        self.capacity = capacity
    }

    var description: String {
        "\(self.name), \(self.color) with \(self.capacity) RAM."
    }

    func clone() -> Prototype {
        SmartPhone(name: self.name, color: self.color, capacity: self.capacity)
    }
}

var iPhone7Gray16GB    = SmartPhone(name: "iPhone 7", color: "Gray", capacity: 16)
var iPhone14Black64GB    = iPhone7Gray16GB.clone() as! SmartPhone
iPhone14Black64GB.name = "iPhone 14"
iPhone14Black64GB.color = "Black"
iPhone14Black64GB.capacity = 64

print(iPhone7Gray16GB.description)
print(iPhone14Black64GB.description)
