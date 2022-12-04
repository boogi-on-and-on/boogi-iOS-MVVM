//
//  CommunityDetailView.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/29.
//

import Foundation
import SwiftUI

struct CommunityDetailView: View {
    let communityId: Int
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                CommunityInfo(communityInfo: viewModel.communityDetail.community)
                
                Divider()
                
                CommunityNoticies(notices: viewModel.communityDetail.notices)
            }
            .task {
                await viewModel.getCommunityDetail(communityId: communityId)
            }
        }
    }
}

struct CommunityInfo: View {
    let communityInfo: Community.Detail.CommunityInfo
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(communityInfo.name)
                    .font(.largeTitle)
                
                Spacer()
                
                Text(communityInfo.isPrivated ? "비공개" : "공개")
                Text("|")
                Text(communityInfo.category.rawValue)
            }
            .padding()
            
            Text(communityInfo.introduce)
                .padding()
            
            HStack {
                ForEach(communityInfo.hashtags ?? [], id: \.self) { tag in
                    Text("#\(tag)")
                }
            }
            .padding([.leading, .trailing])
            
            HStack {
                Text(Date.getDateTime(datetime: communityInfo.createdAt))
                Spacer()
                Image(systemName: "person.fill")
                Text(communityInfo.memberCount)
            }
            .padding([.leading, .trailing])
        }
    }
}

struct CommunityNoticies: View {
    let notices: [Community.Detail.Notice]
    
    var body: some View {
        VStack {
            HStack {
                Text("공지사항")
                    .font(.largeTitle)
                Spacer()
            }
            .padding()
            
            ForEach(notices, id: \.self) { notice in
                HStack {
                    Text(notice.title)
                    Spacer()
                    Text(Date.getDate(datetime: notice.createdAt).timeAgoDisplay())
                }
                .padding([.leading, .trailing])
            }
        }
    }
}
