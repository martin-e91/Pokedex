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
    let weight: Int
    let types: [TypeElement]
    let locationAreaEncounters: String
    let abilities: [Ability]
    
    func convertToPokemon(with imageData: Data) -> Pokemon {
        let types = self.types.map { Pokemon.TypeElement(slot: $0.slot, name: $0.name) }
        let abilities = self.abilities.map { Pokemon.Ability(slot: $0.slot, name: $0.name) }
        return Pokemon(id: id,
                       name: name,
                       imageData: imageData,
                       weight: weight,
                       types: types,
                       locationAreaEncounters: locationAreaEncounters,
                       abilities: abilities)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, sprites, weight, types, abilities
        case locationAreaEncounters = "location_area_encounters"
    }

}

extension PokemonDetails {
    struct Sprites: Decodable {
        /// Url pointing to default front image.
        let frontDefaultUrl: String
        
        enum CodingKeys: String, CodingKey {
            case frontDefaultUrl = "front_default"
        }
    }
    
    /// A Pokemon ability.
    struct Ability: Decodable {
        
        /// This ability's name.
        var name: String { abilityResource.name }

        /// The url pointing to this ability's details.
        var url: String { abilityResource.url }
        
        /// The api resource for this ability.
        private let abilityResource: ApiResource
        
        /// Pokémon have 3 ability 'slots' which hold references to possible abilities they could have. This is the slot of this ability for the referenced pokemon
        let slot: Int
        
        enum CodingKeys: String, CodingKey {
            case slot
            case abilityResource = "ability"
        }
    }
    
    struct TypeElement: Decodable {
        /// The order the Pokémon's types are listed in.
        let slot: Int
        private let type: ApiResource
        
        var name: String { type.name }
    }
    

}
