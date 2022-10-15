//
//  UsersWebRepository.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/20.
//

import Foundation

protocol UsersWebRepository: WebRepository {
    func getToken(email: String) async -> Result<String?, Error>
    func getProfile(userId: Int?) async -> Result<User.Profile, Error>
    func getJoinedCommunities() async -> Result<Community.Joined, Error>
}

struct RealUsersWebRepository: UsersWebRepository {
    func getToken(email: String) async -> Result<String?, Error> {
        return await auth(endpoint: API.getToken(email))
    }
    
    func getProfile(userId: Int?) async -> Result<User.Profile, Error> {
        return await call(endpoint: API.getProfile(userId))
    }
    
    func getJoinedCommunities() async -> Result<Community.Joined, Error> {
        return await call(endpoint: API.getJoinedCommunities)
    }
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    var session: URLSession
    var baseURL: String
}


// MARK: - Endpoints

extension RealUsersWebRepository {
    enum API {
        case getToken(String)
        case getProfile(Int?)
        case tokenValidation
        case getJoinedCommunities
    }
}

extension RealUsersWebRepository.API: APICall {
    var path: String {
        switch self {
        case .getProfile:
            return "/"
        case .getToken(let email):
            return "/token/\(email)"
        case .tokenValidation:
            return "/token/validation"
        case .getJoinedCommunities:
            return "/communities/joined"
        }
    }
    
    var method: String {
        switch self {
        case .getJoinedCommunities, .getProfile:
            return "GET"
        case .getToken, .tokenValidation:
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
        case .getProfile(let userId):
            return [URLQueryItem(name: "userId", value: userId?.description)]
        default:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getToken, .getProfile, .getJoinedCommunities, .tokenValidation:
            return nil
        }
    }
}
