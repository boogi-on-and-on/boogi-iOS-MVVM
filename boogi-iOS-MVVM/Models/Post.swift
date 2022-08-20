//
//  Post.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/20.
//

import Foundation

struct Post {
    
}

extension Post {
    struct Create: Codable {
        var communityId: Int = -1
        var content: String = ""
        var hashtags: [String] = []
        var postMediaIds: [String] = []
        var mentionedUserIds: [Int] = []
    }
}
