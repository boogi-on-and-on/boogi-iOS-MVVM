//
//  CreatePost.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/20.
//

import Foundation
import SwiftUI
import PhotosUI
import WrappingHStack

struct CreatePost: View {
    @ObservedObject private(set) var viewModel: ViewModel
    @State var isPicking = false
    
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
        ZStack {
            Form {
                communitySelect
                article
                tag
            }
        }
    }
}


// MARK: ImagePicker
extension CreatePost {
    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var isPicking: Bool
        @Binding var images: [UIImage]
        
        class Coordinator: PHPickerViewControllerDelegate {
            let picker: ImagePicker
            init(picker: ImagePicker) {
                self.picker = picker
            }
            
            func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
                self.picker.isPicking = false
                
                self.picker.images.removeAll()
                for img in results {
                    if img.itemProvider.canLoadObject(ofClass: UIImage.self) {
                        img.itemProvider.loadObject(ofClass: UIImage.self) { loadedImg, error in
                            guard let loadedImg = loadedImg else {
                                return
                            }
                            
                            self.picker.images.append(loadedImg as! UIImage)
                        }
                    }
                }
            }
        }
        
        func makeCoordinator() -> Coordinator {
            return ImagePicker.Coordinator(picker: self)
        }
        
        func makeUIViewController(context: Context) -> some UIViewController {
            var pickerConfig = PHPickerConfiguration()
            pickerConfig.selectionLimit = 3
            pickerConfig.filter = .images
            
            let picker = PHPickerViewController(configuration: pickerConfig)
            picker.delegate = context.coordinator
            
            return picker
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}


// MARK: - CreateView

extension CreatePost {
    var communitySelect: some View {
        Section("커뮤니티 선택") {
            Picker("커뮤니티 선택", selection: $viewModel.selectedCommunity) {
                ForEach(viewModel.joinedCommunities.communities, id: \.self) { community in
                    Text(community.name)
                }
            }
            .task {
                await viewModel.getJoinedCommunities()
            }
        }
    }
    
    var article: some View {
        Section("글") {
            TextEditor(text: $viewModel.form.content)
                .frame(height: 150, alignment: .topLeading)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
    }
    
    var tag: some View {
        Section("태그") {
            WrappingHStack($viewModel.form.hashtags) { $new in
                HStack {
                    TextField("새로운태그", text: $new)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        viewModel.form.hashtags.removeAll { $0 == new }
                    } label: {
                        Image(systemName: "delete.left.fill")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .animation(.default, value: viewModel.form.hashtags.count)
            
            HStack {
                Spacer()
                Button {
                    if viewModel.form.hashtags.count < 5 {
                        viewModel.form.hashtags.append(String(""))
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
    }
    
    var picture: some View {
        Section("사진") {
            HStack {
                ForEach(viewModel.images, id: \.self) { img in
                    Image(uiImage: img)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
                Button {
                    isPicking = true
                } label: {
                    Text("Image")
                }
            }
            .sheet(isPresented: $isPicking) {
                ImagePicker(isPicking: $isPicking, images: $viewModel.images)
            }
        }
    }
    
    var createButton: some View {
        Button {
            Task {
                await viewModel.requestCreate()
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
        .alert("생성되었습니다", isPresented: $viewModel.confirmPresent) { }
        .buttonStyle(PlainButtonStyle())
    }
}
