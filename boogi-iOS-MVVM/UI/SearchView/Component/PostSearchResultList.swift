//
//  PostSearchResultList.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/03.
//

import Foundation
import SwiftUI

extension SearchView {
    struct PostSearchResultList: View {
        @ObservedObject private(set) var viewModel: ViewModel
        @Binding var result: Search.PostSearchResult
        
        struct Profile: View {
            let userProfile: Search.PostSearchResult.Post.User
            
            var body: some View {
                HStack {
                    AsyncImage(url: URL(string: userProfile.profileImageUrl ?? "")) { img in
                        img.resizable()
                    } placeholder: {
                        Image(systemName: "person.fill")
                    }
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                    
                    VStack {
                        Text(userProfile.name)
                        Text(userProfile.tagNum)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
            }
        }
        
        struct Hashtags: View {
            let hashtags: [String]?
            
            var body: some View {
                HStack {
                    ForEach(hashtags ?? [], id: \.self) { tag in
                        Text("#\(tag)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
            }
        }
        
        struct PostInfo: View {
            let info: Search.PostSearchResult.Post
            
            var body: some View {
                HStack {
                    Text(info.createdAt)
                    Image(systemName: "heart")
                        .foregroundColor(.pink)
                    Text(info.likeCount.description)
                    Image(systemName: "ellipsis.bubble")
                    Text(info.commentCount.description)
                    
                    Spacer()
                    
                    Text(info.communityName)
                        .lineLimit(1)
                }
            }
        }
        
        
        var body: some View {
            ScrollView {
                LazyVStack {
                    ForEach(result.posts, id: \.self) { post in
                        NavigationLink {
                            PostDetailView(viewModel: PostDetailView.ViewModel(container: viewModel.container), postId: post.id)
                        } label : {
                            VStack(alignment: .leading) {
                                Profile(userProfile: post.user)
                                
                                Text(post.content)
                                
                                Hashtags(hashtags: post.hashtags)
                                
                                PostInfo(info: post)
                            }
                        }
                        .padding()
                        .buttonStyle(PlainButtonStyle())
                        
                        Divider()
                    }
                    
                    /*
                    if (res?.pageInfo.hasNext) ?? true {
                        ProgressView()
                            .padding()
                            .task {
                                do {
                                    res = try await WebService.webService.getPostsSearch(
                                        searchParams: searchParams, nextPage: res?.pageInfo.nextPage ?? 0
                                    )
                                    posts.append(contentsOf: res?.posts ?? [])
                                } catch {
                                    res = PostSearchResult(posts: [], pageInfo: PostSearchResult.Page(nextPage: 1, totalCount: 0, hasNext: false))
                                }
                            }
                    }
                     */
                    
                    if result.posts.isEmpty {
                        Text("결과가 없습니다.")
                    }
                }
            }
        }
        
    }
    
}
