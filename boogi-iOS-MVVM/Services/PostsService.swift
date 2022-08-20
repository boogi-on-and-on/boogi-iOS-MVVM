//
//  PostsService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/20.
//

import Foundation

protocol PostsService {
    func requestCreate(form: Post.Create) async -> Int
}

struct RealPostsService: PostsService {
    let webRepository: PostsWebRepository
    
    init(webRepository: PostsWebRepository) {
        self.webRepository = webRepository
    }
    
    func requestCreate(form: Post.Create) async -> Int {
        let res = await webRepository.createPost(form: form)
        
        switch res {
        case .success(let data):
            print(data)
            return data
        case .failure(let err):
            print(err)
            return -1
        }
    }
}

struct StubPostsService: PostsService {
    func requestCreate(form: Post.Create) async -> Int {
        -1
    }
}
