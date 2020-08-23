//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Martin Essuman on 23/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

struct PokemonDetails: Decodable {
    let id: Int
    let name: String
    let sprites: Sprites
}

extension PokemonDetails {
    struct Sprites: Decodable {
        let frontDefaultUrl: String
        
        enum CodingKeys: String, CodingKey {
            case frontDefaultUrl = "front_default"
        }
    }
}
