//
//  CommunityWebRepository.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/07/30.
//

import Foundation

protocol CommunitiesWebRepository: WebRepository {
    func createCommunity(form: Community.Create) async -> Result<Int, Error>
    func getCommunityDetail(communityId: Int) async -> Result<Community.Detail, Error>
}

struct RealCommunitiesWebRepository: CommunitiesWebRepository {
    func createCommunity(form: Community.Create) async -> Result<Int, Error> {
        return await call(endpoint: API.create(form))
    }
    
    func getCommunityDetail(communityId: Int) async -> Result<Community.Detail, Error> {
        return await call(endpoint: API.communityDetail(communityId))
    }
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    var session: URLSession
    var baseURL: String
}

// MARK: - Endpoints

extension RealCommunitiesWebRepository {
    enum API {
        case create(Community.Create)
        case communityDetail(Int)
    }
}

extension RealCommunitiesWebRepository.API: APICall {
    var path: String {
        switch self {
        case .create:
            return "/"
        case .communityDetail(let id):
            return "/\(id)"
        }
    }
    
    var method: String {
        switch self {
        case .communityDetail:
            return "GET"
        case .create:
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
        return nil
    }
    
    func body() throws -> Data? {
        switch self {
        case .create(let form):
            return try JSONEncoder().encode(form)
        case .communityDetail:
            return nil
        }
    }
}
