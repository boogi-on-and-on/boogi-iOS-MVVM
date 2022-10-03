//
//  Message.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/01.
//

import Foundation

struct Message {
    
}

extension Message {
    struct MessageList: Codable {
        struct MessageRoom: Codable, Hashable {
            struct RecentMessage: Codable, Hashable { // 가장 최근에 받은 메시지 정보 -> 무조건 1개만 옴
                var content: String
                var receivedAt: String
            }
            
            var id: Int                  // 상대방 userId
            var name: String             // 상대방 이름
            var tagNum: String           // 태그 번호
            var profileImageUrl: String? // 프로필 이미지 url
            var recentMessage: RecentMessage
        }
        
        var messageRooms: [MessageRoom]
    }
}

extension Message {
    struct MessageDetail: Codable {
        struct User: Codable {
            var id: Int
            var name: String
            var tagNum: String
            var profileImageUrl: String?
        }
        
        struct Message: Codable, Hashable {
            var id: Int
            var content: String
            var receivedAt: String
            var me: Bool // 보낸 사람이 나라면 true, 상대방이면 false
        }
        
        struct PageInfo: Codable {
            var nextPage: Int
            var totalCount: Int
            var hasNext: Bool
        }
            
        var user: User
        var messages: [Message]
        var pageInfo: PageInfo
    }

}
