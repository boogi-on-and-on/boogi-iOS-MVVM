//
//  RepositoriesContainer.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/06.
//

import Foundation

extension DIContainer {
    struct Repositories {
        let communitiesWebRepository: CommunitiesWebRepository
        let postsWebRepository: PostsWebRepository
        let usersWebRepository: UsersWebRepository
        let imagesWebRepository: ImagesWebRepository
        let searchWebRepository: SearchWebRepository
    }
}
