
/*
 It is behavioral design pattern that defines the skeleton of an in superclass but lets subclass override specific steps of the algorithm without chaning its structure.

 Key Idea:
 - The template method is defined in the base class(abstract or concrete).
 - Subclasses can override certain steps of the algorithm.
 - The overall workflow stays fixed.
 */

// Base class with Template Method

class DataImporter {

    // template method
    final func importData() {
        self.openFile()
        self.parseData()
        self.closeFile()
    }

    func openFile() {
        print("Opening file...")
    }

    func parseData() {
        fatalError("Subclasses must override parseData()")
    }

    func closeFile() {
        print("Closing file...")
    }
}

// Subclass Override a Step

class CVSImporter: DataImporter {
    override func parseData() {
        print("Parsing CSV data.")
    }
}

class JSONImporter: DataImporter {
    override func parseData() {
        print("Parsing JSON data.")
    }
}

// Usage
let cvsImporter = CVSImporter()
cvsImporter.importData()

let jsonImporter = JSONImporter()
jsonImporter.parseData()

/*
 Benefits:
 - Avoid duplication of overall algorithm.
 - Subclasses customize only the specific steps.
 - Promotes the DRY principle(Don't Repeat Yourself).

 Real world scenario:
 - UIViewController lifecycle methods are the part of the template where the system executes the overall workflow, but you customize specific steps.
 - UITableView handles the skeleton of cell reuse and layout, but you customize specific steps like cellForRowAt().

 Key Points
 - The Template method is usually marked `final` to prevent subclasses from changing the algorithm's structure.
 - The pattern is great when you want to preserve the workflow but allow customization of certain steps.
 */
