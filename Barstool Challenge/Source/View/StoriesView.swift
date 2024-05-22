//
//  ContentView.swift
//  Barstool Challenge
//
//  Created by Thomas Rademaker on 1/23/23.
//

import SwiftUI

struct StoriesView: View {
    @StateObject var storiesViewModel = StoriesViewModel()
    
    var body: some View {
        VStack {
            List(storiesViewModel.stories) { story in
                Text(story.title)
            }
        }
        .padding()
        .task {
            do {
                await storiesViewModel.fetchStories()
            }
        }
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView()
    }
}
