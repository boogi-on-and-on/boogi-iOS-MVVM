//
//  SearchViewModel.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/27.
//

import Foundation

extension SearchView {
    class ViewModel: ObservableObject {
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
    }
}
