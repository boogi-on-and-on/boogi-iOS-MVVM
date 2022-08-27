//
//  AlarmsService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/27.
//

import Foundation

protocol AlarmsService {
    
}

struct RealAlarmsService: AlarmsService {
    let webRepository: AlarmsWebRepository
    
    func getAlarms() {
        
    }
}
