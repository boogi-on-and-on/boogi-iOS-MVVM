//
//  AlarmInfo.swift
//  boogi-iOS-MVVM
//
//  Created by Macbook on 2022/10/03.
//

import Foundation


extension Alarm {
    struct AlarmInfo: Codable {
        struct Content: Codable, Hashable {
            var id: Int
            var head: String
            var body: String?
            var createdAt: String
        }
        
        var alarms: [Content]
    }
}
