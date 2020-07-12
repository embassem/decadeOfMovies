//
//  MoviesListItemViewModel.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

struct MoviesListItemViewModel: Equatable {
    
    let title: String
    let year: Int
    let rating: Double
}

extension MoviesListItemViewModel {
    
    init(movie: Movie) {
        self.title = movie.title ?? ""
        self.year = movie.year ?? 0
        self.rating = Double(movie.rating ?? 0)
    }
}
