//
//  UsersService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/20.
//

import Foundation

protocol UsersService {
    func getJoinedCommunities() async -> Community.Joined
}

struct RealUsersService: UsersService {
    let webRepository: UsersWebRepository
    
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
}
