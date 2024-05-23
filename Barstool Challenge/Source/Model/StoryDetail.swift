//
//  StoryDetail.swift
//  Barstool Challenge
//
//  Created by Bobby Nicoloulias on 5/22/24.
//

import Foundation

struct StoryDetail: Codable, Identifiable {
    let id: Int
    let title: String
    let thumbnail: Thumbnail
    let author: Author
    let brandName: String?
    let postTypeMeta: PostTypeMeta
    let commentCount: Int
    
    struct Thumbnail: Codable {
        let raw: String
    }
    
    struct Author: Codable {
        let id: Int
        let name: String
        let avatar: String?
        let twitterHandle: String?
    }
    
    struct PostTypeMeta: Codable {
        let standardPost: StandardPost?
        
        struct StandardPost: Codable {
            let content: String?
        }
    }
}
