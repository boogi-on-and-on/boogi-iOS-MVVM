//
//  ProfileViewModel.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/15.
//

import Foundation
import SwiftUI

extension ProfileView {
    class ViewModel: ObservableObject {
        @Published var profile = User.defaultProfile
        @Published var userPosts = Post.defaultUserPosts
        @Published var userComments = Comment.defaultUserComments
        @Published var selected = "게시글 목록"
        let selection = ["게시글 목록", "댓글 목록"]
        
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
        
        func getProfile(userId: Int?) async {
            let res = await container.services.usersService.getProfile(userId: userId)
            
            DispatchQueue.main.async {
                self.profile = res
            }
        }
        
        func getUserPosts(userId: Int?) async {
            let res = await container.services.postsService.requestGetUserPosts(userId: userId)
            
            DispatchQueue.main.async {
                self.userPosts = res
            }
        }
        
        func getUserComments(userId: Int?) async {
            let res = await container.services.commentsService.getUserComments(userId: userId)
            
            DispatchQueue.main.async {
                self.userComments = res
            }
        }
    }
}
