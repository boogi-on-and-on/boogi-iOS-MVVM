//
//  CommentsView.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/12/10.
//

import Foundation
import SwiftUI

struct CommentsView: View {
    let viewModel: PostDetailView.ViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.postComments.comments, id: \.self) { comment in
                    // TODO: 
                }
            }
        }
        .task {
            await viewModel.getPostComments(postId: viewModel.detail.id)
        }
    }
}
