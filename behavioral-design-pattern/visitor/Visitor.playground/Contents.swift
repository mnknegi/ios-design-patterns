
/*
 Behavioral design pattern that let us add new operations to existing object structures without modifying their classes.
 It separates the algorithm from the objects it operates on.

 Key Idea:
 - You have an object structure(like a group of elements).
 - Instead of putting logic inside each element, we create a visitor that performs operations on them.
 - When you need a new operation, you simply add a new visitor - no need to change the element classes.
 */

// Example

// File System(Files and Folders)

// Define the Visitor Protocol
protocol FileSystemVisitor {
    func visit(_ file: File)
    func visit(_ folder: Folder)
}

protocol FileSystemItem {
    func accept(_ visitor: FileSystemVisitor)
}

class File: FileSystemItem {
    let name: String
    let size: Int

    init(name: String, size: Int) {
        self.name = name
        self.size = size
    }

    func accept(_ visitor: any FileSystemVisitor) {
        visitor.visit(self)
    }
}

class Folder: FileSystemItem {
    let name: String
    let items: [FileSystemItem]

    init(name: String, items: [FileSystemItem]) {
        self.name = name
        self.items = items
    }

    func accept(_ visitor: any FileSystemVisitor) {
        visitor.visit(self)
    }
}

// Create concrete visitor
class SizeCalculatorVisitor: FileSystemVisitor {
    private(set) var totalSize = 0

    func visit(_ file: File) {
        totalSize += file.size
    }

    func visit(_ folder: Folder) {
        for item in folder.items {
            item.accept(self)
        }
    }
}

class NamePrinterVisitor: FileSystemVisitor {
    func visit(_ file: File) {
        print("File: \(file.name)")
    }

    func visit(_ folder: Folder) {
        print("Folder: \(folder.name)")
        for item in folder.items {
            item.accept(self)
        }
    }
}

let file1 = File(name: "Document.pdf", size: 200)
let file2 = File(name: "Photo.jpg", size: 500)
let folder = Folder(name: "MyFiles", items: [file1, file2])

let sizeVisitor = SizeCalculatorVisitor()
folder.accept(sizeVisitor)
print("Total size: \(sizeVisitor.totalSize)")  // Output: Total size: 700

let nameVisitor = NamePrinterVisitor()
folder.accept(nameVisitor)
// Output:
// Folder: MyFiles
// File: Document.pdf
// File: Photo.jpg
