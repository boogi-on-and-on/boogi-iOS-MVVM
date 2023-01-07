//
//  CommentsView.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/12/10.
//

import Foundation
import SwiftUI

struct CommentsView: View {
    @ObservedObject private(set) var viewModel: PostDetailView.ViewModel
    let postId: Int
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.postComments.comments, id: \.self) { comment in
                        // TODO:
                    }
                }
            }
            .task {
                await viewModel.getPostComments(postId: postId)
            }
            
            CommentBar(keyword: $viewModel.commentText) {
                await viewModel.postComment(
                    form: Comment.Create(
                        postId: viewModel.detail.id,
                        parentCommentId: nil,
                        content: viewModel.commentText,
                        mentionedUserIds: []
                    )
                )
            }
        }
    }
}
