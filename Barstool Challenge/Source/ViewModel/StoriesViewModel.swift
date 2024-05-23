//
//  StoriesViewModel.swift
//  Barstool Challenge
//
//  Created by Bobby Nicoloulias on 5/22/24.
//

import Foundation

@MainActor
class StoriesViewModel: ObservableObject {
    @Published var stories: [Story] = []
    let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchStories() async {
        do {
            stories = try await networkService.request(endpoint: "/latest?type=standard_post&page=1&limit25")
        } catch {
            print(error)
        }
    }
}
