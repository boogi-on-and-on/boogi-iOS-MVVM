//
//  CommunitySearchResultList.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/03.
//

import Foundation
import SwiftUI

extension SearchView {
struct CommunitySearchResultList: View {
    @Binding var result: Search.CommunitySearchResult
    
    @State var alertPresent = false
    @State var confirmPresent = false
    @State var errorMessage = ""
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach($result.communities, id: \.self) { $community in
                    NavigationLink {
                        /*
                        CommunityHomeLink(communityId: community.id)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button {
                                        Task {
                                            do {
                                                let _ = try await WebService.webService.postJoinRequests(communityId: community.id)
                                                confirmPresent = true
                                            } catch (let err as APIError) {
                                                errorMessage = err.message
                                                alertPresent = true
                                            }
                                        }
                                    } label: {
                                        Text("가입")
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .alert(errorMessage, isPresented: $alertPresent) { }
                            .alert("가입신청되었습니다", isPresented: $confirmPresent) { }
                         */
                    } label: {
                        Row(community: $community)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Divider()
                }
                .padding()
                
                /*
                if (res?.pageInfo.hasNext) ?? true {
                    ProgressView()
                        .padding()
                        .task {
                            await viewModel.getCommunitiesSearch()
                        }
                }
                 */
                
                if result.communities.isEmpty {
                    Text("결과가 없습니다.")
                }
            }
        }
    }
}

}

extension SearchView.CommunitySearchResultList {
    struct Row: View {
        @Binding var community: Search.CommunitySearchResult.Community
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text(community.name)
                        .font(.largeTitle)
                    
                    Spacer()
                    
                    Text("\(community.private ? "비공개" : "공개")")
                    
                    Text(" | ")
                    
                    Text("\(Community.Category(rawValue: community.category)?.type() ?? "")")
                }
                
                Text(community.description)
                    .padding([.top, .bottom])
                
                HStack {
                    ForEach(community.hashtags ?? [], id: \.self) { tag in
                        Text("#\(tag)")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                
                HStack {
                    Text(community.createdAt)
                    Spacer()
                    Image(systemName: "person.fill")
                    Text(community.memberCount.description)
                }
            }
        }
    }
}

/*
struct CommunityHomeLink: UIViewControllerRepresentable {
    let communityId: Int
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = ViewControllerFactory.viewControllerFactory.makeViewController(controllerType: .communityHome, id: communityId)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
 */

