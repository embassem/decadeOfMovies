//
//  Services.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation
import Moya

enum Services {
    case getOffers
    case getOfferDetails(id: Int)
}

extension Services: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        //swiftlint:disable:next force_unwrapping
        return URL(string: NetworkManager.shared.networkConfig.baseUrl)!
    }

    var path: String {
        switch self {
        case .getOffers:
            return "/luckytest/api/offers"

        case .getOfferDetails(id: let id):
            return "luckytest/api/offers/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        default: return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getOffers:
            return .requestPlain
        case .getOfferDetails:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return nil
    }

    var authorizationType: AuthorizationType? {
        switch self {
        default:
            return .none
        }
    }
}
