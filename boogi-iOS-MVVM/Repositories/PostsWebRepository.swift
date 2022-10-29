//
//  CommunityWebRepository.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/07/30.
//

import Foundation

protocol PostsWebRepository: WebRepository {
    func createPost(form: Post.Create) async -> Result<Int, Error>
    func getHotPosts() async -> Result<Post.HotPost, Error>
    func getUserPosts(userId: Int?) async -> Result<Post.UserPosts, Error>
    func getPostDetail(postId: Int) async -> Result<Post.Detail, Error>
}

struct RealPostsWebRepository: PostsWebRepository {
    func createPost(form: Post.Create) async -> Result<Int, Error> {
        return await call(endpoint: API.create(form))
    }
    
    func getHotPosts() async -> Result<Post.HotPost, Error> {
        return await call(endpoint: API.hot)
    }
    
    func getUserPosts(userId: Int?) async -> Result<Post.UserPosts, Error> {
        return await call(endpoint: API.userPosts(userId))
    }
    
    func getPostDetail(postId: Int) async -> Result<Post.Detail, Error> {
        return await call(endpoint: API.postDetail(postId))
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
        case hot
        case userPosts(Int?)
        case postDetail(Int)
    }
}

extension RealPostsWebRepository.API: APICall {
    var path: String {
        switch self {
        case .create:
            return "/"
        case .hot:
            return "/hot"
        case .userPosts:
            return "/users"
        case .postDetail(let postId):
            return "/\(postId)"
        }
    }
    
    var method: String {
        switch self {
        case .create:
            return "POST"
        case .hot, .userPosts, .postDetail:
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
        case .userPosts(let id):
            return [URLQueryItem(name: "userId", value: id?.description)]
        default:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .create(let form):
            return try JSONEncoder().encode(form)
        case .hot, .userPosts, .postDetail:
            return nil
        }
    }
    
    
}
