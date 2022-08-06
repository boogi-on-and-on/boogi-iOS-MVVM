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
        
        init(// countriesService: CountriesService,
             // imagesService: ImagesService,
             // userPermissionsService: UserPermissionsService,
             communitiesService: CommunitiesService
        ) {
            // self.imagesService = imagesService
            // self.userPermissionsService = userPermissionsService
            self.communitiesService = communitiesService
        }
        
        static var stub: Self {
            .init(// countriesService: StubCountriesService(),
                  // imagesService: StubImagesService(),
                  // userPermissionsService: StubUserPermissionsService(),
                  communitiesService: StubCommunitiesService()
            )
        }
    }
}
