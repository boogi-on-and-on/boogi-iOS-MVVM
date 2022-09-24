//
//  AppEnvironment.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/06.
//

import Foundation
import UIKit

struct AppEnvironment {
    let container: DIContainer
//    let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        let appState = AppState()
        let session = configuredURLSession()
        let webRepositories = configuredWebRepositories(session: session)
        let services = configuredServices(appState: appState, webRepositories: webRepositories)
        let diContainer = DIContainer(appState: appState, services: services)
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
        let ip = "http://34.64.169.65:80/api"
        
        let communitiesWebRepository = RealCommunitiesWebRepository(
            session: session, baseURL: "\(ip)/communities"
        )
        
        let postsWebRepository = RealPostsWebRepository(
            session: session, baseURL: "\(ip)/posts"
        )
        
        let usersWebRepository = RealUsersWebRepository(
            session: session, baseURL: "\(ip)/users"
        )
        
        let imagesWebRepository = RealImagesWebRepository(
            session: session, baseURL: "\(ip)/images"
        )
        
        let searchWebRepository = RealSearchWebRepository(
            session: session, baseURL: "\(ip)"
        )
        
        let alarmsWebRepository = RealAlarmsWebRepository(
            session: session, baseURL: "/alarms"
        )
        
        
        return .init(
            communitiesWebRepository: communitiesWebRepository,
            postsWebRepository: postsWebRepository,
            usersWebRepository: usersWebRepository,
            imagesWebRepository: imagesWebRepository,
            searchWebRepository: searchWebRepository,
            alarmsWebRepository: alarmsWebRepository
        )
    }
    
    private static func configuredServices(
        appState: AppState,
        webRepositories: DIContainer.Repositories
    ) -> DIContainer.Services {
        
        let communitiesService = RealCommunitiesService(
            webRepository: webRepositories.communitiesWebRepository
        )
        let postsService = RealPostsService(
            webRepository: webRepositories.postsWebRepository
        )
        let usersService = RealUsersService(
            webRepository: webRepositories.usersWebRepository
        )
        let imagesService = RealImagesService(
            webRepository: webRepositories.imagesWebRepository
        )
        let searchService = RealSearchService(
            webRepository: webRepositories.searchWebRepository
        )
        let alarmsService = RealAlarmsService(
            webRepository: webRepositories.alarmsWebRepository
        )
        let userPermissionsService = RealUserPermissionsService(
            appState: appState, openAppSettings: {
                URL(string: UIApplication.openSettingsURLString).flatMap {
                    UIApplication.shared.open($0, options: [:], completionHandler: nil)
                }
            })
        
        return .init(
            userPermissionsService: userPermissionsService,
            communitiesService: communitiesService,
            postsService: postsService,
            usersService: usersService,
            imagesService: imagesService,
            searchService: searchService,
            alarmsService: alarmsService
        )
    }
}
