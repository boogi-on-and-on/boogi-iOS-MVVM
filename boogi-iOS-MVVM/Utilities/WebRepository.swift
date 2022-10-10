//
//  WebRepository.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/07/30.
//

import Foundation

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
}

extension WebRepository {
    func call<Value>(endpoint: APICall, httpCodes: HTTPCodes = .success) async -> Result<Value, Error>
        where Value: Decodable {
        do {
            // TODO: validate token
//            if !isValid {
//                auth
//            }
            
            let request = try endpoint.urlRequest(baseURL: baseURL)
            let (data, response) = try await session.data(for: request)
            
            guard let code = (response as? HTTPURLResponse)?.statusCode else {
                throw APIError.unexpectedResponse
            }
            guard httpCodes.contains(code) else {
                throw APIError.httpCode(code)
            }
            
            let value = try JSONDecoder().decode(Value.self, from: data)
            return .success(value)
        } catch let error as APIError {
            print(error.errorDescription as Any)
            return .failure(error)
        } catch let error {
            return .failure(error)
        }
    }
    
    func auth(endpoint: APICall, httpCodes: HTTPCodes = .success) async -> Result<String?, Error> {
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL)
            let (_data, response) = try await session.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                throw APIError.unexpectedResponse
            }
            
            let code = response.statusCode
            guard httpCodes.contains(code) else {
                throw APIError.httpCode(code)
            }
            
            let token = response.value(forHTTPHeaderField: "X-Auth-Token")
            return .success(token)
        }
        catch let error as APIError {
            print(error.errorDescription as Any)
            return .failure(error)
        } catch let error {
            return .failure(error)
        }
    }
}
