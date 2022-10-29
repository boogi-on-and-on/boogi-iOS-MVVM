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
    }
}
