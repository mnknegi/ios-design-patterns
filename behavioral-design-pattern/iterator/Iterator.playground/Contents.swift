
/*
 A behavioural design pattern that allow sequential access to the elements of the collection without exposing its underlaying representation.

 Key Idea:

 - You can traverse a collection(like an array, set etc) without knowing its internal structure.
 - It abstarcts the iteration logic from the collection itself.

 Real world scenario:

 - IteratorProtocol and Sequence are direct representation of Iterator design pattern.
 */

// Custom Iterator

class NumberIterator: IteratorProtocol {
    private let numbers: [Int]
    private var current = 0

    init(numbers: [Int]) {
        self.numbers = numbers
    }

    func next() -> Int? {
        guard current < numbers.count else {
            return nil
        }

        defer { current += 1 }
        return numbers[current]
    }
}

// Define Collection

struct NumberCollection: Sequence {
    private let numbers: [Int]

    init(numbers: [Int]) {
        self.numbers = numbers
    }

    func makeIterator() -> NumberIterator {
        return NumberIterator(numbers: numbers)
    }
}

let collection = NumberCollection(numbers: [10, 20, 30, 40])
for number in collection {
    print(number)
}
