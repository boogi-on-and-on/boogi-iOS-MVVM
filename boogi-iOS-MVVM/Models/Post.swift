//
//  Post.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/20.
//

import Foundation

struct Post {
    static let defaultUserPosts = UserPosts(posts: [], pageInfo: UserPosts.PageInfo(nextPage: 0, hasNext: false))
    static let defaultPostDetail = Post.Detail(id: 0, user: Detail.User(id: 0, name: "", tagNum: "", profileImageUrl: nil), member: Detail.Member(id: 0, memberType: ""), community: Detail.Community(id: 0, name: ""), likeId: 0, createdAt: "", content: "", likeCount: 0, commentCount: 0, me: false)
    static let defaultPostComments = Post.Comments(comments: [], pageInfo: Comments.PageInfo(nextPage: 0, hasNext: false))
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

extension Post {
    struct UserPosts: Codable {
        struct Community: Codable, Hashable {
            let id: Int
            let name: String
        }
        
        struct Post: Codable, Hashable {
            let content: String
            let community: Community
            var createdAt: String
            let hashtags: [String]?
            let id: Int
        }
        
        struct PageInfo: Codable {
            let nextPage: Int
            let hasNext: Bool
        }
        
        var posts: [UserPosts.Post]
        let pageInfo: PageInfo
    }
}

extension Post {
    struct Detail: Codable {
        struct User: Codable {
            let id: Int
            let name: String
            let tagNum: String
            let profileImageUrl: String?
        }
        
        struct Member: Codable {
            let id: Int
            let memberType: String
        }
        
        struct Community: Codable {
            let id: Int
            let name: String
        }
        
        let id: Int
        let user: Detail.User
        let member: Detail.Member
        let community: Detail.Community
        let likeId: Int?
        var createdAt: String
        let content: String
        var likeCount: Int
        var commentCount: Int
        let me: Bool
    }
}

extension Post {
    struct Comments: Codable {
        struct Content: Codable, Hashable {
            struct User: Codable, Hashable {
                let id: Int
                let name: String
                let tagNum: String
                let profileImageUrl: String?
            }
            
            struct Member: Codable, Hashable {
                let id: Int   // member테이블 id
                let memberType: String   // 멤버 타입(매니저, 부매니저, 일반)
            }
            
            let id: Int // 부모 id
            let user: Content.User
            let member: Content.Member
            let likeId: Int?  // 본인이 좋아요 했는지 안했는지 여부 (null이면 좋아요 X or 커뮤니티 가입 X)
            let createdAt: String  // 댓글 생성 시간
            let content: String  // 댓글 내용
            let likeCount: Int  // 좋아요 수
            let me: Bool   // 본인이 작성한 댓글이면 true
        }
        
        struct PageInfo: Codable {
            var nextPage: Int
            var hasNext: Bool
        }
        
        var comments: [Comments.Content]
        var child: [Comments.Content]?
        var pageInfo: PageInfo
    }
}
