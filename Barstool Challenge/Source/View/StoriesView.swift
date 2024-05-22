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
                    VStack(alignment: .leading) {
                        Text(story.title)
                            .font(.headline)
                        
                        AsyncImage(url: URL(string: story.thumbnail.raw)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 200, height: 200)
                        
                        HStack {
                            if let avatar = story.author.avatar {
                                AsyncImage(url: URL(string: avatar)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                            }
                            VStack(alignment: .leading) {
                                Text(story.author.name)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                
                                if let brandName = story.brandName {
                                    Text(brandName)
                                        .italic()
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }

                        Divider()
                    }
                }
            })
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
