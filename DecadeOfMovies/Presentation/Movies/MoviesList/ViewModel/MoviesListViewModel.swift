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
    var filteredItems: Observable<[[MoviesListItemViewModel]]> { get }
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

    enum State {
        case listing
        case searching(text: String)
    }
    private let closures: MoviesListViewModelClosures?
    private let moviesListUseCase: MoviesListUseCase
    private let searchMoviesUseCase: SearchMoviesUseCase
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }

    private var movies: [Movie] = [] {
        didSet {
            items.value = movies.map(MoviesListItemViewModel.init)
        }
    }

    private var filteredMovies: [Movie] = [] {
        didSet {
            let newMovies = filteredMovies.map(MoviesListItemViewModel.init)
            let groupingData = Dictionary(grouping: newMovies, by: { $0.year })
            filteredItems.value = Array(groupingData.values.map { $0 })
        }
    }

    var state: State = .listing
    //    private var moviesLoadTask: Cancellable? { willSet { moviesLoadTask?.cancel() } }

    // MARK: - OUTPUT

    let items: Observable<[MoviesListItemViewModel]> = Observable([])
    let filteredItems: Observable<[[MoviesListItemViewModel]]> =
        Observable([[MoviesListItemViewModel]]())
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Movies", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search Movies", comment: "")

    // MARK: - Init

    init(moviesListUseCase: MoviesListUseCase,
         searchMoviesUseCase: SearchMoviesUseCase,
         closures: MoviesListViewModelClosures? = nil) {
        self.closures = closures
        self.moviesListUseCase = moviesListUseCase
        self.searchMoviesUseCase = searchMoviesUseCase
    }

    // MARK: - Private

    private func appendPage(_ movies: [Movie]?) {
        self.movies.append(contentsOf: movies ?? [])
    }

    private func appendFilteredPage(_ movies: [Movie]?) {
        self.filteredMovies = (movies ?? [])
    }
    private func resetPages() {
        currentPage = 0
        totalPageCount = 1
        //        pages.removeAll()
        items.value.removeAll()
    }

    private func load(movieQuery: String) {
        searchMoviesUseCase.execute(
            query: movieQuery,
            completion: { result in
                switch result {
                case .success(let page):
                    self.appendFilteredPage(page)
                case .failure(let error):
                    self.handle(error: error)
                }
        })
    }

    private func load() {
        moviesListUseCase.execute { (result) in
            switch result {
            case .success(let page):
                self.appendPage(page)
            case .failure(let error):
                self.handle(error: error)
            }
        }
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
        state = .searching(text: query)
        update(movieQuery: query)
    }

    func didCancelSearch() {
        state = .listing
        items.value.removeAll()
        load()
    }

    func didSelectItem(at index: Int) {
        closures?.showMovieDetails(movies[index])
    }
}
