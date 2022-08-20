//
//  ServicesContainer.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/07/30.
//

extension DIContainer {
    struct Services {
        // let imagesService: ImagesService
        // let userPermissionsService: UserPermissionsService
        let communitiesService: CommunitiesService
        let postsService: PostsService
        let usersService: UsersService
        
        init(// countriesService: CountriesService,
             // imagesService: ImagesService,
             // userPermissionsService: UserPermissionsService,
             communitiesService: CommunitiesService,
             postsService: PostsService,
             usersService: UsersService
        ) {
            // self.imagesService = imagesService
            // self.userPermissionsService = userPermissionsService
            self.communitiesService = communitiesService
            self.postsService = postsService
            self.usersService = usersService
        }
        
        static var stub: Self {
            .init(// countriesService: StubCountriesService(),
                  // imagesService: StubImagesService(),
                  // userPermissionsService: StubUserPermissionsService(),
                  communitiesService: StubCommunitiesService(),
                  postsService: StubPostsService(),
                  usersService: StubUsersService()
            )
        }
    }
}
