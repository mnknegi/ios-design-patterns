
/*
* Facade Design Pattern
* It is a structural design pattern that provides a `simplified interface to a complex subsystem`.
* It is a `front desk` a client interact with, while the internal complex subsystem stay hidden behine it.

* It is used where you want to provide a simple api to external client(ViewController using Network + Database + Analytics).
* You want to decouple the system's internal complexity from the UI layer.

* Facade: The simplified class/interface.
* Subsystem: The complex internal classes that do the actual work.
* Client: The class that interacts with the facade(UIViewController).
*/

// ---------------------------- Example 1 ---------------------------- //

/* Let's say we are building a MediaPlayer, and internally it uses AudioDecoding, VideoDecoding and Network streaming. */

// subsystem classes
final class AudioDecoding {
    func decodeAudio() {
        print("Decoding Audio...")
    }
}

final class VideoDecoding {
    func decodeVidoe() {
        print("Decoding Video...")
    }
}

final class NetworkStreaming {
    func startStreaming() {
        print("Streaming media with the network...")
    }
}

// facade class
final class MediaPlayerFacade {
    private let audioDecoding: AudioDecoding
    private let videoDecoding: VideoDecoding
    private let networkStreaming: NetworkStreaming

    init(audioDecoding: AudioDecoding,
         videoDecoding: VideoDecoding,
         networkStreaming: NetworkStreaming) {
        self.audioDecoding = audioDecoding
        self.videoDecoding = videoDecoding
        self.networkStreaming = networkStreaming
    }

    func playMedia() {
        networkStreaming.startStreaming()
        audioDecoding.decodeAudio()
        videoDecoding.decodeVidoe()
        print("Media playback started.")
    }
}

// ---------------------------- Example 2 ---------------------------- //
/*
 NewtworkManager Facade that hides the complexity of:
 * Making network requests using `URLSession`.
 * Parsing JSON data into models.
 * Handling errors.

 * Components: URLSessionService, JSON Parser, NetworkManager, A User Model
 */

import Foundation
import SwiftUI

enum NetworkError: Error {
    case badResponse
    case decodingError
}

struct User: Decodable {
    let id: Int
    let name: String
    let email: String
}

// Service
protocol RequestPerforming {
    func performRequest(_ request: URLRequest) async throws -> Data
}

actor Service: RequestPerforming {
    func performRequest(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw NetworkError.badResponse
        }
        return data
    }
}

// JSONParser
actor JSONParser {
    func parse<T: Decodable>(data: Data) async throws -> T {
        do {
            let decoder = try JSONDecoder().decode(T.self, from: data)
            return decoder
        } catch {
            throw NetworkError.decodingError
        }
    }
}

// User Service Coordinator
actor ServiceCoordinator {
    let service: RequestPerforming
    let parser: JSONParser

    init(service: RequestPerforming = Service(),
         parser: JSONParser = JSONParser()) {
        self.service = service
        self.parser = parser
    }

    func fetchUser(from request: URLRequest) async throws -> User {
        let userData = try await service.performRequest(request)
        let user: User = try await parser.parse(data: userData)
        return user
    }
}

// view model
@MainActor
final class ViewModel: ObservableObject {
    @Published var user: User?

    let serviceCoordinator: ServiceCoordinator

    init(serviceCoordinator: ServiceCoordinator = ServiceCoordinator()) {
        self.serviceCoordinator = serviceCoordinator
    }

    func getUser() async {
        guard let url = URL(string: "https://example.com/user/1") else {
            return
        }
        let request = URLRequest(url: url)
        do {
            self.user = try await self.serviceCoordinator.fetchUser(from: request)
        } catch let error as NetworkError {
            switch error {
            case .badResponse, .decodingError:
                print(error)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
