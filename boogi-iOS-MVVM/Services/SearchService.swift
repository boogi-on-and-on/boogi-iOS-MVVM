//
//  SearchService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/27.
//

import Foundation

protocol SearchService {
    func getCommunitiesSearchList(parameter: Search.Parameter) async -> Search.CommunitySearchResult
    func getPostsSearchList(parameter: Search.Parameter) async -> Search.PostSearchResult
}

struct RealSearchService: SearchService {
    let webRepository: SearchWebRepository
    
    func getCommunitiesSearchList(parameter: Search.Parameter) async -> Search.CommunitySearchResult {
        let res = await webRepository.searchCommunities(parameter: parameter)
        
        switch res {
        case .success(var data):
            print(data)
            data.communities.enumerated().forEach { (index, item) in
                data.communities[index].createdAt =
                    DIContainer.Services.getDateTime(datetime: item.createdAt)
                        .components(separatedBy: " ")[0]
            }
            return data
        case .failure(let err):
            print(err)
            return Search.CommunitySearchResult.default()
        }
    }
    
    func getPostsSearchList(parameter: Search.Parameter) async -> Search.PostSearchResult {
        let res = await webRepository.searchPosts(parameter: parameter)
        
        switch res {
        case .success(var data):
            print(data)
            data.posts.enumerated().forEach { (index, item) in
                data.posts[index].createdAt =
                    DIContainer.Services.getDateTime(datetime: item.createdAt)
                        .components(separatedBy: " ")[0]
            }
            return data
        case .failure(let err):
            print(err)
            return Search.PostSearchResult.default()
        }
    }
}

struct StubSearchService: SearchService {
    func getCommunitiesSearchList(parameter: Search.Parameter) async -> Search.CommunitySearchResult {
        Search.CommunitySearchResult(communities: [], pageInfo: Search.CommunitySearchResult.Page(nextPage: 0, totalCount: 0, hasNext: false))
    }
    
    func getPostsSearchList(parameter: Search.Parameter) async -> Search.PostSearchResult {
        Search.PostSearchResult(posts: [], pageInfo: Search.PostSearchResult.Page(nextPage: 0, totalCount: 0, hasNext: false))
    }
}
