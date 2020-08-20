//
//  Assets.swift
//  Pokedex
//
//  Created by Martin Essuman on 20/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

enum Assets: String {
    var image: UIImage? {
        return UIImage(named: rawValue)
    }
    
    case pokemonImagePlaceholder = "pokemon-placeholder"
}
