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
    @Published var searchText: String = ""
    private var isFetching = false
    private var currentPage = 1
    let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    var filteredStories: [Story] {
        if searchText.isEmpty {
            return stories
        }
        
        return stories.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    
    func fetchStories(incrementCount: Bool = false) async {
        guard !isFetching else { return }
        isFetching = true
        
        do {
            if incrementCount {
                currentPage += 1
            }
            let getStories: [Story] = try await networkService.request(endpoint: "https://union.barstoolsports.com/v2/stories/latest?type=standard_post&page=\(currentPage)&limit=25")
            let uniqueStories = getStories.filter { story in
                !stories.contains(where: { $0.id == story.id })
            }
            stories.append(contentsOf: uniqueStories)
        } catch {
            print(error)
        }
        
        isFetching = false
        
        print(currentPage)
    }
}
