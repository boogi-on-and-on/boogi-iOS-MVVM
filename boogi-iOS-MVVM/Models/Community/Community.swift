//
//  Community.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/06.
//

import Foundation

struct Community {
    
}


// MARK: --enum
extension Community {
    enum Category: String, Equatable, Codable, CaseIterable {
        case all = "ALL", academic = "ACADEMIC", club = "CLUB", hobby = "HOBBY", other = "OTHER"
        
        func type() -> String {
            switch self {
            case .all:
                return "전체"
            case .academic:
                return "학사"
            case .club:
                return "동아리"
            case .hobby:
                return "취미"
            case .other:
                return "기타"
            }
        }
    }
}