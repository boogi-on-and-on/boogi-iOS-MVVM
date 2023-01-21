//
//  CommentsWebRepository.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/22.
//

import Foundation

protocol CommentsWebRepository: WebRepository {
    func getUsersComments(userId: Int?) async -> Result<Comment.UserComments, Error>
    func postComments(form: Comment.CreateForm) async -> Result<Comment.CreateResult, Error>
    func likeComment(commentId: Int) async -> Result<Comment.Like, Error>
}

struct RealCommentsWebRepository: CommentsWebRepository {
    func getUsersComments(userId: Int?) async -> Result<Comment.UserComments, Error> {
        await call(endpoint: API.getUserComments(userId))
    }
    
    func postComments(form: Comment.CreateForm) async -> Result<Comment.CreateResult, Error> {
        await call(endpoint: API.postComment(form))
    }
    
    func likeComment(commentId: Int) async -> Result<Comment.Like, Error> {
        await call(endpoint: API.likeComment(commentId))
    }
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    var session: URLSession
    var baseURL: String
}

// MARK: - Endpoints
extension RealCommentsWebRepository {
    enum API {
        case getUserComments(Int?)
        case postComment(Comment.CreateForm)
        case likeComment(Int)
    }
}

extension RealCommentsWebRepository.API: APICall {
    var path: String {
        switch self {
        case .postComment:
            return "/"
        case .getUserComments:
            return "/users"
        case .likeComment(let id):
            return "/\(id)/likes"
        }
    }
    
    
    var method: String {
        switch self {
        case .getUserComments:
            return "GET"
        case .postComment, .likeComment:
            return "POST"
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "X-Auth-Token": UserDefaults.standard.string(forKey: "xAuthToken") ?? ""
        ]
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .getUserComments(let id):
            return [URLQueryItem(name: "userId", value: id?.description)]
        case .postComment(let form):
            return [
                URLQueryItem(name: "postId", value: form.postId.description),
                URLQueryItem(name: "parentCommentId", value: form.parentCommentId?.description),
                URLQueryItem(name: "content", value: form.content),
                // URLQueryItem(name: "postId", value: form.postId),
            ]
        case .likeComment:
            return nil
        }
    }
    
    func body() throws -> Data? {
        return nil
    }
}
