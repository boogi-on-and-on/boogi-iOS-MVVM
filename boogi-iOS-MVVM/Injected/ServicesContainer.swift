//
//  ServicesContainer.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/07/30.
//

import Foundation

extension DIContainer {
    struct Services {
        let userPermissionsService: UserPermissionsService
        let communitiesService: CommunitiesService
        let postsService: PostsService
        let usersService: UsersService
        let imagesService: ImagesService
        let searchService: SearchService
        let alarmsService: AlarmsService
        let noticesService: NoticesService
        let messagesService: MessagesService
        
        init(
             userPermissionsService: UserPermissionsService,
             communitiesService: CommunitiesService,
             postsService: PostsService,
             usersService: UsersService,
             imagesService: ImagesService,
             searchService: SearchService,
             alarmsService: AlarmsService,
             noticesService: NoticesService,
             messagesService: MessagesService
        ) {
            self.userPermissionsService = userPermissionsService
            self.communitiesService = communitiesService
            self.postsService = postsService
            self.usersService = usersService
            self.imagesService = imagesService
            self.searchService = searchService
            self.alarmsService = alarmsService
            self.noticesService = noticesService
            self.messagesService = messagesService
        }
        
        static var stub: Self {
            .init(
                  userPermissionsService: StubUserPermissionsService(),
                  communitiesService: StubCommunitiesService(),
                  postsService: StubPostsService(),
                  usersService: StubUsersService(),
                  imagesService: StubImagesService(),
                  searchService: StubSearchService(),
                  alarmsService: StubAlarmsService(),
                  noticesService: StubNoticesService(),
                  messagesService: StubMessagesService()
            )
        }
        
        static func getDateTime(datetime: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            dateFormatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
            
            guard let date = dateFormatter.date(from: datetime) else {
                return ""
            }
            
            dateFormatter.dateFormat = "yy-MM-dd HH:mm"
            return dateFormatter.string(from: date)
        }
    }
}

