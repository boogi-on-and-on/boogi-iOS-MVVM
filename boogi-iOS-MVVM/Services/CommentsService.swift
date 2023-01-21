//
//  CommentsService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/22.
//

import Foundation

protocol CommentsService {
    func getUserComments(userId: Int?) async -> Comment.UserComments
    func postComment(form: Comment.CreateForm) async -> Comment.CreateResult
    func likeComment(commentId: Int) async -> Comment.Like
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
    
    func postComment(form: Comment.CreateForm) async -> Comment.CreateResult {
        let res = await webRepository.postComments(form: form)
        
        switch res {
        case .success(let id):
            return id
        case .failure(let err):
            print(err)
            return Comment.CreateResult(id: -1)
        }
    }
    
    func likeComment(commentId: Int) async -> Comment.Like {
        let res = await webRepository.likeComment(commentId: commentId)
        
        switch res {
        case .success(let id):
            return id
        case .failure(let err):
            print(err)
            return Comment.Like(id: -1)
        }
    }
}

struct StubCommentsService: CommentsService {
    func getUserComments(userId: Int?) async -> Comment.UserComments {
        Comment.UserComments(comments: [], pageInfo: Comment.UserComments.PageInfo(nextPage: 0, hasNext: false))
    }
    
    func postComment(form: Comment.CreateForm) async -> Comment.CreateResult {
        Comment.CreateResult(id: -1)
    }
    
    func likeComment(commentId: Int) async -> Comment.Like {
        Comment.Like(id: -1)
    }
}
