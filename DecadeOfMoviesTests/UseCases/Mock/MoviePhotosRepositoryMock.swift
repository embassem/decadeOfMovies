//
//  MoviePhotosRepositoryMock.swift
//  DecadeOfMoviesTests
//
//  Created by Bassem Abbas on 7/18/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation
@testable import DecadeOfMovies

class MoviePhotosRepositoryMock: MoviePhotosRepository {

    func fetchMoviePhotos(text: String, page: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        completion(.success(Photo.stubs()))
    }
}
