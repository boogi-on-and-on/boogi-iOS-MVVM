//
//  UserPermissionsService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/07/30.
//

import Foundation
import UserNotifications

enum Permission {
    case pushNotifications
}

extension Permission {
    enum Status: Equatable {
        case unknown
        case notRequested
        case granted
        case denied
    }
}

protocol UserPermissionsService: AnyObject {
    func resolveStatus(for permission: Permission)
    func request(permission: Permission)
}

// MARK: - RealUserPermissionsService

final class RealUserPermissionsService: UserPermissionsService {
    
    private var appState: AppState
    private let openAppSettings: () -> Void
    
    init(appState: AppState, openAppSettings: @escaping () -> Void) {
        self.appState = appState
        self.openAppSettings = openAppSettings
    }
    
    func resolveStatus(for permission: Permission) {
        let currentStatus = appState.permissions.push
        guard currentStatus == .unknown else { return }
        let onResolve: (Permission.Status) -> Void = { status in
            self.appState.permissions.push = status
        }
        switch permission {
        case .pushNotifications:
            pushNotificationsPermissionStatus(onResolve)
        }
    }
    
    func request(permission: Permission) {
        let currentStatus = appState.permissions.push
        guard currentStatus != .denied else {
            openAppSettings()
            return
        }
        switch permission {
        case .pushNotifications:
            requestPushNotificationsPermission()
        }
    }
}
    
// MARK: - Push Notifications

extension UNAuthorizationStatus {
    var map: Permission.Status {
        switch self {
        case .denied: return .denied
        case .authorized: return .granted
        case .notDetermined, .provisional, .ephemeral: return .notRequested
        @unknown default: return .notRequested
        }
    }
}

private extension RealUserPermissionsService {
    
    func pushNotificationsPermissionStatus(_ resolve: @escaping (Permission.Status) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                resolve(settings.authorizationStatus.map)
            }
        }
    }
    
    func requestPushNotificationsPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (isGranted, error) in
            DispatchQueue.main.async {
                self.appState.permissions.push = isGranted ? .granted : .denied
            }
        }
    }
}

// MARK: -

final class StubUserPermissionsService: UserPermissionsService {
    
    func resolveStatus(for permission: Permission) {
    }
    func request(permission: Permission) {
    }
}

