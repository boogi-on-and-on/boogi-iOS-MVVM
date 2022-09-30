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
        VStack {
            NavigationView {
                AppNotices(notice: $viewModel.notice)
                    .task {
                        await viewModel.getRecentNotices()
                    }
                
                // HotPosts
                
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
