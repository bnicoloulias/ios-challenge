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
    
    func fetchStory(with id: Int) async {
        do {
            storyDetail = try await NetworkService.shared.request(path: "/stories/\(id)", query: nil)
        } catch {
            print(error)
        }
    }
}
