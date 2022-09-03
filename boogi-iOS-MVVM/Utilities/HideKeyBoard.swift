//
//  HideKeyBoard.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/03.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyBoard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
