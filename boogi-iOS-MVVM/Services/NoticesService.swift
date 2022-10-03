//
//  NoticesService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/30.
//

import Foundation

protocol NoticesService {
    func getNotices(communityId: Int?) async -> Notice.RecentNotice
}

struct RealNoticesService: NoticesService {
    let webRepository: NoticesWebRepository
    
    func getNotices(communityId: Int?) async -> Notice.RecentNotice {
        let res = await webRepository.getRecentNotices(communityId: communityId)
        
        switch res {
        case .success(var data):
            data.notices.enumerated().forEach { (index, item) in
                data.notices[index].createdAt =
                    DIContainer.Services.getDateTime(datetime: item.createdAt)
                        .components(separatedBy: " ")[0]
            }
            print(data)
            return data
        case .failure(let err):
            print(err)
            return Notice.RecentNotice(notices: [])
        }
    }
}

struct StubNoticesService: NoticesService {
    func getNotices(communityId: Int?) async -> Notice.RecentNotice {
        Notice.RecentNotice(notices: [])
    }
}
