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
                
                
                Text(Date.getDate(datetime: viewModel.detail.createdAt).timeAgoDisplay())
            }
            
            Text(viewModel.detail.content)
            
            HStack {
                Image(systemName: (viewModel.detail.likeId != nil) ? "heart.fill" : "heart")
                Text(viewModel.detail.likeCount.description)
                Image(systemName: "ellipsis.bubble")
                Text(viewModel.detail.commentCount.description)
            }
        }
        .task {
            await viewModel.getPostDetail(postId: postId)
        }
    }
}
