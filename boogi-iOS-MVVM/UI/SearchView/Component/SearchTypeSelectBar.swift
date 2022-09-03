//
//  SearchTypeSelectBar.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/03.
//

import Foundation
import SwiftUI

extension SearchView {
struct SearchTypeSelectBar: View {
    @Binding var isCommunitySearch: Bool
    @Binding var order: Search.Parameter.Ordering
    @Binding var isPrivate: Search.Parameter.isPrivate
    
    var body: some View {
        HStack {
            Button {
                isCommunitySearch = true
                order = .newer
            } label: {
                Text("커뮤니티")
            }
            .foregroundColor(isCommunitySearch ? .blue : .black)
            
            Button {
                isCommunitySearch = false
                order = .newer
            } label: {
                Text("게시글")
            }
            .foregroundColor(isCommunitySearch ? .black : .blue)
            
            Spacer()
            
            if isCommunitySearch {
                Picker(isPrivate.type(), selection: $isPrivate) {
                    Text("전체")
                        .tag(Search.Parameter.isPrivate.all)
                    Text("공개")
                        .tag(Search.Parameter.isPrivate.public)
                    Text("비공개")
                        .tag(Search.Parameter.isPrivate.private)
                }
            }
            
            Picker("", selection: $order) {
                Text(Search.Parameter.Ordering.newer.type())
                    .tag(Search.Parameter.Ordering.newer)
                Text(Search.Parameter.Ordering.older.type())
                    .tag(Search.Parameter.Ordering.older)
                if isCommunitySearch {
                    Text(Search.Parameter.Ordering.manyPeople.type())
                        .tag(Search.Parameter.Ordering.manyPeople)
                    Text(Search.Parameter.Ordering.lessPeople.type())
                        .tag(Search.Parameter.Ordering.lessPeople)
                } else {
                    Text(Search.Parameter.Ordering.likeUpper.type())
                        .tag(Search.Parameter.Ordering.likeUpper)
                }
            }
        }
        .padding([.leading, .trailing])
    }
}

}
