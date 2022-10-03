//
//  MessageTextBar.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/01.
//

import Foundation
import SwiftUI

struct MessageTextBar: View {
    @Binding var msg: String
    let proxy: ScrollViewProxy
    let bottom: Namespace.ID
    @Binding var detail: Message.MessageDetail
    
    let postMessage: (Int, String) async -> ()
    
    var body: some View {
        ZStack {
            TextField("Message", text: $msg, onCommit: {
                Task {
                    if msg == "" { return }
                    await postMessage(detail.user.id, msg)
                    detail.messages.append(
                        Message.MessageDetail.Message(id: 0, content: msg, receivedAt: getCurrent(), me: true)
                    )
                    msg = ""
                    proxy.scrollTo(bottom)
                }
            })
            .padding()
            .background(.gray.opacity(0.1))
            
            HStack {
                Spacer()
                
                Button {
                    Task {
                        if (msg == "") { return }
                        await postMessage(detail.user.id, msg)
                        detail.messages.append(
                            Message.MessageDetail.Message(id: 0, content: msg, receivedAt: getCurrent(), me: true)
                        )
                        msg = ""
                        proxy.scrollTo(bottom)
                    }
                } label: {
                    Image(systemName: "paperplane.fill")
                        .padding(.trailing, 20)
                }
            }
        }
    }
    
    func getCurrent() -> String {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date) % 100
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        return "\(year).\(month).\(day) \(hour):\(minutes)"
    }
}
