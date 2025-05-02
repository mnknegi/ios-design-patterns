
/*
 Observer design pattern is a behavioral design pattern which is also know as Event-Subscriber, Listener.
 It let us define a subscription mechanism to notify multiple objects about any events that happen to the object that they are observing.

 Defines a one-to-many dependency between objects.
 When one object(the Subject) changes state, all its dependents(Observers) are notified automatically.

 Real world example

 - NotificationCentre
 Observers register for a notification, and when it is posted, all observers are notified.
 */

import NotificationCenter

extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
}

NotificationCenter.default.post(name: .didReceiveData, object: nil)

NotificationCenter.default.addObserver(forName: .didReceiveData, object: nil, queue: .main) { notification in
    print(notification)
}


// Combine framework
import Combine

let publisher = NotificationCenter.default.publisher(for: .didReceiveData)
let cancellable = publisher.sink { notification in
    print("Received data notification")
}

// --------------------------- Example --------------------------- //
// Protocols

protocol WeatherObserver: AnyObject {
    func update(temperature: Double)
}

protocol WeatherSubject {
    func addObserver(_ observer: WeatherObserver)
    func removeObserver(_ observer: WeatherObserver)
    func notifyObservers()
}

// Subject
class WeatherStation: WeatherSubject {

    private var observers: [WeatherObserver] = []
    private var temperature: Double = 0.0

    func setTemperature(_ temp: Double) {
        self.temperature = temp
        self.notifyObservers()
    }

    func addObserver(_ observer: any WeatherObserver) {
        observers.append(observer)
    }
    
    func removeObserver(_ observer: any WeatherObserver) {
        observers = observers.filter { $0 !== observer }
    }
    
    func notifyObservers() {
        observers.forEach { $0.update(temperature: temperature) }
    }
}

// Observer
class TemperatureDisplay: WeatherObserver {
    func update(temperature: Double) {
        print("Temperature updated: \(temperature)°C")
    }
}

// Usage
let station = WeatherStation()
let display = TemperatureDisplay()

station.addObserver(display)
station.setTemperature(25.0)
station.setTemperature(36.0)

/*
 Loose coupling between Subject and Observers.
 Easy to add new observers without modifying the subject.
 Help in broadcasting events.
 */
