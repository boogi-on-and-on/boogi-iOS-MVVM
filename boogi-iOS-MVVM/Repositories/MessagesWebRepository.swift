//
//  MessagesWebRepository.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/01.
//

import Foundation

protocol MessagesWebRepository: WebRepository {
    func getMessagesLists() async -> Result<Message.MessageList, Error>
    func getMessageDetail(oppnentId: Int) async -> Result<Message.MessageDetail, Error>
    func postMessage(oppnentId: Int, content: String) async -> Result<Int, Error>
}

struct RealMessagesWebRepository: MessagesWebRepository {
    func getMessagesLists() async -> Result<Message.MessageList, Error> {
        return await call(endpoint: API.getMessagesLists)
    }
    
    func getMessageDetail(oppnentId: Int) async -> Result<Message.MessageDetail, Error> {
        return await call(endpoint: API.getMessageDetail(oppnentId))
    }
    
    func postMessage(oppnentId: Int, content: String) async -> Result<Int, Error> {
        return await call(endpoint: API.postMessage(oppnentId, content))
    }
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    var session: URLSession
    var baseURL: String
}

// MARK: - Endpoints
extension RealMessagesWebRepository {
    enum API {
        case getMessagesLists
        case getMessageDetail(Int)
        case postMessage(Int, String)
    }
}

extension RealMessagesWebRepository.API: APICall {
    var path: String {
        switch self {
        case .getMessagesLists, .postMessage:
            return "/"
        case .getMessageDetail(let id):
            return "/\(id)"
        }
    }
    
    
    var method: String {
        switch self {
        case .getMessagesLists, .getMessageDetail:
            return "GET"
        case .postMessage:
            return "POST"
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "X-Auth-Token": "f835a769-1f74-48e0-9d30-c4709c1128ac"
        ]
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
    
    func body() throws -> Data? {
        return nil
    }
}
