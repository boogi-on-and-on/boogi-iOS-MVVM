//
//  CommunitiesService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/06.
//

import Foundation

protocol CommunitiesService {
    func createCommunity(form: Community.Create) async -> Int
    func getCommunityDetail(communityId: Int) async -> Community.Detail
}

struct RealCommunitiesService: CommunitiesService {
    let webRepository: CommunitiesWebRepository
    
    init(webRepository: CommunitiesWebRepository) {
        self.webRepository = webRepository
    }
    
    func createCommunity(form: Community.Create) async -> Int {
        let res = await webRepository.createCommunity(form: form)
        
        switch res {
        case .success(let data):
            return data
        case .failure(let err):
            print(err)
            return -1
        }
    }
    
    func getCommunityDetail(communityId: Int) async -> Community.Detail {
        let res = await webRepository.getCommunityDetail(communityId: communityId)
        
        switch res {
        case .success(let data):
            return data
        case .failure(let err):
            print(err)
            return Community.defaultCommunityDetail
        }
    }
}

struct StubCommunitiesService: CommunitiesService {
    func createCommunity(form: Community.Create) async -> Int {
        -1
    }
    
    func getCommunityDetail(communityId: Int) async -> Community.Detail {
        Community.defaultCommunityDetail
    }
}
