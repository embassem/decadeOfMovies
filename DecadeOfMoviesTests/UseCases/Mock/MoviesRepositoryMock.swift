//
//  MoviesRepositoryMock.swift
//  DecadeOfMoviesTests
//
//  Created by Bassem Abbas on 7/18/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation
@testable import DecadeOfMovies

class MoviesRepositoryMock: MoviesRepository {

    func fetchMoviesList(completion: @escaping (Result<[Movie], Error>) -> Void) {
        completion(.success(Movie.stubs()))
    }
}
