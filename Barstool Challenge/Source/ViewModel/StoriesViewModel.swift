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
    private var isFetching = false
    private var currentPage = 1
    let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchStories() async {
        guard !isFetching else { return }
        isFetching = true
        
        do {
            let getStories: [Story] = try await networkService.request(endpoint: "https://union.barstoolsports.com/v2/stories/latest?type=standard_post&page=\(currentPage)&limit=25")
            stories.append(contentsOf: getStories)
            currentPage += 1
        } catch {
            print(error)
        }
        
        isFetching = false
    }
}
