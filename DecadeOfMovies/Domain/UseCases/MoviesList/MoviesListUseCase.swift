//
//  MoviesListUseCase.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

protocol MoviesListUseCase {
    func execute( completion: @escaping (Result<[Movie], Error>) -> Void)
}

final class DefaultMoviesListUseCase: MoviesListUseCase {

    private let moviesRepository: MoviesRepository

    init(moviesRepository: MoviesRepository) {

        self.moviesRepository = moviesRepository
    }

    func execute( completion: @escaping (Result<[Movie], Error>) -> Void) {

        return moviesRepository.fetchMoviesList { (result) in
            if case .success = result {

            }
            completion(result)
        }
    }
}
