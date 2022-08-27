//
//  ServicesContainer.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/07/30.
//

extension DIContainer {
    struct Services {
        // let userPermissionsService: UserPermissionsService
        let communitiesService: CommunitiesService
        let postsService: PostsService
        let usersService: UsersService
        let imagesService: ImagesService
        let searchService: SearchService
        
        init(
             // userPermissionsService: UserPermissionsService,
             communitiesService: CommunitiesService,
             postsService: PostsService,
             usersService: UsersService,
             imagesService: ImagesService,
             searchService: SearchService
        ) {
            // self.userPermissionsService = userPermissionsService
            self.communitiesService = communitiesService
            self.postsService = postsService
            self.usersService = usersService
            self.imagesService = imagesService
            self.searchService = searchService
        }
        
        static var stub: Self {
            .init(// countriesService: StubCountriesService(),
                  // imagesService: StubImagesService(),
                  // userPermissionsService: StubUserPermissionsService(),
                  communitiesService: StubCommunitiesService(),
                  postsService: StubPostsService(),
                  usersService: StubUsersService(),
                  imagesService: StubImagesService(),
                  searchService: StubSearchService()
            )
        }
    }
}
