//
//  MoviePhotoCell.swift
//  DecadeOfMovies
//
//  Created by Bassem Abbas on 7/18/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit

class MoviePhotoCell: UICollectionViewCell {

    @IBOutlet private weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func prepareForReuse() {
        photoImageView.image = nil
        super.prepareForReuse()
    }
    
    func fill(with viewModel: MoviePhotoItem) {
        self.photoImageView.setImageWith(urlString: viewModel.url)
    }
    
}
