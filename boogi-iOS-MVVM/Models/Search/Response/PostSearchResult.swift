//
//  PostSearchResult.swift
//  boogi-iOS-MVVM
//
//  Created by Macbook on 2022/10/03.
//

import Foundation


extension Search {
    struct PostSearchResult: Codable {
        struct Post: Codable, Hashable {
            struct User: Codable, Hashable {
                var id: Int
                var name: String
                var tagNum: String
                var profileImageUrl: String?
            }
            
            var id: Int
            var user: PostSearchResult.Post.User
            var communityId: Int
            var communityName: String
            var createdAt: String
            var hashtags: [String]?
            var commentCount: Int
            var likeCount: Int
            var content: String
        }
        struct Page: Codable {
            var nextPage: Int
            var hasNext: Bool
        }
        
        var posts: [PostSearchResult.Post]
        var pageInfo: PostSearchResult.Page
        
        static func `default`() -> PostSearchResult {
            return PostSearchResult(posts: [], pageInfo: Page(nextPage: -1, hasNext: false))
        }
    }
}
