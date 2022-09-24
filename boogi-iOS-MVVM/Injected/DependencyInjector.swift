//
//  DependencyInjector.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/07/30.
//

import SwiftUI
import Combine

// MARK: - DIContainer

struct DIContainer: EnvironmentKey {
    
    let appState: AppState
    let services: Services
//    let interactors: Interactors
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = DIContainer(appState: AppState(), services: .stub)
    
    init(appState: AppState, services: DIContainer.Services) {
        self.appState = appState
        self.services = services
    }
    
    /*
    init(appState: AppState, services: DIContainer.Services) {
        self.init(appState: Store(appState), services: services)
    }
    */
}

/*
#if DEBUG
extension DIContainer {
    static var preview: Self {
        .init(appState: AppState.preview, services: .stub)
    }
}
#endif
     
*/
