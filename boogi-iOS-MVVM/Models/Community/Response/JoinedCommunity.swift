//
//  JoinedCommunity.swift
//  boogi-iOS-MVVM
//
//  Created by Macbook on 2022/10/03.
//

import Foundation


extension Community {
    struct Joined: Codable {
        struct PostInfo: Codable, Hashable {
            var id: Int
            var createdAt: String
            var hashtags: [String]?
            var content: String
            var postMediaUrl: String?
            var likeCount: Int
            var commentCount: Int
        }
        struct CommunityInfo: Codable, Hashable {
            var name: String
            var id: Int
            var post: PostInfo?
        }
        
        var communities: [CommunityInfo]
    }
}
