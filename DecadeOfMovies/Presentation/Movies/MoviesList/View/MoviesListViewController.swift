//
//  MoviesListViewController.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit

class MoviesListViewController: BaseViewController {

    convenience init(viewModel: MoviesListViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    var coordinator: AppCoordinatorProtocol!

    private var viewModel: MoviesListViewModel!
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet private weak var moviesTableView: UITableView!

    lazy var listDataSource: MoviesDataSource = {
        return ListMoviesDataSource(viewModel: self.viewModel, tableView: self.moviesTableView)
    }()

    lazy var searchDataSource: MoviesDataSource = {
        return SearchMoviesDataSource(viewModel: self.viewModel, tableView: self.moviesTableView)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func configureUI() {

        title = viewModel.screenTitle
        moviesTableView.delegate = self
        //        moviesTableView.dataSource = self
        moviesTableView.estimatedRowHeight = 100
        moviesTableView.rowHeight = UITableView.automaticDimension
        moviesTableView.tableFooterView = UIView(frame: .zero)
        registerCells()
        bind(to: viewModel)
        viewModel.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        searchController.searchBar.delegate = self
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = true
        } else {
            moviesTableView.tableHeaderView = searchController.searchBar
            // Fallback on earlier versions
        }
        definesPresentationContext = true
    }

    func registerCells() {
        moviesTableView.register(nibWithCellClass: MovieCell.self)
    }

    private func bind(to viewModel: MoviesListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.listDataSource.reload() }
        viewModel.filteredItems.observe(on: self) { [weak self] _ in self?.searchDataSource.reload() }
        viewModel.error.observe(on: self) { [weak self] in self?.showError(with: $0) }
    }
}

// MARK: - Table Delegate
extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath)
        viewModel.didSelectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.grayscale900
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.textColor = UIColor.white
    }
}

extension MoviesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            searchController.resignFirstResponder()
            return
        }
        viewModel.didSearch(query: searchText)
    }
}

extension MoviesListViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.didCancelSearch()
    }
}

protocol MoviesDataSource {
    func reload()
}
