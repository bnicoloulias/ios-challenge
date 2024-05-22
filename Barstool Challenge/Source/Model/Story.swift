//
//  Story.swift
//  Barstool Challenge
//
//  Created by Bobby Nicoloulias on 5/22/24.
//

import Foundation

struct Story: Codable, Identifiable {
    let id: Int
    let title: String
    let thumbnail: Thumbnail
    let author: Author
    let brandName: String?
    
    struct Thumbnail: Codable {
        let raw: String
    }
    
    struct Author: Codable {
        let id: Int
        let name: String
        let avatar: String?
        let twitterHandle: String?
    }
}
