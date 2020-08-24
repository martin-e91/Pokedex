//
//  TItledImageCell.swift
//  Pokedex
//
//  Created by Martin Essuman on 20/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

class TitledImageCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: TitledImageCellViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = nil
        imageView.image = nil
        activityIndicator.hidesWhenStopped = true
    }
    
    override func prepareForReuse() {
        self.viewModel?.prepareForReuse()
        self.titleLabel.text = nil
        self.imageView.image = nil
    }

    private func updateData() {
        self.titleLabel.text = self.viewModel?.title
        self.imageView.image = self.viewModel?.image
    }
    
    func bind(to viewModel: TitledImageCellViewModelProtocol) {
        self.viewModel = viewModel
        
        activityIndicator.startAnimating()
        viewModel.fetchData { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.updateData()
        }
    }
}
