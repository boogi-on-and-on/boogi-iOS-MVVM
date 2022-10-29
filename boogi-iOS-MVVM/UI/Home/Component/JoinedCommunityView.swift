//
//  JoinedCommunityView.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/29.
//

import Foundation
import SwiftUI

struct JoinedCommunityView: View {
    @Binding var joinedCommunityLists: Community.Joined
    
    var body: some View {
        ForEach(joinedCommunityLists.communities, id: \.self) { community in
            VStack {
                Header(name: community.name)
                
                Article(
                    content: community.post?.content,
                    postMediaUrl: community.post?.postMediaUrl,
                    hashtags: community.post?.hashtags
                )
                
                // TODO: 컴파일러가 Footer를 싫어함..
                // Footer(createdAt: community.post?.createdAt, likeCount: community.post?.likeCount)
            }
        }
    }
}

extension JoinedCommunityView {
    struct Header: View {
        let name: String
        
        var body: some View {
            HStack {
                Text(name)
                
                NavigationLink {
                    Text("")
                } label: {
                    Text("커뮤니티 홈")
                        .padding()
                        .background(.gray)
                        .cornerRadius(15)
                }
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
                VStack {
                    Text(content ?? "")
                    
                    ForEach(hashtags ?? [], id: \.self) { hashtag in
                        Text("#\(hashtag)")
                    }
                }
                
                AsyncImage(url: URL(string: postMediaUrl ?? "")) { img in
                    img.resizable()
                } placeholder: {
                    Text("No")
                }
            }
        }
    }
    
    
}

extension JoinedCommunityView {
    struct Footer: View {
        let createdAt: String?
        let likeCount: String?
        
        var body: some View {
            HStack {
                Text(Date.getDateTime(datetime: createdAt ?? ""))
                Image(systemName: "heart")
                Text(likeCount ?? "0")
                Image(systemName: "ellipsis.bubble")
            }
        }
    }
}
