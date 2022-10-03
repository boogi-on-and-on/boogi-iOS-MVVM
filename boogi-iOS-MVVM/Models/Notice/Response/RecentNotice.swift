//
//  NoticeList.swift
//  boogi-iOS-MVVM
//
//  Created by Macbook on 2022/10/03.
//

import Foundation


extension Notice {
    struct RecentNotice: Codable {
        struct Content: Codable, Identifiable  {
            var id: Int
            var title: String
            var createdAt: String
        }
        
        var notices: [Content]
    }
}
