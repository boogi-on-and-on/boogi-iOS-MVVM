//
//  ImagesWebRepository.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/08/27.
//

import Foundation
import UIKit

protocol ImagesWebRepository: WebRepository {
    func getPostMediaIds(images: [UIImage]) async -> Result<[String], Error>
}

struct RealImagesWebRepository: ImagesWebRepository {
    func getPostMediaIds(images: [UIImage]) async -> Result<[String], Error> {
        let boundary = UUID().uuidString
        return await call(endpoint: API.getPostMediaIds(boundary, images))
    }
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    var session: URLSession
    var baseURL: String
}

// MARK: - Endpoints

extension RealImagesWebRepository {
    enum API {
        case getPostMediaIds(String, [UIImage])
        // TODO: - todos
        /*
         case: getBlockedMessages
         case: postBlockedMessages
         case: postUnblockedMessages
         case: getNotificationsConfig
         */
    }
}

extension RealImagesWebRepository.API: APICall {
    var path: String {
        switch self {
        case .getPostMediaIds:
            return "/post"
        }
    }
    
    var method: String {
        switch self {
        case .getPostMediaIds:
            return "POST"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case let .getPostMediaIds(boundary, _):
            return [
                "Content-Type": "multipart/form-data; boundary=\(boundary)",
                // TODO: need user authentication token
                "X-Auth-Token": "X-Auth-Token"
            ]
        }
    }
    
    
    func body() throws -> Data? {
        switch self {
        case let .getPostMediaIds(boundary, images):
            return makeBody(boundary: boundary, images: images)
        }
    }
    
    func makeBody(boundary: String, images: [UIImage]) -> Data? {
        guard let boundaryPrefix = "\r\n--\(boundary)\r\n".data(using: .utf8) else { return nil }
        guard let boundarySuffix = "\r\n--\(boundary)--\r\n".data(using: .utf8) else { return nil }
        
        var body = Data()
        
        for (i, image) in images.enumerated() {
            // (boundary)로 시작.
            body.append(boundaryPrefix)
            
            // 헤더 정의 - 문자열로 작성 후 UTF8로 인코딩해서 Data타입으로 변환해야 함
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"img\(i)\"\r\n".data(using: .utf8)!)
            
            // 헤더 정의 2 - 문자열로 작성 후 UTF8로 인코딩해서 Data타입으로 변환해야 함, 구분은 \r\n으로 통일.
            body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            
            // 내용 붙이기
            body.append(image.pngData()!)
        }
        
        // 내용 끝나는 곳에 (boundary)로 표시해준다.
        body.append(boundarySuffix)
        
        return body
    }
}

