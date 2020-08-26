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
    let weight: Int
    let types: [TypeElement]
    let locationAreaEncounters: String
    let abilities: [Ability]
}

extension Pokemon {
    struct TypeElement: Decodable {
        /// The order the Pokémon's types are listed in.
        let slot: Int
        let name: String
    }
    
    struct Ability {
        let slot: Int
        let name: String
    }
}
