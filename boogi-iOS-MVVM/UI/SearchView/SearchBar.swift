//
//  SearchBar.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/27.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var keyword: String
    @State var isEditing = false
    
    var body: some View {
        HStack {
            ZStack {
                TextField("Search ...", text: $keyword, onCommit: {
                    self.isEditing = false
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
                    self.keyword = ""
                } label: {
                    Text("Cancel")
                }
                .padding(.trailing)
            }
        }
    }
}
