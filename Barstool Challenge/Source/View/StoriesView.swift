//
//  StoriesView.swift
//  Barstool Challenge
//
//  Created by Bobby Nicoloulias on 5/22/24.
//

import SwiftUI

struct StoriesView: View {
    @StateObject var storiesViewModel = StoriesViewModel()
    
    private let gridItems = [GridItem(.flexible(), spacing: 5, alignment: .top),
                             GridItem(.flexible(), spacing: 5, alignment: .top)]
    
    private struct DrawingConstants {
        static let thumbnailHeight: CGFloat = 200
        static let thumbnailWidth: CGFloat = 200
        static let avatarHeight: CGFloat = 30
        static let avatarWidth: CGFloat = 30
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, content: {
                ForEach(storiesViewModel.filteredStories) { story in
                    NavigationLink(destination: StoryDetailView(story: story)) {
                        VStack(alignment: .center) {
                            
                            HeaderView(with: story)
                            
                            AuthorView(with: story)

                            Divider()
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .onAppear {
                        if story == storiesViewModel.stories.last {
                            Task {
                                await fetchStories(incrementCount: true)
                            }
                        }
                    }
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("barstoolLogo")
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .searchable(text: $storiesViewModel.searchText)
        .refreshable {
            await fetchStories()
        }
        .task {
            await fetchStories()
        }
    }
    
    private func fetchStories(incrementCount: Bool = false) async {
        await storiesViewModel.fetchStories(incrementCount: incrementCount)
    }
    
    @ViewBuilder
    private func HeaderView(with story: Story) -> some View {
        Text(story.title)
            .multilineTextAlignment(.center)
            .font(.headline)
        
        AsyncImage(url: URL(string: story.thumbnail.raw)) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(maxHeight: DrawingConstants.thumbnailHeight)
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
