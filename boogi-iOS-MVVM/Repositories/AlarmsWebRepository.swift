//
//  AlarmsWebRepository.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/17.
//

import Foundation

protocol AlarmsWebRepository: WebRepository {
    func getAlarms() async -> Result<Alarm, Error>
    // func deleteAlarms(id: Int) -> Result<Int, Error>
}

struct RealAlarmsWebRepository: AlarmsWebRepository {
    func getAlarms() async -> Result<Alarm, Error> {
        return await call(endpoint: API.getAlarms)
    }
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    var session: URLSession
    var baseURL: String
}

// MARK: - Endpoints
extension RealAlarmsWebRepository {
    enum API {
        case getAlarms
        case deleteAlarms(Int)
    }
}

extension RealAlarmsWebRepository.API: APICall {
    var path: String {
        switch self {
        case .getAlarms:
            return "/"
        case let .deleteAlarms(id):
            return "\(id)/delete"
        }
    }
    
    
    var method: String {
        switch self {
        case .getAlarms:
            return "GET"
        case .deleteAlarms:
            return "POST"
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "X-Auth-Token": "82e1133c-6d4e-4c39-91d1-c7390c6f9829"
        ]
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
    
    func body() throws -> Data? {
        return nil
    }
    
    
}
