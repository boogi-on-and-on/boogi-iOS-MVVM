//
//  JoinedCommunityView.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/29.
//

import Foundation
import SwiftUI

struct JoinedCommunityView: View {
    let container: DIContainer
    @Binding var joinedCommunityLists: Community.Joined
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("내가 가입한 커뮤니티")
                .font(.title)
            
            ForEach(joinedCommunityLists.communities, id: \.self) { community in
                VStack {
                    Header(container: container, name: community.name, id: community.id)
                    
                    Article(
                        content: community.post?.content,
                        postMediaUrl: community.post?.postMediaUrl,
                        hashtags: community.post?.hashtags
                    )
                    
                    Footer(createdAt: community.post?.createdAt ?? "", likeCount: community.post?.likeCount ?? 0)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray))
            }
        }
        .padding()
    }
}

extension JoinedCommunityView {
    struct Header: View {
        let container: DIContainer
        let name: String
        let id: Int
        
        var body: some View {
            HStack {
                Text(name)
                    .font(.title)
                    
                Spacer()
                
                NavigationLink {
                    CommunityDetailView(communityId: id, viewModel: CommunityDetailView.ViewModel(container: container))
                } label: {
                    Text("커뮤니티 홈")
                        .padding(4)
                        .background(.gray)
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

extension JoinedCommunityView {
    struct Article: View {
        let content: String?
        let postMediaUrl: String?
        let hashtags: [String]?
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(content ?? "")
                        .padding(2)
                    
                    HStack {
                        ForEach(hashtags ?? [], id: \.self) { hashtag in
                            Text("#\(hashtag)")
                        }
                        .padding(2)
                    }
                }
                
                Spacer()
                
                AsyncImage(url: URL(string: postMediaUrl ?? "")) { img in
                    img.resizable()
                } placeholder: {
                    Image(systemName: "photo.artframe")
                }
            }
        }
    }
}

extension JoinedCommunityView {
    struct Footer: View {
        let createdAt: String
        let likeCount: Int
        
        var body: some View {
            HStack {
                Text(Date.getDateTime(datetime: createdAt))
                Image(systemName: "heart")
                Text(likeCount.description)
                Image(systemName: "ellipsis.bubble")
                
                Spacer()
            }
        }
    }
}
