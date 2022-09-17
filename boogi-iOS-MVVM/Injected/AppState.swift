//
//  AppState.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/07/30.
//

import SwiftUI
import Combine

struct AppState: Equatable {
    var userData = UserData()
    var routing = ViewRouting()
    var system = System()
    var permissions = Permissions()
}

extension AppState {
    struct UserData: Equatable {
        static func == (lhs: AppState.UserData, rhs: AppState.UserData) -> Bool {
            return lhs.email == rhs.email && lhs.xAuthToken == rhs.xAuthToken
        }
        
        @AppStorage("email") var email: String = ""
        @AppStorage("xAuthToken") var xAuthToken: String = "82e1133c-6d4e-4c39-91d1-c7390c6f9829"
    }
}

extension AppState {
    struct ViewRouting: Equatable {
//        var countriesList = CountriesList.Routing()
//        var countryDetails = CountryDetails.Routing()
    }
}

extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
        var keyboardHeight: CGFloat = 0
    }
}

extension AppState {
    struct Permissions: Equatable {
        var push: Permission.Status = .unknown
    }
    
    static func permissionKeyPath(for permission: Permission) -> WritableKeyPath<AppState, Permission.Status> {
        let pathToPermissions = \AppState.permissions
        switch permission {
        case .pushNotifications:
            return pathToPermissions.appending(path: \.push)
        }
    }
}

func == (lhs: AppState, rhs: AppState) -> Bool {
    return lhs.userData == rhs.userData &&
        lhs.routing == rhs.routing &&
        lhs.system == rhs.system &&
        lhs.permissions == rhs.permissions
}

#if DEBUG
extension AppState {
    static var preview: AppState {
        var state = AppState()
        state.system.isActive = true
        return state
    }
}
#endif
