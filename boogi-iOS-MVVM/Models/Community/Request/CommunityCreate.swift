//
//  CommunityCreate.swift
//  boogi-iOS-MVVM
//
//  Created by Macbook on 2022/10/03.
//

import Foundation


extension Community {
    struct Create: Codable {
        var name: String = ""
        var description: String = ""
        var category: Category = .academic
        var hashtags: [String] = []
        var isPrivate: Bool = false
        var autoApproval: Bool = false
    }
}
