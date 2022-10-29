//
//  HomeView.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/30.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    AppNotices(notice: $viewModel.notice)
                        .task {
                            await viewModel.getRecentNotices()
                        }
                    
                    // HotPosts
                    HotPostView(hotPosts: $viewModel.hotPosts)
                        .task {
                            await viewModel.getHotposts()
                        }
                    
                    // JoinedCommuities
                    JoinedCommunityView(joinedCommunityLists: $viewModel.joinedCommunities)
                        .task {
                            print("Why???")
                            await viewModel.getJoinedCommunities()
                        }
                }
            }
        }
    }
}

struct AppNotices: View {
    @Binding var notice: Notice
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("공지사항")
                .font(.title)
            Divider()
            ForEach(notice.notices) { notice in
                HStack {
                    Text(notice.title)
                    Spacer()
                    Text(notice.createdAt)
                }
                .padding([.leading, .trailing], 2)
                Divider()
            }
        }
        .padding()
    }
}
