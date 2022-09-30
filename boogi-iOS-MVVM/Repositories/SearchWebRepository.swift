//
//  AlarmsWebRepository.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/27.
//

import Foundation

protocol SearchWebRepository: WebRepository {
    func searchCommunities(parameter: Search.Parameter) async -> Result<Search.CommunitySearchResult, Error>
    func searchPosts(parameter: Search.Parameter) async -> Result<Search.PostSearchResult, Error>
}

struct RealSearchWebRepository: SearchWebRepository {
    func searchCommunities(parameter: Search.Parameter) async -> Result<Search.CommunitySearchResult, Error> {
        return await call(endpoint: API.searchCommunities(parameter))
    }
    
    func searchPosts(parameter: Search.Parameter) async -> Result<Search.PostSearchResult, Error> {
        return await call(endpoint: API.searchPosts(parameter))
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
        case searchPosts(Search.Parameter)
        case searchCommunities(Search.Parameter)
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
            "X-Auth-Token": "f835a769-1f74-48e0-9d30-c4709c1128ac"
        ]
    }
    
    var parameters: [URLQueryItem]? {
        var queryItems: [URLQueryItem] = []
        switch self {
        case let .searchPosts(p), let .searchCommunities(p):
            queryItems = [
                URLQueryItem(name: "order", value: p.order.rawValue),
                URLQueryItem(name: "keyword", value: p.keyword),
                URLQueryItem(name: "size", value: "5"),
                URLQueryItem(name: "page", value: 0.description),
            ]
            break
        }
        
        if case let .searchCommunities(p) = self {
            if p.category != .all {
                queryItems.append(URLQueryItem(name: "category", value: p.category.rawValue))
            }
            if p.isPrivate != .all {
                queryItems.append(
                    URLQueryItem(name: "isPrivate", value: p.isPrivate == .private ? "true" : "false")
                )
            }
        }
        
        print("queryItems: \(queryItems)")
        
        return queryItems
    }
    
    func body() throws -> Data? {
        switch self {
        default:
            return nil
        }
    }
}
