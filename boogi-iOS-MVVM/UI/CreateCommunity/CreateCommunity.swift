//
//  CreateCommnnity.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/06.
//

import Foundation
import SwiftUI

struct CreateCommunity: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        self.content
    }
    
    @ViewBuilder private var content: some View {
        switch viewModel {
        default:
            Text("")
        }
    }
}
