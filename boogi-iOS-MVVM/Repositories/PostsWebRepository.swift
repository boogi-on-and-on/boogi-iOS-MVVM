//
//  CommunityWebRepository.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/07/30.
//

import Foundation

protocol PostsWebRepository: WebRepository {
    func createPost(form: Post.Create) async -> Result<Int, Error>
}

struct RealPostsWebRepository: PostsWebRepository {
    func createPost(form: Post.Create) async -> Result<Int, Error> {
        return await call(endpoint: API.create(form))
    }
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    var session: URLSession
    var baseURL: String
}

// MARK: - Endpoints

extension RealPostsWebRepository {
    enum API {
        case create(Post.Create)
    }
}

extension RealPostsWebRepository.API: APICall {
    var path: String {
        switch self {
        case .create:
            return "/"
        }
    }
    
    var method: String {
        switch self {
        case .create:
            return "POST"
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            // TODO: need user authentication token
            "X-Auth-Token": "f835a769-1f74-48e0-9d30-c4709c1128ac"
        ]
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
    
    func body() throws -> Data? {
        switch self {
        case .create(let form):
            return try JSONEncoder().encode(form)
        }
    }
    
    
}
