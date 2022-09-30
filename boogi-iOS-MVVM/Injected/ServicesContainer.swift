//
//  ServicesContainer.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/07/30.
//

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
        
        init(
             userPermissionsService: UserPermissionsService,
             communitiesService: CommunitiesService,
             postsService: PostsService,
             usersService: UsersService,
             imagesService: ImagesService,
             searchService: SearchService,
             alarmsService: AlarmsService,
             noticesService: NoticesService
        ) {
            self.userPermissionsService = userPermissionsService
            self.communitiesService = communitiesService
            self.postsService = postsService
            self.usersService = usersService
            self.imagesService = imagesService
            self.searchService = searchService
            self.alarmsService = alarmsService
            self.noticesService = noticesService
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
                  noticesService: StubNoticesService()
            )
        }
        
        static func getDateTime(datetime: String) -> String {
            let tokens = datetime.components(separatedBy: ["T", "-", ":", "."])
            
            return "\(tokens[0][tokens[0].index(tokens[0].startIndex, offsetBy: 2)...]).\(tokens[1]).\(tokens[2]) \(tokens[3]):\(tokens[4])"
        }
    }
}
