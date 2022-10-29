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
    func tokenValidation(httpCodes: HTTPCodes = .success) async throws -> Bool {
        let request = try RealUsersWebRepository.API.tokenValidation.urlRequest(baseURL: "http://34.64.211.94:80/api/users")
        let (data, response) = try await session.data(for: request)
        
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw APIError.unexpectedResponse
        }
        guard httpCodes.contains(code) else {
            throw APIError.httpCode(code)
        }
        
        let value = try JSONDecoder().decode(User.TokenValidation.self, from: data)
        return value.isValid
    }
    
    func call<Value>(endpoint: APICall, httpCodes: HTTPCodes = .success) async -> Result<Value, Error>
        where Value: Decodable {
        do {
            // TODO: validate token
            if try await !tokenValidation() {
                let res = await auth(endpoint: RealUsersWebRepository.API.getToken(
                        UserDefaults.standard.string(forKey: "xAuthToken") ?? ""))
                switch res {
                case .success(let data):
                    UserDefaults.standard.set(data, forKey: "xAuthToken")
                case .failure(let err):
                    print(err)
                    throw APIError.unexpectedResponse
                }
            }
            
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
            let (_, response) = try await session.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                throw APIError.unexpectedResponse
            }
            
            let code = response.statusCode
            guard httpCodes.contains(code) else {
                throw APIError.httpCode(code)
            }
            
            let token = response.value(forHTTPHeaderField: "X-Auth-Token")
            UserDefaults.standard.set(token, forKey: "xAuthToken")
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
