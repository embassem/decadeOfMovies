//
//  ListMoviesDataSource.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit

class ListMoviesDataSource: NSObject, UITableViewDataSource, MoviesDataSource {
    
    private var datasourceTableView: UITableView!
    private var viewModel: MoviesListViewModel!
    private override init() {}
    
    init(viewModel: MoviesListViewModel, tableView: UITableView) {
        super.init()
        self.viewModel = viewModel
        self.datasourceTableView = tableView
    }
    
    func reload() {
        datasourceTableView.dataSource = self
        datasourceTableView.reloadData()
    }
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
}
