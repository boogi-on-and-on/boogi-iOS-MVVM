//
//  MessagesService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/01.
//

import Foundation

protocol MessagesService {
    func getMessagesLists() async -> Message.MessageList
    func getMessageDetail(oppnentId: Int) async -> Message.MessageDetail
    func postMessage(oppnentId: Int, content: String) async -> Int
}

struct RealMessagesService: MessagesService {
    let webRepository: MessagesWebRepository
    
    func getMessagesLists() async -> Message.MessageList {
        let res = await webRepository.getMessagesLists()
        
        switch res {
        case .success(var data):
            print(data)
            data.messageRooms.enumerated().forEach { (idx, item) in
                data.messageRooms[idx].recentMessage.receivedAt =
                DIContainer.Services.getDateTime(datetime: item.recentMessage.receivedAt)
                
                print(data.messageRooms[idx].recentMessage.receivedAt)
            }
            return data
        case .failure(let err):
            print(err)
            return Message.MessageList(messageRooms: [])
        }
    }
    
    func getMessageDetail(oppnentId: Int) async -> Message.MessageDetail {
        let res = await webRepository.getMessageDetail(oppnentId: oppnentId)
        
        switch res {
        case .success(let data):
            print(data)
            return data
        case .failure(let err):
            print(err)
            return Message.MessageDetail(
                user: Message.MessageDetail.User(id: 0, name: "", tagNum: ""),
                messages: [],
                pageInfo: Message.MessageDetail.PageInfo(nextPage: 0, totalCount: 0, hasNext: false))
        }
    }
    
    func postMessage(oppnentId: Int, content: String) async -> Int {
        let res = await webRepository.postMessage(oppnentId: oppnentId, content: content)
        
        switch res {
        case .success(let data):
            print(data)
            return data
        case .failure(let err):
            print(err)
            return -1
        }
    }
}

struct StubMessagesService: MessagesService {
    func getMessagesLists() async -> Message.MessageList {
        Message.MessageList(messageRooms: [])
    }
    
    func getMessageDetail(oppnentId: Int) async -> Message.MessageDetail {
        return Message.MessageDetail(
            user: Message.MessageDetail.User(id: 0, name: "", tagNum: ""),
            messages: [],
            pageInfo: Message.MessageDetail.PageInfo(nextPage: 0, totalCount: 0, hasNext: false))
    }
    
    func postMessage(oppnentId: Int, content: String) async -> Int {
        -1
    }
}
