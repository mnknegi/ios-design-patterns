
/**
 * The singleton pattern guarantees that only one instance of a class is instantiated.
 * Singletons are objects that should only ever be created once, then shared everywhere they need to be used.
 *
 * The class should be final so that no other class can subclass it.
 * It should have shared property that holds the instance of the singleton class and initialization is done lazily.
 * The initializer method should be private which gives the guaranee that no other instance can be created outside the class's scope.
 */

protocol MySingletonProviding {
    var state: Int { get set }
}

final class MySingleton: MySingletonProviding {

    static let instance = MySingleton()

    private init() {}

    var state: Int = 0
}

var instance: MySingletonProviding = MySingleton.instance

instance.state = 44

print(MySingleton.instance.state)

/* ========================================= */

// Default Payment Queue
// let defaultPaymentQueue = SKPaymentQueue.default()

protocol BaseURLProviding {
    var baseURL: String { get }
}

final class MyAnotherSingletonClass: BaseURLProviding {

    private static var shared = {
        let instance = MyAnotherSingletonClass(baseURL: "www.iosmantra.com")
        return instance
    }()

    var baseURL: String

    private init(baseURL: String) {
        self.baseURL = baseURL
    }

    class func `default`() -> MyAnotherSingletonClass {
        MyAnotherSingletonClass.shared
    }
}

print("BaseURL => ", MyAnotherSingletonClass.default().baseURL)
let instance1 = MyAnotherSingletonClass.default()
let instance2 = MyAnotherSingletonClass.default()

print(instance1 === instance2)

