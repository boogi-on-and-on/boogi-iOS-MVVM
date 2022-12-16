//
//  PostDetailView.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/29.
//

import Foundation
import SwiftUI

struct PostDetailView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    let postId: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: viewModel.detail.user.profileImageUrl ?? "")) { img in
                    img.resizable()
                } placeholder: {
                    Image(systemName: "person.fill")
                }
                .clipShape(Circle())
                .frame(width: 32, height: 32)
                .padding()
                
                Spacer()
                
                Text(Date.getDateTime(datetime: viewModel.detail.createdAt))
            }
            
            Text(viewModel.detail.content)
            
            Divider()
            
            HStack {
                Image(systemName: (viewModel.detail.likeId != nil) ? "heart.fill" : "heart")
                Text(viewModel.detail.likeCount.description)
                Image(systemName: "ellipsis.bubble")
                Text(viewModel.detail.commentCount.description)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
            
            CommentsView(viewModel: viewModel)
        }
        // .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray))
        .task {
            await viewModel.getPostDetail(postId: postId)
        }
    }
}
