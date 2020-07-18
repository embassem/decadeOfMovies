//
//  DefaultMovieDetailsRepository.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

final class DefaultMovieDetailsRepository {
    
    private let remote: MoviePhotosService
    
    init(remote: MoviePhotosService) {
        self.remote = remote
    }
}

extension DefaultMovieDetailsRepository: MoviePhotosRepository {
    
    func fetchMoviePhotos(text: String, page: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        remote.getPhotos(movieName: text, page: page) { (result, _) in
            
            switch result {
                case .success(let responseDTO):
                    completion(.success(responseDTO.photos?.photos?.compactMap({ Photo(fliker: $0) }) ?? [] ))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
//
//    func fetchMoviesList(completion: @escaping (Result<[Movie], Error>) -> Void) {
//        local.getResponse { (result) in
//            switch result {
//                case .success(let responseDTO):
//                    completion(.success(responseDTO.map({ $0.toMovie() })))
//                case .failure(let error):
//                    completion(.failure(error))
//            }
//        }
//    }
}
