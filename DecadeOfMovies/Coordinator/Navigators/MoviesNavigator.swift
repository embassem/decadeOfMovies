//
//  MoviesNavigator.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/13/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation
import UIKit

class MoviesNavigator: Navigator {
    var coordinator: AppCoordinatorProtocol
    
    required init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    enum Destination {
        case list
    }

    func makeMoviesListViewController(closures: MoviesListViewModelClosures) -> MoviesListViewController {
        let localStorage = JSONMoviesResponseStorage()
        let repository = DefaultMoviesRepository(local: localStorage)
        let listUseCase = DefaultMoviesListUseCase(moviesRepository: repository)
        let searchUsercase = DefaultSearchMoviesUseCase(moviesRepository: repository)
        let viewModel = DefaultMoviesListViewModel(
            moviesListUseCase: listUseCase,
            searchMoviesUseCase: searchUsercase,
            closures: closures)
        let view = MoviesListViewController(viewModel: viewModel)
        view.coordinator = coordinator
        return view
    }
    
    func makeMoviesDetailsViewController(movie: Movie) -> MoviesDetailsViewController {
//        let localStorage = JSONMoviesResponseStorage()
//        let repository = DefaultMoviesRepository(local: localStorage)
//        let listUseCase = DefaultMoviesListUseCase(moviesRepository: repository)
//        let searchUsercase = DefaultSearchMoviesUseCase(moviesRepository: repository)
        let viewModel = DefaultMoviesDetailsViewModel(movie: movie)
        let view = MoviesDetailsViewController(viewModel)
        return view
    }
}
