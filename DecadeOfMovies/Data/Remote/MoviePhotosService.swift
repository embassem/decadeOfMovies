//
//  MoviePhotosService.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

protocol MoviePhotosService {
    func getPhotos(movieName: String, page: Int, completion: @escaping (
        _ result: Swift.Result<FlikerAPIResponse, APIError>,
        _ statusCode: StatusCode?
        ) -> Void)
}
