//
//  NetworkManager.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation
import Moya

typealias MoyaCompletion = (Result<Moya.Response, MoyaError>)
typealias NetworkComplation<T: Codable> = (
    _ result: Swift.Result<T, APIError>,
    _ statusCode: StatusCode?) -> Void

/// Closure to be executed when a request has completed.
typealias StatusCode = Int

class NetworkManager {

    static let shared: NetworkManager = { NetworkManager(config: .defaults) }()

    var networkConfig: NetworkDefaults!

    let provider: MoyaProvider<MultiTarget>

    init(config: NetworkDefaults = NetworkDefaults.defaults) {
        self.networkConfig = config

        let headerPlugin = StaticHeaderPlugin(
            headers: [
                "Accept-Language": "en"
        ])

        provider = MoyaProvider<MultiTarget>(//manager: ,
            plugins: [headerPlugin, NetworkLoggerPlugin(), AccessTokenPlugin(tokenClosure: { (_) -> String in
                //TODO: replace with actual token
                return "TOKEN"
            })])
    }

    func parseResponse<T: Codable>(moyaResult: MoyaCompletion, completion: @escaping NetworkComplation<T> ) {

        switch moyaResult {
        case .success(let response):
            do {
                let json = try JSONDecoder().decode(T.self, from: response.data)
                if 200...299 ~= response.statusCode {
                    completion(.success(json), response.statusCode)
                } else {
                    // 300-399 ,400-499
                    var error = APIError(message: "Something went wrong")
                    error.type = .business
                    completion(.failure(error), response.statusCode)
                }
            } catch {
                switch response.statusCode {
                case 401://
                    completion(.failure(APIError.sessionExpired), response.statusCode)
                case 403: // Invalid Api Key
                    completion(.failure(APIError.invalidApiKey), response.statusCode)
                default:
                    var error = APIError.parseError
                    error.message = "Unknown"
                    completion(.failure(error), response.statusCode)
                }

            }

        case .failure(let error):
            let customError = APIError(error: error)
            completion(.failure(customError), nil)
        }
    }
}
