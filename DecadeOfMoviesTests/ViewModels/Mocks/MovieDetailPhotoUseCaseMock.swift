//
//  MovieDetailPhotoUseCaseMock.swift
//  DecadeOfMoviesTests
//
//  Created by Bassem Abbas on 7/18/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation
@testable import DecadeOfMovies

class MovieDetailPhotoUseCaseMock: MovieDetailPhotoUseCase {
    
    func execute(name: String, page: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        let photos = (1...100).map({ Photo(id: "\($0)", absoluteURL: "https://picsum.photos/200/\(100*$0)")})
        completion(.success(photos))
    }
    
    
}
