

/**
 * A factory pattern is a creational design pattern that uses factory methods to deal with the problem of creating objects withour having to specify their exact class. 
 * Rather than by calling a constructor, this is done by calling a factory method to create an object.
 * Factory method can be specified either in an interface and implemented by child classes, or implemented in a base class and optionally overridden by a derived class.
 *
 * The Factory Pattern is a creational design pattern used to create objects without specifying the exact class of the object that will be created.
 * Instead, it provides a way to delegate the instantiation logic to a separate factory method or class.
 * This helps in creating objects in a more flexible and maintainable way, especially when the exact type of object to be created may vary or change over time.
 *
 * Factory Pattern is used to replace direct construction call with calls to specific factory methods.
 */

/*
 import Foundation

 // Protocol defining the interface for the product
 protocol Animal {
 func makeSound()
 }

 // Concrete implementation of the product
 final class Dog: Animal {
 func makeSound() {
 print("Woof!")
 }
 }

 final class Cat: Animal {
 func makeSound() {
 print("Meow!")
 }
 }

 // Factory class responsible for creating the instance of the product
 final class AnimalFactory {
 enum AnimalType {
 case dog
 case cat
 }

 // Factory method to create instances based on the input type
 static func createAnimal(_ type: AnimalType) -> Animal {
 switch type {
 case .dog:
 return Dog()
 case .cat:
 return Cat()
 }
 }
 }

 // Usage
 let dog = AnimalFactory.createAnimal(.dog)
 dog.makeSound()

 let cat = AnimalFactory.createAnimal(.cat)
 cat.makeSound()

 /**
  * This example above potentially breaking Open Close principle.
  */

 */

protocol Animal {
    func makeSound()
}

final class Dog: Animal {
    func makeSound() {
        print("Woof!")
    }
}

final class Cat: Animal {
    func makeSound() {
        print("Meow!")
    }
}

protocol AnimalFactory {
    func createAnimal() -> Animal
}

class DogFactory: AnimalFactory {
    func createAnimal() -> Animal {
        Dog()
    }
}

class CatFactory: AnimalFactory {
    func createAnimal() -> Animal {
        Cat()
    }
}

// Driver Code

final class ClientCode {

    let factory: AnimalFactory

    init(factory: AnimalFactory) {
        self.factory = factory
    }

    func createAnimal() -> Animal {
        self.factory.createAnimal()
    }
}

var animal = ClientCode(factory: DogFactory())
animal.createAnimal().makeSound()

animal = ClientCode(factory: CatFactory())
animal.createAnimal().makeSound()

