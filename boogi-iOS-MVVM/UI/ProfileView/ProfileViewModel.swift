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
        @Published var profile = User.Profile(
            me: false, user: User.Profile.Info(id: -1, profileImageUrl: nil, name: "", tagNum: "", introduce: "", department: "")
        )
        @Published var userPosts = Post.UserPosts(posts: [], pageInfo: Post.UserPosts.PageInfo(nextPage: 0, hasNext: false))
        var selected = "게시글 목록"
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
        
        func getUserPosts() async {
            let res = await container.services.postsService.requestGetUserPosts()
            
            DispatchQueue.main.async {
                self.userPosts = res
            }
        }
    }
}
