//
//  HotPost.swift
//  boogi-iOS-MVVM
//
//  Created by Macbook on 2022/10/03.
//

import Foundation


extension Post {
    struct HotPost: Codable {
        struct Content: Codable, Identifiable {
            var postId: Int
            var communityId: Int
            var content: String
            var likeCount: Int
            var commentCount: Int
            var hashtags: [String]?
            
            var id: Int {
                postId
            }
        }
        
        var hots: [Content]
    }
}
