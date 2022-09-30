//
//  Main.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/24.
//

import Foundation
import SwiftUI

struct Main: View{
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        TabView {
            HomeView(
                viewModel: HomeView.ViewModel(
                    container: viewModel.container
                )
            )
            .tabItem {
                Image(systemName: "house")
                Text("홈")
            }
            
            
            CreateView(
                container: viewModel.container
            )
            .tabItem {
                Image(systemName: "plus.app")
                Text("등록")
            }
            
            SearchView(
                viewModel: SearchView.ViewModel(
                    container: viewModel.container
                )
            )
            .tabItem {
                Image(systemName: "magnifyingglass.circle")
                Text("검색")
            }
            
            NotificationView(
                viewModel: NotificationView.ViewModel(
                    container: viewModel.container
                )
            )
            .tabItem {
                Image(systemName: "bell")
                Text("알림")
            }
        }
    }
}

extension Main {
    class ViewModel: ObservableObject {
        @Published var isActive = false
        
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
    }
}
