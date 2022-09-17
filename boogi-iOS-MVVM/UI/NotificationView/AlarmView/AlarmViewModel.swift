//
//  AlarmViewModel.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/17.
//

import Foundation

// MARK: - ViewModel
extension AlarmView {
    class ViewModel: ObservableObject {
        @Published var alarms = Alarm(alarms: [])
        
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
        
        func getAlarms() async {
            self.alarms = await container.services.alarmsService
                .getAlarms()
        }
    }
}
