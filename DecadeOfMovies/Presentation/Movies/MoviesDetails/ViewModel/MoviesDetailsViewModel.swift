//
//  MoviesDetailsViewModel.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

protocol MoviesDetailsViewModelOutput {
    
    func numberOfRows(for section: Int) -> Int
    var numberOfSections: Int { get }
    
}

protocol MoviesDetailsViewModel: MoviesDetailsViewModelOutput {}

class DefaultMoviesDetailsViewModel: MoviesDetailsViewModel {
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRows(for section: Int) -> Int {
        switch section {
            case 0 : return 1
            default: return 0
        }
    }
}
