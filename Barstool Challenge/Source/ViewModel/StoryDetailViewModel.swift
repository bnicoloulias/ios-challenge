//
//  StoryDetailViewModel.swift
//  Barstool Challenge
//
//  Created by Bobby Nicoloulias on 5/22/24.
//

import Foundation

@MainActor
class StoryDetailViewModel: ObservableObject {
    @Published var storyDetail: StoryDetail?
    let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchStory(with id: Int) async {
        do {
            storyDetail = try await networkService.request(endpoint: "https://union.barstoolsports.com/v2/stories/\(id)")
        } catch {
            print(error)
        }
    }
}
