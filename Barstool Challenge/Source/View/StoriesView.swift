//
//  StoriesView.swift
//  Barstool Challenge
//
//  Created by Bobby Nicoloulias on 5/22/24.
//

import SwiftUI

struct StoriesView: View {
    @StateObject var storiesViewModel = StoriesViewModel()
    
    var body: some View {
        ScrollView {
            Grid(alignment: .top, horizontalSpacing: DrawingConstants.gridHorizontalSpacing) {
                ForEach(storiesViewModel.storyPairs, id: \.self) { storyPair in
                    GridRow {
                        ForEach(storyPair, id: \.self) { story in
                            if let story = story {
                                NavigationLink(destination: StoryDetailView(story: story)) {
                                    VStack(alignment: .center) {
                                        
                                        HeaderView(with: story)
                                        
                                        AuthorView(with: story)
                                        
                                        Divider()
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("barstoolLogo")
                        .resizable()
                        .scaledToFit()
                }
            }
            .task {
                do {
                    await storiesViewModel.fetchStories()
                }
            }
        }
    }
    
    @ViewBuilder
    private func HeaderView(with story: Story) -> some View {
        Text(story.title)
            .multilineTextAlignment(.center)
            .font(.headline)
        
        AsyncImage(url: URL(string: story.thumbnail.raw)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(maxHeight: DrawingConstants.thumbnailHeight)
    }
    
    @ViewBuilder
    private func AuthorView(with story: Story) -> some View {
        HStack {
            if let avatar = story.author.avatar {
                AsyncImage(url: URL(string: avatar)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: DrawingConstants.avatarWidth, height: DrawingConstants.avatarHeight)
                .clipShape(Circle())
            }
            VStack(alignment: .leading) {
                Text(story.author.name)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                if let brandName = story.brandName {
                    Text(brandName)
                        .italic()
                        .font(.footnote)
                        .foregroundStyle(.secondary)
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
