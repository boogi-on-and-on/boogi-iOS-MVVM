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
        @Published var selectedCommunity: Community.Joined.CommunityInfo?
        @Published var images: [UIImage] = []
        
        @Published var alertPresent = false
        @Published var confirmPresent = false
        
        var joinedCommunities = Community.Joined(communities: [])
        
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
        
        func getJoinedCommunities() async {
            let res = await container.services.usersService
                .getJoinedCommunities()
            
            joinedCommunities = res
        }
    }
}
