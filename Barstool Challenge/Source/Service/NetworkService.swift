//
//  NetworkService.swift
//  Barstool Challenge
//
//  Created by Bobby Nicoloulias on 5/22/24.
//

import Foundation
import Get

class NetworkService {
    static let shared = NetworkService()
    
    enum NetworkError: Error {
        case invalidURL
        case requestFailed(URLError)
        case decodingFailed(Error)
        case unknown(Error)
    }
    
    private let client: APIClient

    private init() {
        self.client = APIClient(baseURL: URL(string: "https://union.barstoolsports.com/v2"))
        self.client.configuration.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func request<T: Decodable>(path: String, query: [(String, String?)]?) async throws -> T {
        let request = Request<T>(path: path, query: query)
        
        do {
            return try await client.send(request).value
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
