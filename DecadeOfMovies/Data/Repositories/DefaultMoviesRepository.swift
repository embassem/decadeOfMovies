//
//  DefaultMoviesRepository.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

final class DefaultMoviesRepository {

    private let local: MoviesResponseStorage

    init(local: MoviesResponseStorage) {
        self.local = local
    }
}

extension DefaultMoviesRepository: MoviesRepository {

    func fetchMoviesList(completion: @escaping (Result<[Movie], Error>) -> Void) {
        local.getResponse { (result) in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.map({ $0.toMovie() })))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
