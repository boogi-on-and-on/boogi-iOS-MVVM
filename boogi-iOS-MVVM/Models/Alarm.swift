//
//  Alarm.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/17.
//

import Foundation

struct Alarm: Codable {
    struct Content: Codable, Hashable {
        var id: Int
        var head: String
        var body: String?
        var createdAt: String
    }
    
    var alarms: [Content]
}
