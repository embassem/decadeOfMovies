//
//  Flicker+Network.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation
import Moya

extension NetworkManager: MoviePhotosService {

    func getPhotos(movieName: String, page: Int, completion: @escaping (
        _ result: Swift.Result<FlikerAPIResponse, APIError>,
        _ statusCode: StatusCode?
        ) -> Void) {

        provider.request(MultiTarget(FlickerRouteService.searchPhotos(name: movieName, page: page))) { (result) in
            self.parseResponse(moyaResult: result, completion: completion)
        }

    }
}
