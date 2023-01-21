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
        VStack(alignment: .leading) {
            ScrollView {
                ForEach(viewModel.postComments.comments, id: \.self) { comment in
                    VStack(alignment: .leading) {
                        HStack {
                            AsyncImage(url: URL(string: comment.user.profileImageUrl ?? "")) { img in
                                img.resizable()
                            } placeholder: {
                                Image(systemName: "person.fill")
                            }
                            .clipShape(Circle())
                            .frame(width: 32, height: 32)
                            .padding()
                            
                            VStack {
                                Text(comment.user.name)
                                Text(comment.user.tagNum)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        
                        Text(comment.content)
                            .padding([.top, .bottom])
                        
                        HStack {
                            Text(Date.getDate(datetime: comment.createdAt).timeAgoDisplay())
                            Text("답글쓰기")
                            Text("좋아요 \(comment.likeCount)개")
                            
                            Spacer()
                            
                            Button {
                                Task {
                                    let res = await viewModel.likeComment(commentId: comment.id)
                                }
                            } label: {
                                Image(systemName: (comment.likeId != nil) ? "heart.fill" : "heart")
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
            }
            .task {
                await viewModel.getPostComments(postId: postId)
            }
            
            CommentBar(keyword: $viewModel.commentText) {
                await viewModel.postComment(
                    form: Comment.CreateForm(
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
