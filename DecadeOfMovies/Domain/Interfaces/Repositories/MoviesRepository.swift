//
//  MoviesRepository.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

protocol MoviesRepository {
    func fetchMoviesList( completion: @escaping (Result<[Movie], Error>) -> Void)
}
