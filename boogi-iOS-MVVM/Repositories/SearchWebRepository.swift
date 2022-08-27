//
//  AlarmsWebRepository.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/27.
//

import Foundation

protocol SearchWebRepository: WebRepository {
    func searchCommunities() async -> Result<Search.CommunitySearchResult, Error>
    func searchPosts() async -> Result<Search.PostSearchResult, Error>
}

struct RealSearchWebRepository: SearchWebRepository {
    func searchCommunities() async -> Result<Search.CommunitySearchResult, Error> {
        return await call(endpoint: API.searchCommunities)
    }
    
    func searchPosts() async -> Result<Search.PostSearchResult, Error> {
        return await call(endpoint: API.searchPosts)
    }
    
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    var session: URLSession
    var baseURL: String
}


// MARK: - Endpoints

extension RealSearchWebRepository {
    enum API {
        case searchPosts
        case searchCommunities
    }
}

extension RealSearchWebRepository.API: APICall {
    var path: String {
        switch self {
        case .searchPosts:
            return "/posts/search"
        case .searchCommunities:
            return "/communities/search"
        }
    }
    
    var method: String {
        switch self {
        case .searchPosts, .searchCommunities:
            return "GET"
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            // TODO: need user authentication token
            "X-Auth-Token": "X-Auth-Token"
        ]
    }
    
    func body() throws -> Data? {
        switch self {
        default:
            return nil
        }
    }
}
