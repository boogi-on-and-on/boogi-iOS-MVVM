//
//  MessageDetailViewModel.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/03.
//

import Foundation

extension MessageDetailView {
    class ViewModel: ObservableObject {
        @Published var msg = ""
        @Published var detail = Message.MessageDetail(
            user: Message.MessageDetail.User(
                id: 0, name: "", tagNum: ""
            ),
            messages: [],
            pageInfo: Message.MessageDetail.PageInfo(
                nextPage: 0, totalCount: 0, hasNext: false
            )
        )
        
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
        
        func getMessageDetail(oppnentId: Int) async {
            let res = await container.services.messagesService.getMessageDetail(oppnentId: oppnentId)
            
            DispatchQueue.main.async {
                self.detail = res
            }
        }
        
        func postMessage(oppnentId: Int, content: String) async {
            let _ = await container.services.messagesService.postMessage(oppnentId: oppnentId, content: content)
        }
    }
}
