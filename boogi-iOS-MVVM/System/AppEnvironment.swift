//
//  AppEnvironment.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/06.
//

import Foundation
import Combine

struct AppEnvironment {
    let container: DIContainer
//    let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        let session = configuredURLSession()
        let webRepositories = configuredWebRepositories(session: session)
        let services = configuredServices(// appState: appState,
                                                webRepositories: webRepositories)
        let diContainer = DIContainer(/* appState: appState, */services: services)
        // let deepLinksHandler = RealDeepLinksHandler(container: diContainer)
        // let pushNotificationsHandler = RealPushNotificationsHandler(deepLinksHandler: deepLinksHandler)
        // let systemEventsHandler = RealSystemEventsHandler(
            // container: diContainer, deepLinksHandler: deepLinksHandler,
            // pushNotificationsHandler: pushNotificationsHandler,
            // pushTokenWebRepository: webRepositories.pushTokenWebRepository)
        return AppEnvironment(container: diContainer /*,
                              systemEventsHandler: systemEventsHandler */)
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        // configuration.timeoutIntervalForRequest = 60
        // configuration.timeoutIntervalForResource = 120
        // configuration.waitsForConnectivity = true
        // configuration.httpMaximumConnectionsPerHost = 5
        // configuration.requestCachePolicy = .returnCacheDataElseLoad
        // configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
    
    private static func configuredWebRepositories(session: URLSession) -> DIContainer.Repositories {
        let communitiesWebRepository = RealCommunitiesWebRepository(
            session: session,
            baseURL: "ip/communities/")
        
        
        return .init(communitiesWebRepository: communitiesWebRepository)
    }
    
    private static func configuredServices(
        // appState: Store<AppState>,
        webRepositories: DIContainer.Repositories
    ) -> DIContainer.Services {
        let communitiesService = RealCommunityService(
            webRepository: webRepositories.communitiesWebRepository)
//            appState: appState)
        
//        let userPermissionsService = RealUserPermissionsService(
//            appState: appState, openAppSettings: {
//                URL(string: UIApplication.openSettingsURLString).flatMap {
//                    UIApplication.shared.open($0, options: [:], completionHandler: nil)
//                }
//            })
        
        return .init(communitiesService: communitiesService)
                     // userPermissionsService: userPermissionsService)
    }
}
