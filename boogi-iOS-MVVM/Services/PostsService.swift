//
//  PostsService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/20.
//

import Foundation

protocol PostsService {
    func requestCreate(form: Post.Create) async -> Int
    func requestGetHotposts() async -> Post.HotPost
    func requestGetUserPosts(userId: Int?) async -> Post.UserPosts
    func getPostDetail(postId: Int) async -> Post.Detail
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
            return data
        case .failure(let err):
            print(err)
            return -1
        }
    }
    
    func requestGetHotposts() async -> Post.HotPost {
        let res = await webRepository.getHotPosts()
        
        switch res {
        case .success(let data):
            return data
        case .failure(let err):
            print(err)
            return Post.HotPost(hots: [])
        }
    }
    
    func requestGetUserPosts(userId: Int?) async -> Post.UserPosts {
        let res = await webRepository.getUserPosts(userId: userId)
        
        switch res {
        case .success(let data):
            return data
        case .failure(let err):
            print(err)
            return Post.UserPosts(posts: [], pageInfo: Post.UserPosts.PageInfo(nextPage: 0, hasNext: false))
        }
    }
    
    func getPostDetail(postId: Int) async -> Post.Detail {
        let res = await webRepository.getPostDetail(postId: postId)
        
        switch res {
        case .success(let data):
            return data
        case .failure(let err):
            print(err)
            return Post.defaultPostDetail
        }
    }
}

struct StubPostsService: PostsService {
    func requestCreate(form: Post.Create) async -> Int {
        -1
    }
    
    func requestGetHotposts() async -> Post.HotPost {
        Post.HotPost(hots: [])
    }
    
    func requestGetUserPosts(userId: Int?) async -> Post.UserPosts {
        Post.UserPosts(posts: [], pageInfo: Post.UserPosts.PageInfo(nextPage: 0, hasNext: false))
    }
    
    func getPostDetail(postId: Int) async -> Post.Detail {
        Post.defaultPostDetail
    }
}
