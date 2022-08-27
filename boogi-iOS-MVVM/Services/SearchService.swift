//
//  SearchService.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/27.
//

import Foundation

protocol SearchService {
    
}

struct RealSearchService: SearchService {
    let webRepository: SearchWebRepository
    
    
}

struct StubSearchService: SearchService {
    
}
