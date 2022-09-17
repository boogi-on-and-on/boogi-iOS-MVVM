//
//  NotificationViewModel.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/17.
//

import Foundation

// MARK: - ViewModel
extension NotificationView {
    class ViewModel: ObservableObject {
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
    }
}
