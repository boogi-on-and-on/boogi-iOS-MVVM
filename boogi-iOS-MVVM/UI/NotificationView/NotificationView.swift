//
//  NotificationView.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/17.
//

import Foundation
import SwiftUI

struct NotificationView: View {
    @State var selection = 0
    @State var easterCnt = 0
    @State var easter = false
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        selection = 0
                        easterCnt += 1
                        if 10 < easterCnt {
                            easter = true
                        }
                    } label: {
                        Text("알림")
                            .foregroundColor(selection == 0 ? .blue : .black)
                    }
                    
                    Spacer()
                    
                    Button {
                        selection = 1
                    } label: {
                        Text("쪽지")
                            .foregroundColor(selection == 1 ? .blue : .black)
                    }
                    
                    Spacer()
                }
                .padding()
                .background(.gray.opacity(0.5))
                
                if selection == 0 {
                    AlarmView(viewModel: AlarmView.ViewModel(container: viewModel.container))
                        .navigationBarHidden(true)
                } else if selection == 1 {
                    MessageView(viewModel: MessageView.ViewModel(container: viewModel.container))
                        .navigationBarHidden(true)
                }
                
                Spacer()
            }
        }
    }
}
