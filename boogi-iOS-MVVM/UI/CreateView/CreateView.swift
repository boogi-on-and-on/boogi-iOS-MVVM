//
//  Create.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/27.
//

import Foundation
import SwiftUI

struct CreateView: View {
    let container: DIContainer
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    CreatePost(viewModel: CreatePost.ViewModel(container: container))
                } label: {
                    Text("글쓰기")
                        .padding()
                        .frame(width: UIScreen.main.bounds.width / 2)
                        .background(Color.blue)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                }
                
                NavigationLink {
                    CreateCommunity(viewModel: CreateCommunity.ViewModel(container: container))
                } label: {
                    Text("커뮤니티만들기")
                        .padding()
                        .frame(width: UIScreen.main.bounds.width / 2)
                        .background(Color.blue)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                }
            }
        }
    }
}
