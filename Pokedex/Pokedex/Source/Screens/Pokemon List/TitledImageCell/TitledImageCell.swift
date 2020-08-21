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
    
    var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        image = Assets.pokemonImagePlaceholder.image
        title = nil
    }

}
