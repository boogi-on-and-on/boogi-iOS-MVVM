//
//  CreateCommnnity.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/06.
//

import Foundation
import SwiftUI
import WrappingHStack

struct CreateCommunity: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        self.content
    }
    
    @ViewBuilder private var content: some View {
        switch viewModel {
        default:
            createForm
        }
    }
    
    var createForm: some View {
        Form {
            Section("카테고리") {
                categoryPicker
                nameTextField
                descriptionTextField
                tags
                tagAddButton
                settings
                createButton
            }
        }
    }
}

// MARK: - CreateView
private extension CreateCommunity {
    var categoryPicker: some View {
        Picker("카테고리", selection: $viewModel.form.category) {
            ForEach(Community.Create.CommunityCategory.allCases.filter { $0 != .all }, id: \.self) { category in
                Text(category.type())
            }
        }
    }
    
    var nameTextField: some View {
        Section("커뮤니티 이름") {
            TextField("커뮤니티 이름", text: $viewModel.form.name)
        }
    }
    
    var descriptionTextField: some View {
        Section("커뮤니티 소개") {
            TextField("커뮤니티 소개", text: $viewModel.form.description)
                .frame(height: 150, alignment: .topLeading)
        }
    }
    
    var tags: some View {
        WrappingHStack($viewModel.form.hashtags, id: \.self) { $hashtag in
            HStack {
                TextField("새로운 태그", text: $hashtag) { }
                    .textFieldStyle(.roundedBorder)
                Button {
                    viewModel.form.hashtags.removeAll { $0 == hashtag }
                } label: {
                    Image(systemName: "delete.left.fill")
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .animation(.default, value: viewModel.form.hashtags)
        
    }
    
    var tagAddButton: some View {
        HStack {
            Spacer()
            Button {
                if viewModel.form.hashtags.count < 5 {
                    viewModel.form.hashtags.append("")
                } else {
                    viewModel.alertPresent = true
                }
            } label: {
                Text("태그 추가")
                    .padding(8)
                    .background(.green)
                    .cornerRadius(15)
                    .foregroundColor(.white)
            }
            .buttonStyle(PlainButtonStyle())
            .alert("태그 5개 초과", isPresented: $viewModel.alertPresent) { }
        }
    }
    
    var settings: some View {
        Section("추가 설정") {
            Button {
                viewModel.form.isPrivate.toggle()
            } label: {
                HStack {
                    Image(systemName: viewModel.form.isPrivate ? "checkmark.square.fill" : "square")
                    Text("비공개")
                        .foregroundColor(.black)
                    Spacer()
                }
            }
            .padding()
            
            Button {
                viewModel.form.autoApproval.toggle()
            } label: {
                HStack {
                    Image(systemName: viewModel.form.autoApproval ? "checkmark.square.fill" : "square")
                    Text("자동가입승인")
                        .foregroundColor(.black)
                    Spacer()
                }
            }
            .padding()
        }
    }
    
    var createButton: some View {
        Button {
            Task {
                await viewModel.requestCreate()
                dismiss()
            }
        } label: {
            HStack {
                Spacer()
                Text("생성하기")
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .alert("이름이나 설명을 입력해주세요", isPresented: $viewModel.cantCreate) { }
        .alert("생성되었습니다", isPresented: $viewModel.confirmPresent) { }
        .buttonStyle(PlainButtonStyle())
    }
}

