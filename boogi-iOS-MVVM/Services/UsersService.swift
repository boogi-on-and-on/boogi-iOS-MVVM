//
//  UsersService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/20.
//

import Foundation
import UIKit

protocol UsersService {
    func getToken(email: String) async -> Bool
    func getJoinedCommunities() async -> Community.Joined
}

struct RealUsersService: UsersService {
    let webRepository: UsersWebRepository
    
    func getToken(email: String) async -> Bool {
        let res = await webRepository.getToken(email: email)
        
        switch res {
        case .success(let token):
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(token, forKey: "xAuthToken")
            print(token)
            return true
        case .failure(let err):
            print(err)
            return false
        }
    }
    
    func getJoinedCommunities() async -> Community.Joined {
        let res = await webRepository.getJoinedCommunities()
        
        switch res {
        case .success(let data):
            print(data)
            return data
        case .failure(let err):
            print(err)
            return Community.Joined(communities: [])
        }
    }
}

struct StubUsersService: UsersService {
    func getJoinedCommunities() async -> Community.Joined {
        Community.Joined(communities: [])
    }
    
    func getToken(email: String) async -> Bool {
        false
    }
}
