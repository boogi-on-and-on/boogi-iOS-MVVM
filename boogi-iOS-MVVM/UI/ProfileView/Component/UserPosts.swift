//
//  UserPosts.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/15.
//

import Foundation
import SwiftUI

struct UserPosts: View {
    let profile: User.Profile
    let userPosts: Post.UserPosts
    
    var body: some View {
        ScrollView {
            if userPosts.posts.isEmpty {
                Spacer()
                Text("게시물이 존재하지 않습니다.")
                Spacer()
            } else {
                
                ForEach(userPosts.posts, id: \.self) { post in
                    VStack(alignment: .leading) {
                        HStack {
                            AsyncImage(url: URL(string: profile.user.profileImageUrl ?? "")) { img in
                                img.resizable()
                            } placeholder: {
                                Image(systemName: "person.fill")
                            }
                            .clipShape(Circle())
                            .frame(width: 32, height: 32)
                            .padding()
                            
                            VStack {
                                Text(profile.user.name)
                                Text(profile.user.tagNum)
                                    .foregroundColor(.gray)
                                    .font(.callout)
                            }
                            
                            Spacer()
                            
                            Text(Date.getDate(datetime: post.createdAt).timeAgoDisplay())
                        }
                        
                        Text(post.content)
                            .padding()
                        
                        HStack {
                            HStack {
                                ForEach(post.hashtags ?? [], id: \.self) {
                                    Text("#\($0)")
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Spacer()
                            
                            NavigationLink(post.community.name) {
                            }
                        }
                        .padding()
                        
                        Divider()
                    }
                    .padding()
                }
            }
        }
    }
}
