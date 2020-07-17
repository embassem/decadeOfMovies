//
//  SearchMoviesUseCase.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/13/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

protocol SearchMoviesUseCase {
    func execute(query: String, completion: @escaping (Result<[Movie], Error>) -> Void)
}

final class DefaultSearchMoviesUseCase: SearchMoviesUseCase {
    
    private let moviesRepository: MoviesRepository
    private var  list: [Movie] = []
    init(moviesRepository: MoviesRepository) {
        
        self.moviesRepository = moviesRepository
        prepareData()
       
    }
    
    private func prepareData() {
        return moviesRepository.fetchMoviesList { (result) in
            guard let list = result.value else { return }
            self.list = list
        }
    }
    func execute(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        let filteredList = list.filter({ ($0.title?.contains(query) ?? false) })
        
        let yearMovies = Array(Dictionary(grouping: filteredList, by: { $0.year }))
        var limitMovies: [Movie] = []
        for (_, movies) in yearMovies {
            let topMovies = movies.sorted(by: { $0.rating > $1.rating })
            limitMovies.append(contentsOf: topMovies.prefix(5))
        }
        completion(.success(limitMovies))
    }
}
