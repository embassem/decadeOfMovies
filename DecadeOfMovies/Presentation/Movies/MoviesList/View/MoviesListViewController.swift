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

    @IBOutlet private weak var moviesTableView: UITableView!
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
        moviesTableView.dataSource = self
        moviesTableView.estimatedRowHeight = 100
        moviesTableView.rowHeight = UITableView.automaticDimension
        moviesTableView.tableFooterView = UIView(frame: .zero)
        registerCells()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    func registerCells() {
        moviesTableView.register(nibWithCellClass: MovieCell.self)
    }

    private func bind(to viewModel: MoviesListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.moviesTableView?.reloadData() }
        viewModel.error.observe(on: self) { [weak self] in self?.showError(with: $0) }
    }
}

// MARK: - Table DataSource
extension MoviesListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MovieCell.self, for: indexPath)
        let movie = viewModel.items.value[indexPath.row]
        cell.fill(with: movie)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - Table Delegate
extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath)
        viewModel.didSelectItem(at: indexPath.row)
    }
}
