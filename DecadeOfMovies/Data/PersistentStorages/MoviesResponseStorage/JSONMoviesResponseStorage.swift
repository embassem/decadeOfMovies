//
//  JSONMoviesResponseStorage.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation
final class JSONMoviesResponseStorage {

}

extension JSONMoviesResponseStorage: MoviesResponseStorage {

    func getResponse(completion: @escaping (Result<[MovieJSON], Error>) -> Void) {

        let container = Bundle.main.decode(MoviesJSON.self, from: "movies.json")
        guard let moviesList = container.movies else {
            let error = NSError(domain: "movies.",
                                code: -1,
                                userInfo: [NSLocalizedFailureReasonErrorKey: "failed to load json file"])
            completion(.failure(error))
            return
        }
        completion(.success(moviesList) )
        return
    }
}
