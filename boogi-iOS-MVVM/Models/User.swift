//
//  Users.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/15.
//

import Foundation

struct User {
    
}

extension User {
    struct TokenValidation: Codable {
        let isValid: Bool
    }
}

extension User {
    struct Profile: Codable {
        struct Info: Codable {
            let id: Int
            let profileImageUrl: String?
            let name: String
            let tagNum: String
            let introduce: String
            let department: String
        }
        
        let me: Bool
        let user: Info
    }
}
