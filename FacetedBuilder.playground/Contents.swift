
import Foundation

public class Person: CustomStringConvertible {

    // Address detail
    var street: String = ""
    var city: String = ""
    var pincode: String = ""

    // Employment detail
    var companyName: String = ""
    var position: String = ""
    var annualIncome: Int = 0

    public var description: String {
        "I live at \(street), \(city), \(pincode). I work at \(companyName), as a \(position), in annual package of \(annualIncome)."
    }
}

protocol PersonBuilding {
    var lives: PersonAddressBuilder { get }
    var works: PersonJobBuilder { get }
    func build() -> Person
}

public class PersonBuilder: PersonBuilding {

    var person: Person = Person()

    var lives: PersonAddressBuilder {
        PersonAddressBuilder(person)
    }

    var works: PersonJobBuilder {
        PersonJobBuilder(person)
    }

    public func build() -> Person {
        self.person
    }
}

final class PersonAddressBuilder: PersonBuilder {

    public init(_ person: Person) {
        super.init()
        self.person = person
    }

    public func setStreet(_ street: String) -> PersonAddressBuilder {
        person.street = street
        return self
    }

    public func setCity(_ city: String) -> PersonAddressBuilder {
        person.city = city
        return self
    }

    public func setPincode(_ pincode: String) -> PersonAddressBuilder {
        person.pincode = pincode
        return self
    }
}

final class PersonJobBuilder: PersonBuilder {

    public init(_ person: Person) {
        super.init()
        self.person = person
    }

    public func setCompanyName(_ companyName: String) -> PersonJobBuilder {
        person.companyName = companyName
        return self
    }

    public func setPosition(_ position: String) -> PersonJobBuilder {
        person.position = position
        return self
    }

    public func setAnnualIncome(_ income: Int) -> PersonJobBuilder {
        person.annualIncome = income
        return self
    }
}

let personBuilder = PersonBuilder()
let person = personBuilder
    .lives
        .setStreet("Johnpur Marg")
        .setCity("Kotdwara")
        .setPincode("246149")
    .works
        .setCompanyName("Infosys Limited")
        .setPosition("Tech Lead")
        .setAnnualIncome(123456)
    .build()

print(person.description)
