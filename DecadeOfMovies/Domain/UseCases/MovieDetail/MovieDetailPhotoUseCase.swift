//
//  MovieDetailPhotoUseCase.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

protocol MovieDetailPhotoUseCase {
    func execute(name: String, page: Int, completion: @escaping (Result<[Photo], Error>) -> Void)
}

final class DefaultMovieDetailPhotoUseCase: MovieDetailPhotoUseCase {
    
    private let photosRepository: MoviePhotosRepository
    
    init(photosRepository: MoviePhotosRepository) {
        
        self.photosRepository = photosRepository
    }
    
    func execute(name: String, page: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        
        return photosRepository.fetchMoviePhotos(text: name, page: page) { (result) in
            completion(result)
        }
    }
}
