//
//  PostDetailViewModel.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/29.
//

import Foundation

extension PostDetailView {
    class ViewModel: ObservableObject {
        @Published var detail = Post.defaultPostDetail
        @Published var postComments = Post.defaultPostComments
        @Published var commentText = ""
        @Published var postCommentResult = -1
        
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
        
        func getPostDetail(postId: Int) async {
            let res = await container.services.postsService.getPostDetail(postId: postId)
            
            DispatchQueue.main.async {
                self.detail = res
            }
        }
        
        func getPostComments(postId: Int) async {
            let res = await container.services.postsService.getPostComments(postId: postId)
            
            DispatchQueue.main.async {
                self.postComments = res
            }
        }
        
        func postComment(form: Comment.CreateForm) async {
            let res = await container.services.commentsService.postComment(form: form)
            
            DispatchQueue.main.async {
                self.postCommentResult = res.id
            }
        }
        
        func likeComment(commentId: Int) async -> Comment.Like {
            await container.services.commentsService.likeComment(commentId: commentId)
        }
    }
}
