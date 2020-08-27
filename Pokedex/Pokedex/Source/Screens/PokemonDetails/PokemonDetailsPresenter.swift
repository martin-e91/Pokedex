//
//  PokemonDetailsPresenter.swift
//  Pokedex
//
//  Created by Martin Essuman on 24/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

protocol PokemonDetailsPresenterProtocol {
    typealias Field = (label: String, value: String)
    
    var screenTitle: String { get }
    var image: UIImage { get }
    var name: String { get }
    var weight: Field { get }
    var typesLabel: String { get }
    var types: [String] { get }
}

final class PokemonDetailsPresenter: BasePresenter<PokemonDetailsViewController, AppCoordinator> {
    private let pokemon: Pokemon
    
    required init(with coordinator: AppCoordinator, pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(with: coordinator)
    }
    
    @available(*, unavailable)
    required public init(with coordinator: Nav) {
        fatalError("init(with:) has not been implemented")
    }
}

extension PokemonDetailsPresenter: PokemonDetailsPresenterProtocol {
    var screenTitle: String { pokemon.name.capitalized }
    
    var image: UIImage {
        guard let image = UIImage(data: pokemon.imageData) else { return Assets.pokemonImagePlaceholder.image }
        return image
    }
    
    var name: String { pokemon.name.capitalized }
    
    var weight: Field {
        let measurement = Measurement(value: pokemon.weight / 10, unit: UnitMass.kilograms)
        let value = MeasurementFormatter().string(from: measurement)
        return (label: Strings.weightLabel.localized, value: value)
    }
    
    var typesLabel: String { Strings.typesLabel.localized }
    var types: [String] { pokemon.types.map(\.name) }
}
