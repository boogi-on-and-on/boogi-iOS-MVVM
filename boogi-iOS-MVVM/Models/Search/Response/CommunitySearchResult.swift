//
//  CommunitySearchResult.swift
//  boogi-iOS-MVVM
//
//  Created by Macbook on 2022/10/03.
//

import Foundation


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
            var isPrivate: Bool
        }
        struct Page: Codable {
            var nextPage: Int
            var hasNext: Bool
        }
        
        var communities: [CommunitySearchResult.Community]
        var pageInfo: CommunitySearchResult.Page
        
        static func `default`() -> CommunitySearchResult {
            return CommunitySearchResult(communities: [], pageInfo: Page(nextPage: -1, hasNext: false))
        }
    }
}
