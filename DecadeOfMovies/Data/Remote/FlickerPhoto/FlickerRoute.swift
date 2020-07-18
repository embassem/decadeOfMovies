//
//  FlickerRoute.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//
import Foundation
import Moya

enum FlickerRouteService {
    //https:api.flickr.com/services/rest/?method=flickr.photos.search &api_key={YOUR_API_KEY}&format=json&nojsoncallback= 1 &text={MOVIE_TITLE}&page= 1 &per_page= 10
    case searchPhotos(name: String, page: Int)
}

extension FlickerRouteService: TargetType {
    var baseURL: URL {
        //swiftlint:disable:next force_unwrapping
        return URL(string: "https://api.flickr.com/services/rest/")!
    }

    var path: String {
        return ""
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .searchPhotos(name: let query, page: let page):
            var params: [String: Any] = [:]
            params["method"] = "flickr.photos.search"
            params["api_key"] = Constants.flikerKey
            params["format"] = "json"
            params["nojsoncallback"] = 1
            params["text"] = query
            params["page"] = page
            params["per_page"] = 50
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
