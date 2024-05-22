//
//  ContentView.swift
//  Barstool Challenge
//
//  Created by Thomas Rademaker on 1/23/23.
//

import SwiftUI

struct StoriesView: View {
    @StateObject var storiesViewModel = StoriesViewModel()
    
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, content: {
                ForEach(storiesViewModel.stories) { story in
                    VStack {
                        Text(story.title)
                    }
                }
            })
            .padding()
            .task {
                do {
                    await storiesViewModel.fetchStories()
                }
            }
        }
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView()
    }
}
