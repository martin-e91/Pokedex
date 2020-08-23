//
//  Pokemon.swift
//  Pokedex
//
//  Created by Martin Essuman on 23/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// Represents a Pokemon.
struct Pokemon {
    let id: Int
    let name: String
    let imageData: Data
    
    init(from pokemonDetails: PokemonDetails, with imageData: Data) {
        self.id = pokemonDetails.id
        self.name = pokemonDetails.name
        self.imageData = imageData
    }
}
