
import Foundation

/** Faceted Builder or Faceted Fluent Builder */
/*
 - A variation of standard builder pattern where the object being build is a complex and consists of multi-facets(or aspects) & each facet is build by a dedicated builder.
 - Instead of having one big builder with dozens of methods, we break it down into smaller builders, each responsible for part of the object.
 - Each facet handles the related group of fields.
 */

final class Person: CustomStringConvertible {

    // Personal
    var name: String = ""
    var age: Int = 0

    // Address
    var city: String = ""
    var street: String = ""

    // Job
    var company: String = ""
    var position: String = ""

    public var description: String {
        "\(name) who is \(age) years old lives in \(street) - \(city) and is working in \(company) at the position of \(position)."
    }
}

protocol PersonBuilding {
    var personal: PersonPersonalBuilder { get }
    var address: PersonAddressBuilder { get }
    var job: PersonJobBuilder { get }
    func build() -> Person
}

class PersonBuilder: PersonBuilding {

    var person: Person = Person()

    var personal: PersonPersonalBuilder {
        PersonPersonalBuilder(person)
    }

    var address: PersonAddressBuilder {
        PersonAddressBuilder(person)
    }

    var job: PersonJobBuilder {
        PersonJobBuilder(person)
    }

    func build() -> Person {
        self.person
    }
}

final class PersonPersonalBuilder: PersonBuilder {

    init(_ person: Person) {
        super.init()
        self.person = person
    }

    func named(_ name: String) -> PersonPersonalBuilder {
        self.person.name = name
        return self
    }

    func aged(_ age: Int) -> PersonPersonalBuilder {
        self.person.age = age
        return self
    }
}

final class PersonAddressBuilder: PersonBuilder {

    public init(_ person: Person) {
        super.init()
        self.person = person
    }

    public func lives(_ city: String) -> PersonAddressBuilder {
        self.person.city = city
        return self
    }

    public func onStreet(_ street: String) -> PersonAddressBuilder {
        self.person.street = street
        return self
    }
}

final class PersonJobBuilder: PersonBuilder {

    public init(_ person: Person) {
        super.init()
        self.person = person
    }

    public func works(_ company: String) -> PersonJobBuilder {
        self.person.company = company
        return self
    }

    public func onPosition(_ position: String) -> PersonJobBuilder {
        self.person.position = position
        return self
    }
}

let personBuilder = PersonBuilder()
let person = personBuilder
    .personal
        .named("John Doe")
        .aged(32)
    .address
        .lives("Melbourne, AUS")
        .onStreet("833, Collins")
    .job
        .works("ANZ")
        .onPosition("iOS Engineer")
    .build()

print(person.description)
