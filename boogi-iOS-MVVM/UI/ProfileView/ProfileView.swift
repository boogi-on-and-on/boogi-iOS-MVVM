//
//  ProfileView.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/15.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.profile.user.department)
                AsyncImage(url: URL(string: viewModel.profile.user.profileImageUrl ?? "")) { img in
                    img.resizable()
                } placeholder: {
                    Image(systemName: "person.fill")
                }
                .clipShape(Circle())
                .frame(width: 64, height: 64)
                .padding()
                
                Text(viewModel.profile.user.name)
                Text(viewModel.profile.user.tagNum)
                Text(viewModel.profile.user.introduce)
                
                Picker("", selection: $viewModel.selected) {
                    ForEach(viewModel.selection, id: \.self) {
                        Text($0)
                    }
                }
                
                if viewModel.selected == "게시글 목록" {
                    UserPosts(profile: viewModel.profile, userPosts: viewModel.userPosts)
                        .task {
                            await viewModel.getUserPosts()
                        }
                } else {
                    
                }
            }
            .pickerStyle(.segmented)
            .task {
                await viewModel.getProfile(userId: nil)
                await viewModel.getUserPosts()
            }
        }
    }
}
