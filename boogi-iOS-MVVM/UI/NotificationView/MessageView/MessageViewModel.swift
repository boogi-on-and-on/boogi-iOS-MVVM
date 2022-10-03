//
//  MessageViewModel.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/01.
//

import Foundation

extension MessageView {
    class ViewModel: ObservableObject {
        @Published var messagesLists = Message.MessageList(messageRooms: [])
        
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
        
        func getMessagesLists() async {
            let res = await container.services.messagesService.getMessagesLists()
            DispatchQueue.main.async {
                self.messagesLists = res
            }
        }
    }
}
