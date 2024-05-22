//
//  NetworkService.swift
//  Barstool Challenge
//
//  Created by Bobby Nicoloulias on 5/22/24.
//

import Foundation
import Get

struct NetworkService {
    private let client = APIClient(baseURL: URL(string: "https://union.barstoolsports.com/v2/stories"))
    
    func request<T: Decodable>(endpoint: String) async throws -> T {
        let request = Request<T>(path: endpoint)
        
        return try await client.send(request).value
    }
}
