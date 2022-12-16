//
//  CommentBar.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/12/16.
//

import Foundation
import SwiftUI

extension CommentsView {
    struct CommentBar: View {
        @Binding var keyword: String
        @State var isEditing = false
        let search: () async -> ()
        
        var body: some View {
            HStack {
                ZStack {
                    TextField("댓글을 입력하세요.", text: $keyword, onCommit: {
                        Task {
                            await search()
                            self.isEditing = false
                        }
                    })
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.gray.opacity(0.2))
                    )
                    .padding()
                    .onTapGesture { self.isEditing = true }
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            Task {
                                await search()
                                self.isEditing = false
                            }
                        } label: {
                            Text("Post")
                                .foregroundColor(isEditing ? .blue : .gray)
                        }
                        .padding(.trailing, 30)
                    }
                }
                .animation(.default, value: isEditing)
                
                if isEditing {
                    Button {
                        self.isEditing = false
                        keyword = ""
                    } label: {
                        Text("Cancel")
                    }
                    .padding(.trailing)
                }
            }
        }
    }
}
