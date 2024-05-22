//
//  StoriesViewModel.swift
//  Barstool Challenge
//
//  Created by Bobby Nicoloulias on 5/22/24.
//

import Foundation

@MainActor
class StoriesViewModel: ObservableObject {
    @Published var storyPairs: [[Story?]] = []
    let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchStories() async {
        do {
            let getStories: [Story] = try await networkService.request(endpoint: "/latest?type=standard_post&page=1&limit25")
            sortIntoPairs(stories: getStories)
        } catch {
            print(error)
        }
    }
    
    private func sortIntoPairs(stories: [Story]) {
        var pairs: [[Story?]] = []
        var currentPair: [Story?] = []
        
        for story in stories {
            currentPair.append(story)
            if currentPair.count == 2 {
                pairs.append(currentPair)
                currentPair = []
            }
        }
        
        if !currentPair.isEmpty {
            currentPair.append(nil)
            pairs.append(currentPair)
        }
        
        storyPairs = pairs
    }
}
