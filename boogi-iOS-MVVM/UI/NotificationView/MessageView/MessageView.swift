//
//  MessageView.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/17.
//

import Foundation
import SwiftUI

struct MessageView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    @State var downloadAmount = 0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.messagesLists.messageRooms, id: \.self) { msgRoom in
                NavigationLink {
                    MessageDetailView(
                        viewModel: MessageDetailView.ViewModel(container: viewModel.container),
                        opponentId: msgRoom.id
                    )
                } label: {
                    HStack {
                        AsyncImage(url: URL(string: msgRoom.profileImageUrl ?? "")) { img in
                            img.resizable()
                        } placeholder: {
                            if downloadAmount < 100 {
                                ProgressView()
                                    .onReceive(timer) { _ in
                                        if downloadAmount < 100 {
                                            downloadAmount += 5
                                        } else {
                                            timer.upstream.connect().cancel()
                                        }
                                    }
                            } else {
                                Image(systemName: "person.fill")
                            }
                        }
                        .clipShape(Circle())
                        .frame(width: 50, height: 50)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text(msgRoom.name)
                                Text(msgRoom.tagNum)
                                    .font(.caption)
                            }
                            Text(msgRoom.recentMessage.content)
                                .lineLimit(1)
                        }
                        
                        Spacer()
                        
                        Text(msgRoom.recentMessage.receivedAt)
                    }
                    .padding()
                }
                .buttonStyle(PlainButtonStyle())
                
                Divider()
            }
            //            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            //                Button {
            //                } label: {
            //                    Text("삭제")
            //                }
            //                .tint(.red)
            //            }
        }
        .task {
            await viewModel.getMessagesLists()
        }
    }
}


