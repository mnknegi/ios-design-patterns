/**
 * `Proxy Pattern: ` It is a structural design pattern that provides an object that acts as a substitute for a real object used by a client.
 * A proxy receives client request, does some work(access control, caching etc.) and passes the request to the service object.
 *
 * The Proxy design pattern is a structural pattern that provides an object representing another object. It acts as an intermediary, controlling access to the underlying object. This pattern is useful for various purposes, such as lazy initialization, access control, logging, or caching.
 */

import Foundation

protocol Image {
    func display()
}

final class RealImage: Image {
    private let fileName: String

    init(fileName: String) {
        self.fileName = fileName
        loadFromDisk()
    }

    func display() {
        print("Displaying \(fileName)")
    }

    private func loadFromDisk() {
        print("Loading \(fileName) from disk")
    }
}

final class ProxyImage: Image {
    private let fileName: String
    private var realImage: RealImage?

    init(fileName: String) {
        self.fileName = fileName
    }

    func display() {
        if let realImage {
            realImage.display()
        }
        realImage = RealImage(fileName: fileName)
    }
}

let image = ProxyImage(fileName: "test_image.png")
image.display()
image.display()


/*-----------------  Adding timing and logging  --------------------*/

protocol ExampleProtocol {
    func performAction()
}

struct ExampleService: ExampleProtocol {
    func performAction() {
        // Perform a long running complex task
    }
}

struct ProfilingExampleService: ExampleProtocol {

    private let exampleService: ExampleService

    init(exampleService: ExampleService) {
        self.exampleService = exampleService
    }

    func performAction() {
        let startingTime = Date()

        self.exampleService.performAction()

        let endingTime = Date()

        print("Time Elapsed: \(endingTime.timeIntervalSince(startingTime))")
    }
}

let service = ProfilingExampleService(exampleService: ExampleService())
service.performAction()


/*-----------------  Caching  --------------------*/

protocol VideoDownloadService {
    func getVideo(url: String)
}

final class MainVideoDownloadService: VideoDownloadService {

    func getVideo(url: String) {
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!)).resume()
    }
}

final class SmartVideoDownloadService: VideoDownloadService {
    private var cache = [String: URLSessionDataTask]()

    func getVideo(url: String) {
        if cache[url] == nil {
            let downloadTask = URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!))
            cache[url] = downloadTask
            downloadTask.resume()
        } else {
            print("We've already started downloading that video")
            print("Time Remaining: \(String(describing: cache[url]?.progress.estimatedTimeRemaining))")
        }
    }
}

/*-----------------  Granting Conditional Access  --------------------*/

protocol SensitiveOperation {
    func performDestrictiveAction()
}

final class DatabaseService: SensitiveOperation {
    func performDestrictiveAction() {

    }
}

final class DatabaseServiceProxy: SensitiveOperation {

    let isAdmin: Bool
    private let databaseService: DatabaseService

    init(isAdmin: Bool, databaseService: DatabaseService) {
        self.isAdmin = isAdmin
        self.databaseService = databaseService
    }

    func performDestrictiveAction() {
        guard isAdmin else {
            print("You don't have admin access to delete this database.")
            return
        }
        self.databaseService.performDestrictiveAction()
    }
}

// Parental Controls

protocol WebBrowser {
    func goToSite(url: String)
}

final class DefaultWebBrowser: WebBrowser {
    func goToSite(url: String) {
        // Navigate to url
    }
}

final class ParentalControlWebBrowser: WebBrowser {

    let blockedWebsites = [
        "www.youtube.com",
        "www.twitter.com",
        "www.facebook.com"
    ]

    private let defaultwebBrowser: WebBrowser

    init(defaultwebBrowser: WebBrowser) {
        self.defaultwebBrowser = defaultwebBrowser
    }

    func goToSite(url: String) {
        guard !blockedWebsites.contains(url) else {
            print("This website is blocked.")
            return
        }

        self.defaultwebBrowser.goToSite(url: url)
    }
}
