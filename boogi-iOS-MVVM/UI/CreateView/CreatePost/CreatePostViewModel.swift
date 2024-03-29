//
//  CreatePostViewModel.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/20.
//

import Foundation
import SwiftUI

// MARK: - ViewModel

extension CreatePost {
    class ViewModel: ObservableObject {
        @Published var form = Post.Create()
        @Published var selectedCommunity = Community.Joined.CommunityInfo(name: "", id: -1)
        @Published var images: [UIImage] = []
        
        @Published var alertPresent = false
        @Published var confirmPresent = false
        @Published var isProgressing = false
        
        @Published var joinedCommunities = Community.Joined(communities: [])
        
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
        
        func getJoinedCommunities() async {
            let res = await container.services.usersService
                .getJoinedCommunities()
            
            DispatchQueue.main.async {
                self.joinedCommunities = res
            }
        }
        
        func requestCreate() async {
            DispatchQueue.main.async {
                self.isProgressing = true
                self.form.hashtags.removeAll { $0 == "" }
                self.form.communityId = self.selectedCommunity.id
            }
            
            if !images.isEmpty {
                form.postMediaIds = await container.services.imagesService.getPostMediaIds(images: images)
            }
            
            let _ = await container.services.postsService.requestCreate(form: form)
            
            DispatchQueue.main.sync {
                self.isProgressing = false
                self.confirmPresent = true
                
            }
        }
    }
}
