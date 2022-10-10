//
//  FirstLaunch.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/10/08.
//

import Foundation
import SwiftUI

struct FirstLaunch: View {
    @ObservedObject private(set) var viewModel: ViewModel
    @State var email: String = ""
    @State var confirm: Bool = false
    
    var body: some View {
        Form {
            Section("E-mail") {
                TextField("E-mail", text: $email)
                    .textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Spacer()
                Button {
                    confirm = true
                    Task {
                        await viewModel.getToken(email: email)
                    }
                } label: {
                    Text("적용하기")
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .buttonStyle(PlainButtonStyle())
        }
        .alert("적용되었습니다", isPresented: $confirm) { }
    }
}

extension FirstLaunch {
    class ViewModel: ObservableObject {
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
        
        func getToken(email: String) async {
            let res = await container.services.usersService.getToken(email: email)
            
            UserDefaults.standard.set(res, forKey: "launchedBefore")
        }
    }
}
