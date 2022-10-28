//
//  CommunityCategoryBar.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/03.
//

import Foundation
import SwiftUI


extension SearchView {
struct CommunityCategoryBar: View {
    @Binding var category: Community.Category
    
    var body: some View {
        HStack {
            Button {
                category = .all
            } label: {
                Text(Community.Category.all.type())
            }
            .foregroundColor(category == .all ? .blue : .gray)
            
            Button {
                category = .academic
            } label: {
                Text(Community.Category.academic.type())
            }
            .foregroundColor(category == .academic ? .blue : .gray)
            
            Button {
                category = .club
            } label: {
                Text(Community.Category.club.type())
            }
            .foregroundColor(category == .club ? .blue : .gray)
            
            Button {
                category = .hobby
            } label: {
                Text(Community.Category.hobby.type())
            }
            .foregroundColor(category == .hobby ? .blue : .gray)
            
            Button {
                category = .other
            } label: {
                Text(Community.Category.other.type())
            }
            .foregroundColor(category == .other ? .blue : .gray)
            
            Spacer()
        }
        .buttonStyle(.plain)
        .padding([.leading, .trailing])
    }
}
}
