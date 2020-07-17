//
//  MoviesDetailsHeaderCollectionViewCell.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit
import Cosmos
class MovieDetailsHeaderCell: UICollectionViewCell {

    var viewModel: MovieItemViewModel?
    
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var ratingView: CosmosView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fill(with viewModel: MovieItemViewModel?) {
        guard let viewModel = viewModel else { return }
        self.viewModel = viewModel
        self.movieTitleLabel.text = viewModel.title
        self.yearLabel.text = "\(viewModel.year)"
        ratingView.rating = viewModel.rating        
    }
}
