//
//  SearchBar.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/27.
//

import Foundation
import SwiftUI

extension SearchView {
struct SearchBar: View {
    @Binding var keyword: String
    @State var isEditing = false
    let search: () async -> ()
    
    var body: some View {
        HStack {
            ZStack {
                TextField("Search ...", text: $keyword, onCommit: {
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
                        Image(systemName: "magnifyingglass")
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
