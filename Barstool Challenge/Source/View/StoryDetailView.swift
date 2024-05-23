//
//  StoryDetailView.swift
//  Barstool Challenge
//
//  Created by Bobby Nicoloulias on 5/22/24.
//

import SwiftUI

struct StoryDetailView: View {
    let story: Story
    @StateObject var storyDetailViewModel = StoryDetailViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            if let storyDetail = storyDetailViewModel.storyDetail {
                
                Group {
                    Text(storyDetail.title)
                        .font(.headline)
                    
                    AuthorView(with: storyDetail)
                }
                .padding(.horizontal)

                
                if let content = storyDetail.postTypeMeta.standardPost?.content {
                    WebView(htmlContent: content)
                }
                
            } else {
                ProgressView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("barstoolLogo")
                    .resizable()
                    .scaledToFit()
            }
        }
        .task {
            do {
                await storyDetailViewModel.fetchStory(with: story.id)
            }
        }
    }
    
    @ViewBuilder
    private func AuthorView(with storyDetail: StoryDetail) -> some View {
        HStack {
            if let avatar = storyDetail.author.avatar {
                AsyncImage(url: URL(string: avatar)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: DrawingConstants.avatarWidth, height: DrawingConstants.avatarHeight)
                .clipShape(Circle())
            }
            VStack(alignment: .leading) {
                Text(storyDetail.author.name)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                if let brandName = storyDetail.brandName {
                    Text(brandName)
                        .italic()
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Label(
                title: { Text("\(storyDetail.commentCount)") },
                icon: { Image(systemName: "message.fill") }
            )
        }
    }
}
