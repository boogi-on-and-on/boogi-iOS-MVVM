//
//  SearchViewModel.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/27.
//

import Foundation

extension SearchView {
    class ViewModel: ObservableObject {
        @Published var keyword = ""
        @Published var isCommunitySearch = true
        @Published var communityCategory = Community.Category.all
        @Published var searchParameter = Search.Parameter()
        @Published var hasCommunitySearchResult = false
        @Published var hasPostSearchResult = false
        
        @Published var communitySearchResult = Search.CommunitySearchResult.default()
        @Published var postSearchResult = Search.PostSearchResult.default()
        
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
        
        func search() async {
            DispatchQueue.main.async {
                self.communitySearchResult = Search.CommunitySearchResult.default()
                self.postSearchResult = Search.PostSearchResult.default()
            }
            
            if isCommunitySearch {
                await getCommunitiesSearch()
            } else {
                await getPostsSearch()
            }
        }
        
        func getCommunitiesSearch() async {
            let res = await container.services.searchService
                .getCommunitiesSearchList(parameter: searchParameter)
            
            DispatchQueue.main.async {
                if res.communities.isEmpty {
                    self.hasCommunitySearchResult = false
                    return
                }
                
                self.hasCommunitySearchResult = true
                self.communitySearchResult = res
            }
        }
        
        func getPostsSearch() async {
            let res = await container.services.searchService
                .getPostsSearchList(parameter: searchParameter)
            
            DispatchQueue.main.async {
                if res.posts.isEmpty {
                    self.hasPostSearchResult = false
                    return
                }
                
                self.hasPostSearchResult = true
                self.postSearchResult = res
            }
        }
    }
}
