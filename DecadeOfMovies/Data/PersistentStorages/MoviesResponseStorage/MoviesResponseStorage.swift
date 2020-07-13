//
//  MoviesJSONResponseStorage.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

protocol MoviesResponseStorage {
    func getResponse(completion: @escaping (Result<[MovieJSON], Error>) -> Void)
}
