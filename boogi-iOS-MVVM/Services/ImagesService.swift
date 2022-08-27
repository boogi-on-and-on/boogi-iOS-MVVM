//
//  ImagesService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/27.
//

import Foundation
import UIKit

protocol ImagesService {
    func getPostMediaIds(images: [UIImage]) async -> [String]
}

struct RealImagesService: ImagesService {
    let webRepository: ImagesWebRepository
    
    func getPostMediaIds(images: [UIImage]) async -> [String] {
        let res = await webRepository.getPostMediaIds(images: images)
        
        switch res {
        case .success(let data):
            print(data)
            return data
        case .failure(let err):
            print(err)
            return []
        }
    }
}

struct StubImagesService: ImagesService {
    func getPostMediaIds(images: [UIImage]) async -> [String] {
        []
    }
}
