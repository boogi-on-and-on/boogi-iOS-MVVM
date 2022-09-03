//
//  Search.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/27.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        VStack {
            SearchBar(
                search: viewModel.search,
                keyword: $viewModel.searchParameter.keyword
            )
            SearchTypeSelectBar(
                isCommunitySearch: $viewModel.isCommunitySearch,
                order: $viewModel.searchParameter.order,
                isPrivate: $viewModel.searchParameter.isPrivate
            )
            
            Divider()
                .foregroundColor(.black)
            
            
            if viewModel.isCommunitySearch {
                CommunityCategoryBar(category: $viewModel.communityCategory)
            }
            
            if viewModel.hasCommunitySearchResult {
                CommunitySearchResultList(result: $viewModel.communitySearchResult)
            }
            
            if viewModel.hasPostSearchResult {
                PostSearchResultList(result: $viewModel.postSearchResult)
            }
            
            Spacer()
        }
        .transition(.opacity)
        .animation(.default, value: viewModel.isCommunitySearch)
        .onChange(of: viewModel.isCommunitySearch) { _ in
            viewModel.hasCommunitySearchResult = false
            viewModel.hasPostSearchResult = false
        }
        .onAppear {
            viewModel.hasCommunitySearchResult = true
        }
        .onTapGesture {
            hideKeyBoard()
        }
    }
}

