
/* Composite Pattern
*
* It is a structural design pattern that's really useful when you want to treat individual objects and groups of objects uniformly.
* It allow us to build a tree like structure of objects.
* Both leaf objects and composite objects(which holds children) implement the same interface.
* Common for UI frameworks(like UIKit and SwiftUI).
*/

//----------------------- Example 1 -----------------------//
protocol FileComponent {
    var name: String { get }
    func display(indent: String)
}

// Leaf class(File)
class File: FileComponent {
    let name: String

    init(name: String) {
        self.name = name
    }

    func display(indent: String = "") {
        print("\(indent)- File: \(name)")
    }
}

// Composite class(Floder)
class Folder: FileComponent {
    let name: String

    var children: [FileComponent] = []

    init(name: String) {
        self.name = name
    }

    func add(component: FileComponent) {
        children.append(component)
    }

    func display(indent: String = "") {
        print("\(indent)+ Folder: \(name)")
        for child in children {
            child.display(indent: indent + "  ")
        }
    }
}

let file1 = File(name: "resume.pdf")
let file2 = File(name: "coverletter.doc")
let file3 = File(name: "project.swift")

let personalFolder = Folder(name: "Personal")
personalFolder.add(component: file1)
personalFolder.add(component: file2)

let workFloder = Folder(name: "Work")
workFloder.add(component: file3)

let rootFolder = Folder(name: "Root")
rootFolder.add(component: personalFolder)
rootFolder.add(component: workFloder)

rootFolder.display()

//----------------------- Example 2 -----------------------//
import SwiftUI

// leaf view 1
struct TitleView: View {

    var title: String

    var body: some View {
        Text(title)
            .font(.title)
            .padding()
    }
}

// leaf view 2
struct IconView: View {

    var imageName: String

    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .frame(width: 60, height: 60)
            .foregroundStyle(.blue)
            .padding(.bottom, 10)
    }
}

// leaf view 3
struct FooterButtonView: View {
    var body: some View {
        Button("Tap me") {
            print("Button Tapped")
        }
        .padding(.top, 10)
    }
}

// intermediate view
struct CardView: View {

    var title: String
    var imageName: String

    var body: some View {
        VStack {
            IconView(imageName: imageName)
            TitleView(title: title)
            FooterButtonView()
        }
        .padding()
        .background(.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 5)
    }
}

// root view
struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            CardView(title: "SwiftUi", imageName: "swift")
            CardView(title: "Calendar", imageName: "calendar")
        }
        .padding()
    }
}
