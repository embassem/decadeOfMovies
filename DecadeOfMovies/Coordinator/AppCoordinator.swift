//
//  AppCoordinator.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/13/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit
import Foundation

protocol Navigators {
    var movies: MoviesNavigator { get set }
}

protocol AppCoordinatorProtocol: class, Navigators {
    func start()
    var navigationController: UINavigationController? { get set }
}

class AppCoordinator: AppCoordinatorProtocol {
    
    lazy var movies: MoviesNavigator = {
        return MoviesNavigator(coordinator: self)
    }()
    
    var navigationController: UINavigationController?
    
    private let window: UIWindow
    
    init(window: UIWindow = UIWindow(),
         navigationController: UINavigationController = AppNavigationController()) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        let closures = MoviesListViewModelClosures(showMovieDetails: showMovieDetails)
        
        let vc = movies.makeMoviesListViewController(closures: closures)

        navigationController?.setViewControllers([vc], animated: true)
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    private func showMovieDetails(movie: Movie) {
        let details = movies.makeMoviesDetailsViewController(movie: movie)
        movies.navigate(to: details, with: .push)
    }
    
}
