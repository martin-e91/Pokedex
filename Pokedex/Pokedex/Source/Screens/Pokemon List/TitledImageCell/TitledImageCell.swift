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
    
    private var viewModel: TitledImageCellViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        self.viewModel?.prepareForReuse()
    }

    func bind(to viewModel: TitledImageCellViewModelProtocol) {
        self.viewModel = viewModel
    }
}
