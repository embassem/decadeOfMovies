//
//  MoviePhotosRepository.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

protocol MoviePhotosRepository {
    func fetchMoviePhotos(text: String, page: Int, completion: @escaping (Result<[Photo], Error>) -> Void)
}
