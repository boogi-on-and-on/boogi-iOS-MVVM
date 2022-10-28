//
//  CommentsService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/22.
//

import Foundation

protocol CommentsService {
    func getUserComments(userId: Int?) async -> Comment.UserComments
}

struct RealCommentsService: CommentsService {
    let webRepository: CommentsWebRepository
    
    func getUserComments(userId: Int?) async -> Comment.UserComments {
        let res = await webRepository.getUsersComments(userId: userId)
        
        switch res {
        case .success(let data):
            print(data)
            return data
        case .failure(let err):
            print(err)
            return Comment.UserComments(comments: [], pageInfo: Comment.UserComments.PageInfo(nextPage: 0, hasNext: false))
        }
    }
}

struct StubCommentsService: CommentsService {
    func getUserComments(userId: Int?) async -> Comment.UserComments {
        return Comment.UserComments(comments: [], pageInfo: Comment.UserComments.PageInfo(nextPage: 0, hasNext: false))
    }
}
