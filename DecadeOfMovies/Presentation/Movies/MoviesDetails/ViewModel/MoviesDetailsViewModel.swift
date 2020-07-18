//
//  MoviesDetailsViewModel.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

protocol MoviesDetailsViewModelOutput {
    
    var numberOfSections: Int { get }
    var state: Observable <DetailsState> { get }
    var error: Observable<String> { get }
    
    func numberOfRows(for section: Int) -> Int
    func item(for indexPath: IndexPath) -> MovieItemViewModel?
    func photoItem(for indexPath: IndexPath) -> MoviePhotoItem
}

protocol MoviesDetailsViewModel: MoviesDetailsViewModelOutput {}

enum DetailsState {
    case intial
    case minimum
    case full(photos: Bool)
}

class DefaultMoviesDetailsViewModel: MoviesDetailsViewModel {
    
    var movie: MovieItemViewModel
    var state: Observable<DetailsState> = Observable(.intial)
    var error: Observable<String> = Observable("")
    var photosUseCase: MovieDetailPhotoUseCase
    var page: Int = 1
    var moviePhotos: [MoviePhotoItem] = []
    
    init(movie: Movie, photosUseCase: MovieDetailPhotoUseCase) {
        self.movie = MovieItemViewModel(movie: movie)
        self.photosUseCase = photosUseCase
        state.value = .minimum
        fetchPhotos()
    }
    
    var numberOfSections: Int {
        switch state.value {
            case .intial : return 0
            case .minimum : return 1
            case .full : return  moviePhotos.isEmpty ? 1 : 2
        }
    }
    
    func numberOfRows(for section: Int) -> Int {
        switch section {
            case 0 : return 2
            case 1: return moviePhotos.count
            default: return 0
        }
    }
    
    func item(for indexPath: IndexPath) -> MovieItemViewModel? {
        return movie
    }
    
    func photoItem(for indexPath: IndexPath) -> MoviePhotoItem {
        let photo = moviePhotos[indexPath.item]
        return photo
    }
    
    func fetchPhotos() {
        photosUseCase.execute(
            name: self.movie.title,
            page: self.page,
            completion: {result in
                switch result {
                    case .success(let photos):
                        self.moviePhotos.append(contentsOf: photos.map({ MoviePhotoItem(url: $0.absoluteURL) }))
                        self.state.value = .full(photos: true)
                    case .failure(let error):
                        self.error.value = error.localizedDescription
                        self.state.value = .full(photos: false)
                }
        })
    }
}
