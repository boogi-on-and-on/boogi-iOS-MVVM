//
//  UsersInteractor.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/24.
//

import Foundation

protocol UsersInteractor {
    func getJoinedCommunities() async -> Community.Joined
}

struct UsersInteractorImpl: UsersInteractor {
    let webRepository: UsersWebRepository
    let appState: AppState
    
    init(webRepository: UsersWebRepository, appState: AppState) {
        self.webRepository = webRepository
        self.appState = appState
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
