//
//  PokemonReference.swift
//  Pokedex
//
//  Created by Martin Essuman on 21/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

struct PokemonReference: Decodable, Hashable {
    
    /// This pokemon's name.
    let name: String
    
    /// Url for retrieving this pokemon's details.
    let url: String
}
