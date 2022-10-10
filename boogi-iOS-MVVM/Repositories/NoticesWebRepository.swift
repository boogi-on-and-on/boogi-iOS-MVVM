//
//  NoticesWebRepository.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/30.
//

import Foundation

protocol NoticesWebRepository: WebRepository {
    func getRecentNotices(communityId: Int?) async -> Result<Notice, Error>
}

struct RealNoticesWebRepository: NoticesWebRepository {
    func getRecentNotices(communityId: Int?) async -> Result<Notice, Error> {
        return await call(endpoint: API.getRecentNotices(communityId))
    }
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    var session: URLSession
    var baseURL: String
}

// MARK: - Endpoints
extension RealNoticesWebRepository {
    enum API {
        case getRecentNotices(Int?)
    }
}

extension RealNoticesWebRepository.API: APICall {
    var path: String {
        switch self {
        case .getRecentNotices:
            return "/"
        }
    }
    
    
    var method: String {
        switch self {
        case .getRecentNotices:
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
        return nil
    }
    
    func body() throws -> Data? {
        return nil
    }
}
