import AppConfiguration
import AppLogger
import Dependencies
import Foundation
import OSLog
import Utils

enum NetworkingError: Error {
    case badURL
}

private let logger = AppLogger(loggerType: Logger(subsystem: "Networking", category: "Request"))

public struct Networking {

    private let apiEndPoint: String
    private let apiKey: String

    @Dependency(\.requester) var requester

    public init(
        apiEndPoint: String = AppConfiguration.API.apiEndPoint,
        apiKey: String = AppConfiguration.API.apiKey
    ) {
        self.apiEndPoint = apiEndPoint
        self.apiKey = apiKey
    }

    public func request<T: Decodable>(service: ServiceType) async throws -> T {

        var components = URLComponents()
        components.scheme = "https"
        components.host = apiEndPoint
        components.path = service.path

        if service.method == .get {
            components.queryItems = service.quertyItems
        }

        components.queryItems?.append(.init(name: "client_id", value: apiKey))

        guard let url = components.url else {
            logger.error(message: "Invalid URL")
            throw URLError(URLError.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = service.method.rawValue
        request.httpBody = service.data

        logger.info(message: "request made on \(request)")

        do {
            let (data, _) = try await requester.data(for: request, delegate: nil)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode(T.self, from: data)
        } catch {
            if !(error is CancellationError) || (error as? URLError)?.code != .cancelled {
                logger.error(message: "error for \(request) : \(error.localizedDescription)")
            }
            throw error
        }
    }
}
