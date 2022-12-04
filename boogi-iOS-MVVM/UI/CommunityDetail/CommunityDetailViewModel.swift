//
//  CommunityDetailViewModel.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/29.
//

import Foundation

extension CommunityDetailView {
    class ViewModel: ObservableObject {
        @Published var communityDetail = Community.defaultCommunityDetail
        
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
        
        func getCommunityDetail(communityId: Int) async {
            let res = await container.services.communitiesService.getCommunityDetail(communityId: communityId)
            
            DispatchQueue.main.async {
                self.communityDetail = res
            }
        }
    }
}
