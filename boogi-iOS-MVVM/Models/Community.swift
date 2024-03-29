//
//  Community.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/06.
//

import Foundation

struct Community {
    static let defaultJoinedCommunities = Community.Joined(communities: [])
    static let defaultCommunityDetail = Community.Detail(sessionMemberType: nil, community: Detail.CommunityInfo(isPrivated: false, category: .academic, name: "", introduce: "", hashtags: nil, memberCount: "0", createdAt: ""), notices: [], posts: [])
}

extension Community {
    struct Create: Codable {
        var name: String = ""
        var description: String = ""
        var category: Category = .academic
        var hashtags: [String] = []
        var isPrivate: Bool = false
        var autoApproval: Bool = false
    }
    
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

extension Community {
    struct Detail: Codable {
        struct CommunityInfo: Codable {
            let isPrivated: Bool
            let category: Community.Category
            let name: String
            let introduce: String
            let hashtags: [String]?
            let memberCount: String
            let createdAt: String
        }
        
        struct Notice: Codable, Hashable {
            let id: Int
            let title: String
            var createdAt: String
        }
        
        struct Post: Codable, Hashable {
            let id: Int
            let content: String
            var createdAt: String
        }
        
        let sessionMemberType: String?
        let community: Community.Detail.CommunityInfo
        let notices: [Detail.Notice]
        let posts: [Detail.Post]
    }
}

// MARK: --enum
extension Community {
    enum Category: String, Equatable, Codable, CaseIterable {
        case all = "ALL", academic = "ACADEMIC", club = "CLUB", hobby = "HOBBY", other = "OTHER"
        
        func type() -> String {
            switch self {
            case .all:
                return "전체"
            case .academic:
                return "학사"
            case .club:
                return "동아리"
            case .hobby:
                return "취미"
            case .other:
                return "기타"
            }
        }
    }
}
