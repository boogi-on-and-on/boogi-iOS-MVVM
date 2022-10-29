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
    func getProfile(userId: Int?) async -> User.Profile
    func getJoinedCommunities() async -> Community.Joined
}

struct RealUsersService: UsersService {
    let webRepository: UsersWebRepository
    
    func getToken(email: String) async -> Bool {
        let res = await webRepository.getToken(email: email)
        
        switch res {
        case .success:
            return true
        case .failure(let err):
            print(err)
            return false
        }
    }
    
    func getProfile(userId: Int?) async -> User.Profile {
        let res = await webRepository.getProfile(userId: userId)
        
        switch res {
        case .success(let data):
            print(data)
            return data
        case .failure(let err):
            print(err)
            return User.Profile(
                me: false,
                user: User.Profile.Info(id: -1, profileImageUrl: nil, name: "", tagNum: "", introduce: "", department: "")
            )
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
    func getToken(email: String) async -> Bool {
        false
    }
    
    func getProfile(userId: Int?) async -> User.Profile {
        return User.defaultProfile
    }
    
    func getJoinedCommunities() async -> Community.Joined {
        Community.Joined(communities: [])
    }
}
