//
//  Search.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/27.
//

import Foundation

struct Search {
    
}

extension Search {
    struct CommunitySearchResult: Codable {
        struct Community: Codable, Hashable {
            var id: Int
            var name: String
            var description: String
            var createdAt: String
            var hashtags: [String]?
            var memberCount: Int
            var category: String
            var `private`: Bool
        }
        struct Page: Codable {
            var nextPage: Int
            var totalCount: Int
            var hasNext: Bool
        }
        
        var communities: [CommunitySearchResult.Community]
        var pageInfo: CommunitySearchResult.Page
    }
    
}

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
            var totalCount: Int
            var hasNext: Bool
        }
        
        var posts: [PostSearchResult.Post]
        var pageInfo: PostSearchResult.Page
    }
}

extension Search {
    struct SearchParameter {
        enum isPrivate {
            case all
            case `private`
            case `public`
            
            func type() -> String {
                switch self {
                case .all: return "전체"
                case .private: return "비공개"
                case .public: return "공개"
                }
            }
        }
        
        var isPrivate: isPrivate = .all
//        var order: Ordering = .newer
//        var category: CommunityCategory = .all
        var keyword: String = ""
    }
}
