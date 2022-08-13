//
//  CommunitiesService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/06.
//

import Foundation

protocol CommunitiesService {
    func requestCreate(form: Community.Create, _ success: inout Bool, _ fail: inout Bool) async
}

struct RealCommunityService: CommunitiesService {
    let webRepository: CommunitiesWebRepository
    
    init(webRepository: CommunitiesWebRepository) {
        self.webRepository = webRepository
    }
    
    func requestCreate(form: Community.Create, _ success: inout Bool, _ fail: inout Bool) async {
        let res = await webRepository.createCommunity(form: form)
        
        switch res {
        case .success(let data):
            print(data)
            success = true
            break
        case .failure(let err):
            print(err)
            fail = true
            break
        }
    }
}

struct StubCommunitiesService: CommunitiesService {
    func requestCreate(form: Community.Create, _ success: inout Bool, _ fail: inout Bool) async {
        
    }
}
