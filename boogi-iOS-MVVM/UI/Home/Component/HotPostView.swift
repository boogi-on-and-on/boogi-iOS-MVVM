//
//  HotPostView.swift
//  boogi-iOS-MVVM
//
//  Created by Macbook on 2022/10/01.
//

import Foundation
import SwiftUI


struct HotPostView: View {
    
    @Binding var hotPosts: Post.HotPost
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("핫한 게시물")
                .font(.title)
            Divider()
            contentView(hotPosts: hotPosts)
        }
        .padding()
    }
    
    private func contentView(hotPosts: Post.HotPost) -> AnyView {
        hotPosts.hots.isEmpty ? contentNotExistView() : contentExistView(hotPosts: hotPosts)
    }
    
    private func contentExistView(hotPosts: Post.HotPost) -> AnyView {
        AnyView(
            ForEach(hotPosts.hots) { hotPost in
                HStack {
                    Text(hotPost.content)
                        .truncationMode(.tail)
                        .lineLimit(1)
                    Spacer()
                    HStack(spacing: 2) {
                        Image(systemName: "heart")
                            .foregroundColor(.red)
                            .frame(width: 20, height: 20)
                        Text(countViewText(count: hotPost.likeCount))
                            .frame(width: 30, alignment: .leading)
                            .font(.system(size: 15, weight: .light))
                    }
                    HStack(spacing: 3) {
                        Image(systemName: "ellipsis.message")
                            .frame(width: 20, height: 20)
                        Text(countViewText(count: hotPost.commentCount))
                            .frame(width: 30, alignment: .leading)
                            .font(.system(size: 15, weight: .light))
                    }
                }
                .padding([.leading, .trailing], 2)
                Divider()
            }
        )
    }
    
    private func contentNotExistView() -> AnyView {
        AnyView(
            VStack {
                Text(" ")
                HStack(alignment: .center){
                    Spacer()
                    Text("핫한 게시물이 없습니다")
                        .fontWeight(.thin)
                        .foregroundColor(.gray)
                    Spacer()
                }
                Text(" ")
                Divider()
            }
        )
    }
    
    private func countViewText(count: Int) -> String {
        count < 100 ? "\(count)" : "99+"
    }
}

struct HotPostPreviews: PreviewProvider {
    
    @State static var dummy: Post.HotPost = Post.HotPost(hots: [
        Post.HotPost.Content(postId: 1, communityId: 1, content: "핫한 게시물 핫한 게시물 핫한 게시물 핫한 게시물", likeCount: 100, commentCount: 100, hashtags: ["hot", "핫"]),
        Post.HotPost.Content(postId: 2, communityId: 1, content: "핫한 게시물", likeCount: 5, commentCount: 5, hashtags: ["hot", "핫"]),
        Post.HotPost.Content(postId: 3, communityId: 1, content: "핫한 게시물", likeCount: 10000, commentCount: 10000, hashtags: ["hot", "핫"])
    ])
    
    //    @State static var dummy: Post.HotPost = Post.HotPost(hots: [])
    
    static var previews: some View {
        return HotPostView(hotPosts: $dummy)
        //          .previewLayout(.fixed(width: 2436 / 3.0, height: 1125 / 3.0))
    }
}
