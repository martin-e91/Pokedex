//
//  Assets.swift
//  Pokedex
//
//  Created by Martin Essuman on 20/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

enum Assets: String {
    var image: UIImage {
        guard let image = UIImage(named: rawValue) else {
            print("Couldn't find image named \(rawValue). Using empty image instead.")
            return UIImage()
        }
        return image
    }
    
    case pokemonImagePlaceholder = "pokemon-placeholder"
}
