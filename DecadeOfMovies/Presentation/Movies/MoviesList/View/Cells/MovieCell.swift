//
//  MovieCell.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit
import Cosmos

class MovieCell: UITableViewCell {

    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        reset()
        super.prepareForReuse()
    }

    func reset() {
        movieImageView.stopShimmering()
    }

    func fill(with model: MoviesListItemViewModel) {
        self.movieTitleLabel.text = model.title
        self.yearLabel.text = (model.year != nil) ? "\(String(describing: model.year))" : ""
        self.ratingView.rating = model.rating
        self.movieImageView.startShimmering()
    }
}
