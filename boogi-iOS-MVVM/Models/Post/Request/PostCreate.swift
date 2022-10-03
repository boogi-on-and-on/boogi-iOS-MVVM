//
//  PostCreate.swift
//  boogi-iOS-MVVM
//
//  Created by Macbook on 2022/10/03.
//

import Foundation


extension Post {
    struct Create: Codable {
        var communityId: Int = -1
        var content: String = ""
        var hashtags: [String] = []
        var postMediaIds: [String] = []
        var mentionedUserIds: [Int] = []
    }
}
