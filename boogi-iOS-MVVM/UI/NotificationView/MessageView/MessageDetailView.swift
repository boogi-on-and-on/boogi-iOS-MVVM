//
//  MessageDetail.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/01.
//

import Foundation
import SwiftUI

struct MessageDetailView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    @State private var downloadAmount = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    let opponentId: Int
    @Namespace var bottom
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                ForEach(viewModel.detail.messages, id: \.self) { msg in
                    MessageContent(msg: msg)
                }
                .animation(.default, value: viewModel.detail.messages.count)
                .onAppear {
                    proxy.scrollTo(bottom)
                }
                
                HStack { }.id(bottom)
            }
            
            MessageTextBar(
                msg: $viewModel.msg,
                proxy: proxy,
                bottom: bottom,
                detail: $viewModel.detail,
                postMessage: viewModel.postMessage
            )
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    AsyncImage(url: URL(string: viewModel.detail.user.profileImageUrl ?? "")) { img in
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
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(viewModel.detail.user.name)
                            .foregroundColor(.white)
                        Text(viewModel.detail.user.tagNum)
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                }
            }
            
            /// TODO: 유저 차단
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink("") {
                    // ReportCreateView(createReport: CreateReport(id: detail.user.id, target: "USER"))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .task {
            await viewModel.getMessageDetail(oppnentId: opponentId)
        }
    }
}
