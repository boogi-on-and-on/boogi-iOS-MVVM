//
//  CommunityWebRepository.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/07/30.
//

import Foundation

protocol CommunitiesWebRepository: WebRepository {
    func createCommunity(form: Community.Create) async -> Result<Int, Error>
}

struct RealCommunitiesWebRepository: CommunitiesWebRepository {
    func createCommunity(form: Community.Create) async -> Result<Int, Error> {
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

extension RealCommunitiesWebRepository {
    enum API {
        case create(Community.Create)
    }
}

extension RealCommunitiesWebRepository.API: APICall {
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
            "Accept": "application/json",
            // TODO: need user authentication token
            "": "X-Auth-Token"
        ]
    }
    
    func body() throws -> Data? {
        switch self {
        case .create(let form):
            return try JSONEncoder().encode(form)
        }
    }
    
    
}
