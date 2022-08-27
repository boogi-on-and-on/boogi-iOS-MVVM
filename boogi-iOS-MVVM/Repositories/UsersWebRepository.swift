//
//  UsersWebRepository.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/20.
//

import Foundation

protocol UsersWebRepository: WebRepository {
    func getJoinedCommunities() async -> Result<Community.Joined, Error>
}

struct RealUsersWebRepository: UsersWebRepository {
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
        case getJoinedCommunities
        // TODO: - todos
        /*
         case: getBlockedMessages
         case: postBlockedMessages
         case: postUnblockedMessages
         case: getNotificationsConfig
         */
    }
}

extension RealUsersWebRepository.API: APICall {
    var path: String {
        switch self {
        case .getJoinedCommunities:
            return "/communities/joined"
        }
    }
    
    var method: String {
        switch self {
        case .getJoinedCommunities:
            return "GET"
        }
    }
    
    var headers: [String : String]? {
        return [
            "Accept": "application/json",
            // TODO: need user authentication token
            "X-Auth-Token": "X-Auth-Token"
        ]
    }
    
    func body() throws -> Data? {
        switch self {
        case .getJoinedCommunities:
            return nil
        }
    }
}
