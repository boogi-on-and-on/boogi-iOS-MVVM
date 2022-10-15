//
//  Post.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/20.
//

import Foundation

struct Post {
    
}

// request
extension Post {
    struct Create: Codable {
        var communityId: Int = -1
        var content: String = ""
        var hashtags: [String] = []
        var postMediaIds: [String] = []
        var mentionedUserIds: [Int] = []
    }
}


// response
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
