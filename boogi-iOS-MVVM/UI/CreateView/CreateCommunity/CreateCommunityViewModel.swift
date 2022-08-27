//
//  CreateCommunityViewModel.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/06.
//

import Foundation
import SwiftUI

// MARK: - ViewModel

extension CreateCommunity {
    class ViewModel: ObservableObject {
        @Published var form = Community.Create()
        @Published var success: Bool = false
        @Published var fail: Bool = false
        
        @State var alertPresent: Bool = false
        @State var confirmPresent = false
        @State var cantCreate = false
        
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
        
        func requestCreate() async {
            if (form.name == "" ||
                form.description == "") {
                cantCreate = true
                return
            }
            form.hashtags.removeAll { $0 == "" }
            
            let res = await container.services.communitiesService
                .createCommunity(form: form)
            
            switch res {
            case -1:
                self.fail = true
            default:
                self.success = true
            }
        }
    }
}
