//
//  CommentsWebRepository.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/22.
//

import Foundation

protocol CommentsWebRepository: WebRepository {
    func getUsersComments(userId: Int?) async -> Result<Comment.UserComments, Error>
    
}

struct RealCommentsWebRepository: CommentsWebRepository {
    func getUsersComments(userId: Int?) async -> Result<Comment.UserComments, Error> {
        return await call(endpoint: API.getUserComments(userId))
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
    }
}

extension RealCommentsWebRepository.API: APICall {
    var path: String {
        switch self {
        case .getUserComments:
            return "/users"
        }
    }
    
    
    var method: String {
        switch self {
        case .getUserComments:
            return "GET"
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
        }
    }
    
    func body() throws -> Data? {
        return nil
    }
}
