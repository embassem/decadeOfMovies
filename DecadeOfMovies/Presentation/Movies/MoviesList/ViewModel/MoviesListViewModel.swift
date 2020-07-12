//
//  MoviesListViewModel.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation

struct MoviesListViewModelClosures {
    // Note: if you would need to edit movie inside Details screen and update this Movies List screen with updated movie then you would need this closure:
    //  showMovieDetails: (Movie, @escaping (_ updated: Movie) -> Void) -> Void
    let showMovieDetails: (Movie) -> Void
    let closeMovieSearch: () -> Void
}

protocol MoviesListViewModelInput {
    func viewDidLoad()
    func didSearch(query: String)
    func didCancelSearch()
    func didSelectItem(at index: Int)
}

protocol MoviesListViewModelOutput {
    var items: Observable<[MoviesListItemViewModel]> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
    var searchBarPlaceholder: String { get }
}

protocol MoviesListViewModel: MoviesListViewModelInput, MoviesListViewModelOutput {}

final class DefaultMoviesListViewModel: MoviesListViewModel {
    
    private let closures: MoviesListViewModelClosures?
    
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }
    
    private var movies: [Movie] = [] {
        didSet {
            items.value = movies.map(MoviesListItemViewModel.init)
        }
    }
//    private var moviesLoadTask: Cancellable? { willSet { moviesLoadTask?.cancel() } }
    
    // MARK: - OUTPUT
    
    let items: Observable<[MoviesListItemViewModel]> = Observable([])
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Movies", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search Movies", comment: "")
    
    // MARK: - Init
    
    init(closures: MoviesListViewModelClosures? = nil) {
        self.closures = closures
    }
    
    // MARK: - Private
    
    private func appendPage(_ moviesPage: Movies) {
        movies.append(contentsOf: moviesPage.movies ?? [])
    }

    private func resetPages() {
        currentPage = 0
        totalPageCount = 1
//        pages.removeAll()
        items.value.removeAll()
    }
    
    private func load(movieQuery: String) {
      //TODO: Implement Search in Place
    }
    
    private func load() {
        let container = Bundle.main.decode(Movies.self, from: "movies.json")
        movies = container.movies ?? []
    }
    private func handle(error: Error) {
        self.error.value = error.localizedDescription
    }
    
    private func update(movieQuery: String) {
        resetPages()
        load(movieQuery: movieQuery)
    }
}

// MARK: - INPUT. View event methods

extension DefaultMoviesListViewModel {
    
    func viewDidLoad() {
        load()
    }
        
    func didSearch(query: String) {
        guard !query.isEmpty else { return }
        update(movieQuery: query)
    }
    
    func didCancelSearch() {
        items.value.removeAll()
        load()
    }
    
    func didSelectItem(at index: Int) {
        closures?.showMovieDetails(movies[index])
    }
}
