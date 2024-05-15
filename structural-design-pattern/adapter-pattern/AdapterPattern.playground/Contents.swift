
/**
 * Also known as wrapper.
 * It is used to allow two incompatible interfaces to work together.
 * Example of stock market monitoring app where the app download data in XML format.
 * The third party use the JSON format to work and so we need a adapter here that is a special object which converts the interface of one object so that another object can understand it.
 * In this we wrap one of the object to hide the complexity of conversion.
 */

// ** -------------- Using Extension  -------------- ** \\

/*
final class OldPrinter {
    func printDocument() {
        print("Printing a Document...")
    }
}

final class NewPrinter {
    func dispatchPrinterDocs() {
        print("Printing or photo coping the doc...")
    }
}

protocol Printing {
    func dispatchPrintedDocs()
}

extension OldPrinter: Printing {
    func dispatchPrintedDocs() {
        self.printDocument()
    }
}
 */

// ** -------------- Using Adapter class  -------------- ** \\

// Commmon Interface

protocol Printing {
    func dispatchPrintedDocs()
}

// Old Interface

final class OldPrinter {
    func printDocument() {
        print("Printing a Document...")
    }
}

// New Interface

final class NewPrinter {
    func dispatchPrintedDocs() {
        print("Printing or photo coping the doc...")
    }
}

extension NewPrinter: Printing {}

// Adapter

final class PrinterAdapter: Printing {

    private let oldPrinter: OldPrinter

    init(oldPrinter: OldPrinter) {
        self.oldPrinter = oldPrinter
    }

    func dispatchPrintedDocs() {
        self.oldPrinter.printDocument()
    }
}

// Driver code

final class ClientCode {
    func someClientCode(printer: Printing) {
        printer.dispatchPrintedDocs()
    }
}

let clientCode = ClientCode()
let printerAdapter = PrinterAdapter(oldPrinter: OldPrinter())
clientCode.someClientCode(printer: printerAdapter)
clientCode.someClientCode(printer: NewPrinter())
