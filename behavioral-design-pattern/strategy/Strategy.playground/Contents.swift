
/*
 It is a behavioral design pattern that enables you to define family of algorithms, encapsulates each one, and make them interchangable at runtime.

 Key Idea:
 Instead of hardcoding an algorithm, the object:
 - Accepts a strategy(algorithm) at runtime.
 - Flexibility: You can change the algorithm without changing the context's code.

 iOS Real world example:
 sorting algorithms: you have multiple ways to sort data(by name, by date, by price) - all as different strategies.
 */


// Example (Payment Strategy)

// Define a Strategy protocol
protocol PaymentStrategy {
    func pay(amount: Double)
}

// Create concrete strategy
class CreditCardPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) using Credit Card.")
    }
}

class PayPalPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) using PayPal.")
    }
}

class ApplePayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) using Apple Pay.")
    }
}

// Context class
class PaymentContext {
    private var strategy: PaymentStrategy

    init(strategy: PaymentStrategy) {
        self.strategy = strategy
    }

    func setStrategy(_ strategy: PaymentStrategy) {
        self.strategy = strategy
    }

    func pay(amount: Double) {
        self.strategy.pay(amount: amount)
    }
}
