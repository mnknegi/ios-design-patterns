

/**
 The Factory Pattern is a creational design pattern used to create objects without specifying the exact class of the object that will be created.
 Instead, it provides a way to delegate the instantiation logic to a separate factory method or class.
 This helps in creating objects in a more flexible and maintainable way, especially when the exact type of object to be created may vary or change over time.

 Factory Pattern is used to replace direct construction call with calls to specific factory methods.
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


protocol Shape {
    func draw()
}

final class Circle: Shape {
    func draw() {
        print("Draw Circle...")
    }
}

final class Square: Shape {
    func draw() {
        print("Draw Square...")
    }
}

final class Rectangle: Shape {
    func draw() {
        print("Draw Rectangle...")
    }
}

protocol ShapeMaker {
    func goemetricalShape() -> Shape
}

final class CircularShapeMaker: ShapeMaker {
    func goemetricalShape() -> Shape {
        Circle()
    }
}

final class SquareShapeMaker: ShapeMaker {
    func goemetricalShape() -> Shape {
        Square()
    }
}

final class RectangleShapeMaker: ShapeMaker {
    func goemetricalShape() -> Shape {
        Rectangle()
    }
}
/*
final class ShapeFactory {

    enum Geometry {
        case circle
        case square
        case rectangle
    }

    let geometry: Geometry

    init(geometry: Geometry) {
        self.geometry = geometry
    }

    func createShape() -> Shape {
        switch geometry {
        case .circle:
            Circle()
        case .square:
            Square()
        case .rectangle:
            Rectangle()
        }
    }
}

let geometry: ShapeFactory.Geometry = .rectangle
let shapeFactory = ShapeFactory(geometry: geometry)
let shape = shapeFactory.createShape()
shape.draw()
*/

final class ShapeFactory {

    let factory: ShapeMaker

    init(factory: ShapeMaker) {
        self.factory = factory
    }

    func createShape() -> Shape {
        self.factory.goemetricalShape()
    }
}

let shapeMaker = RectangleShapeMaker()
let shapeFactory = ShapeFactory(factory: shapeMaker)
let shape = shapeMaker.goemetricalShape()
shape.draw()
