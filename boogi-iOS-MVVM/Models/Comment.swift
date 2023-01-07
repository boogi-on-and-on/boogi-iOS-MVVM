//
//  Comments.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/22.
//

import Foundation

struct Comment {
    static let defaultUserComments = UserComments(comments: [], pageInfo: UserComments.PageInfo(nextPage: 0, hasNext: false))
}

extension Comment {
    struct UserComments: Codable {
        struct Comment: Codable, Hashable {
            let content: String
            var createdAt: String
            let postId: Int
        }
        struct PageInfo: Codable {
            let nextPage: Int
            let hasNext: Bool
        }
        
        let comments: [UserComments.Comment]
        let pageInfo: UserComments.PageInfo
    }
}

extension Comment {
    struct Create: Codable {
        let postId: Int // 게시글 Id
        let parentCommentId: Int? // 부모 댓글 Id (댓글 : null, 대댓글 : Id값)
        let content: String
        let mentionedUserIds: [Int]
    }
}
