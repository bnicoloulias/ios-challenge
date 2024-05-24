//
//  Barstool_ChallengeApp.swift
//  Barstool Challenge
//
//  Created by Thomas Rademaker on 1/23/23.
//

import SwiftUI

@main
struct Barstool_ChallengeApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var storiesViewModel = StoriesViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StoriesView(storiesViewModel: storiesViewModel)
                    .onChange(of: scenePhase) { newPhase in
                        switch newPhase {
                        case .active: 
                            storiesViewModel.loadStoriesFromUserDefaults()
                        case .inactive: break
                        case .background: break
                        @unknown default:
                            break
                        }
                    }
            }
        }
    }
}
