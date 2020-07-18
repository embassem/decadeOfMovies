//
//  MovieItemViewModel.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

struct MovieItemViewModel {
    var title: String
    var year: Int
    var cast: String
    var genres: String
    var rating: Double
}

extension MovieItemViewModel {
    
    init(movie: Movie) {
        self.title = movie.title ?? ""
        self.year = movie.year
        self.cast = (movie.cast ?? []).joined(separator: " ")
        self.genres = (movie.genres ?? []).joined(separator: " ")
        self.rating = Double(movie.rating ?? 0)
    }
}
