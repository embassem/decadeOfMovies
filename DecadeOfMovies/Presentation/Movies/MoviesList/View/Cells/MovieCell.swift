//
//  MovieCell.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/12/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieDetailsLabel: UILabel!

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

    }

    func fill(with model: MoviesListItemViewModel) {
        self.movieTitleLabel.text = model.title
        self.movieDetailsLabel.text = (model.year != nil) ? "\(String(describing: model.year))" : ""
    }
}
