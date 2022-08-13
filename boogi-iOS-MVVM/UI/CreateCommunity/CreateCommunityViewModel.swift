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
        @Published var success: Bool = false
        @Published var fail: Bool = false
        
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
        
        func requestCreate() async {
            await container.services.communitiesService
                .requestCreate(form: form, &success, &fail)
        }
    }
}
