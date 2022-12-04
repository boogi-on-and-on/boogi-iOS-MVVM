//
//  UserComments.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/22.
//

import Foundation
import SwiftUI

struct UserComments: View {
    let profile: User.Profile
    let userComments: Comment.UserComments
    
    var body: some View {
        ScrollView {
            if userComments.comments.isEmpty {
                Spacer()
                Text("댓글이 없습니다.")
                Spacer()
            } else {
                
                ForEach(userComments.comments, id: \.self) { comment in
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
                            
                            Text(Date.getDate(datetime: comment.createdAt).timeAgoDisplay())
                        }
                        
                        Text(comment.content)
                            .padding()
                    }
                    .padding()
                }
            }
        }
    }
}

