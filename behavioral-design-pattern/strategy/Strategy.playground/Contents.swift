
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

// Usage

let ccPayment = CreditCardPayment()
var context = PaymentContext(strategy: ccPayment)
context.pay(amount: 100.0)

context.setStrategy(PayPalPayment())
context.pay(amount: 200.0)

context.setStrategy(ApplePayment())
context.pay(amount: 300.0)

/*
 Benefits:
 - Eliminates giant if-else or switch statements.
 - Add new strategy without changing its context(follow open/close principle).
 - Change behavior at runtime.


 Different from State design pattern
 State pattern - focus on state transitions, the context itself changes behavour and it is ofter tied with the idea of stateful logic.

 Strategy pattern - Focus on interchangable algorithm, the algorithm is injected into the context and it is more about stateless behavior swap.

 In summary:
 State pattern - The same method behaves differently based on the object's current state.
 Strategy pattern - The same task can be done using different algorithms that can be swapped in/out.
 */
