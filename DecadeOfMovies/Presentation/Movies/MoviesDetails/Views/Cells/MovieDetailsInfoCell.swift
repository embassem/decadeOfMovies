//
//  MovieDetailsInfoCell.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit

class MovieDetailsInfoCell: UICollectionViewCell {

    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var castLabel: UILabel!
    
    var viewModel: MovieItemViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fill(with viewModel: MovieItemViewModel?) {
        guard let viewModel = viewModel else { return }
        self.viewModel = viewModel
        self.genresLabel.text = viewModel.genres
        self.castLabel.text = viewModel.cast
    }
}
