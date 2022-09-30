//
//  HomeViewModel.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/30.
//

import Foundation

extension HomeView {
    class ViewModel: ObservableObject {
        @Published var notice = Notice(notices: [])
        
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
        
        func getRecentNotices() async {
            let res = await container.services.noticesService.getNotices(communityId: nil)
            
            DispatchQueue.main.async {
                self.notice = res
            }
        }
    }
}
