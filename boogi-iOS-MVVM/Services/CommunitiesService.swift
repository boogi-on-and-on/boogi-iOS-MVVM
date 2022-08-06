//
//  CommunitiesService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/06.
//

import Foundation
import Combine

protocol CommunitiesService {
    func requestCreate(form: Community.Create)
}

struct RealCommunityService: CommunitiesService {
    let webRepository: CommunitiesWebRepository
    
    init(webRepository: CommunitiesWebRepository) {
        self.webRepository = webRepository
    }
    
    func requestCreate(form: Community.Create) {
        webRepository.createCommunity(form: form)
            .sink { _ in
            } receiveValue: { _ in
            }
            .cancel()
    }
}

struct StubCommunitiesService: CommunitiesService {
    func requestCreate(form: Community.Create) {
        Just(-1)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
