//
//  AlarmsService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/27.
//

import Foundation

protocol AlarmsService {
    func getAlarms() async -> Alarm
}

struct RealAlarmsService: AlarmsService {
    let webRepository: AlarmsWebRepository
    
    func getAlarms() async -> Alarm {
        let res = await webRepository.getAlarms()
        
        switch res {
        case .success(var data):
            print(data)
            data.alarms.enumerated().forEach { (idx, item) in
                data.alarms[idx].createdAt =
                DIContainer.Services.getDateTime(datetime: item.createdAt)
                print(data.alarms[idx].createdAt)
            }
            return data
        case .failure(let err):
            print(err)
            return Alarm(alarms: [])
        }
    }
}

struct StubAlarmsService: AlarmsService {
    func getAlarms() async -> Alarm {
        return Alarm(alarms: [])
    }
}
