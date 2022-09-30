//
//  Notice.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/30.
//

import Foundation

struct Notice: Codable {
    struct Content: Codable, Identifiable  {
        var id: Int
        var title: String
        var createdAt: String
    }
    
    var notices: [Content]
}
