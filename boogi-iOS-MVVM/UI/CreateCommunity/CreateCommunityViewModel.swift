//
//  CreateCommunityViewModel.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/06.
//

import Foundation

// MARK: - ViewModel

extension CreateCommunity {
    class ViewModel: ObservableObject {
        @Published var form = Community.Create()
        
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
        
        func requestCreate() {
            container.services.communitiesService
                .requestCreate(form: form)
        }
    }
}
