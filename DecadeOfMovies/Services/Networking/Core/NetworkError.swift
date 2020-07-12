//
//  NetworkError.swift
//  Sample MVP
//
//  Created by Bassem Abbas on 2/1/20.
//  Copyright © 2019 Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation
import Moya
import enum Alamofire.AFError

enum `Type`:String, Codable {
    case business
    case system
    case mapping
}

struct APIError: Codable, Error, LocalizedError {

    //enum (busineess , system , mapping) will know from moya error by (type / status code)
    var code: Int?
    var key: String?
    var message: String?
    var type: Type?
    var fields: [String: String]?

    var underling: Error?
    //    var userInfo: [String: Any] = [:]

    private init() {}
    init (message: String?) {
        self.message = message
    }

    init(error: MoyaError) {

        self.message = error.errorDescription

        if case let MoyaError.underlying(underlying, _) = error ,
            case let AFError.sessionTaskFailed(error: urlErrorDomain) = underlying {
            self.message = urlErrorDomain.localizedDescription
            self.code = (urlErrorDomain as NSError).code
        }

        // handel no inernet error message and session expire
        switch error {
        case .underlying(let error, _):
            self.type = .system
            print(error)
        default :
            self.type = .mapping
        }
    }
    enum CodingKeys: String, CodingKey {
        case key = "code"
        case code = "key"
        case fields = "fields"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        key = try values.decodeIfPresent(String.self, forKey: .key)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        fields = try values.decodeIfPresent([String: String].self, forKey: .fields)
    }

    func innerErrorMessage() -> ( title: String?, message: String? ) {
        let title = self.message
        if let fields = fields {

            let message = Array(fields.values).map({ "- \($0)\n" }).joined(separator: "")
            return (title, message)
        }
        return (title, nil)
    }

    var errorDescription: String? {
        if self.code == 422 {
            return innerErrorMessage().message
        }
        return self.message
    }
}

extension APIError {

    static let invalidApiKey: APIError = {
        var error = APIError()
        error.type = Type.system
        error.code = -1
        error.message = NSLocalizedString("Server is Not available", comment: "Invalid Api Key")
        return error
    }()

    static let sessionExpired: APIError = {
        var error = APIError()
        error.type = Type.system
        error.code = -2
        error.message = NSLocalizedString("Session Expired", comment: "Authintication Expired")
        return error
    }()

    static let parseError: APIError = {
        var error = APIError()
        error.type = Type.mapping
        return error
    }()

    static let genaricError: APIError = {
        var error = APIError()
        error.type = Type.business
        return error
    }()
}
