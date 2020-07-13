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
    
    func viewController(for destination: MoviesNavigator.Destination) -> UIViewController {
        switch destination {
            case .list:
                let localStorage = JSONMoviesResponseStorage()
                let repository =  DefaultMoviesRepository(local:localStorage)
                let useCase =  DefaultMoviesListUseCase(moviesRepository: repository)
                let viewModel = DefaultMoviesListViewModel(moviesListUseCase: useCase)
                
                let view = MoviesListViewController(viewModel: viewModel)
                view.coordinator = coordinator
                return view
        }
    }
    
}
