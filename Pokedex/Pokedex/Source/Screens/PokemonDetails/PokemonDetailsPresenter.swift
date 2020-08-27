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
    var numbersOfSections: Int { get }
    
    /// Returns the title for the given section.
    /// - Parameter section: The index of the section.
    func title(for section: Int) -> String?
    
    /// Returns the number of rows for the given section.
    /// - Parameter section: The index of the section.
    func numbersOfRows(in section: Int) -> Int
    
    /// Configures the given cell
    /// - Parameter cell: The cell to be configured.
    func setup(_ cell: UITableViewCell, at indexPath: IndexPath)
}

final class PokemonDetailsPresenter: BasePresenter<PokemonDetailsViewController, AppCoordinator> {
    private typealias Sections = PokemonDetailsViewController.Sections
    
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
    
    var numbersOfSections: Int { Sections.allCases.count }
    
    func numbersOfRows(in section: Int) -> Int {
        guard let section = Sections(rawValue: section) else { return 0 }
        switch section {
        case .stats:
            return pokemon.stats.count
        case .abilities:
            return pokemon.abilities.count
        }
    }
    
    func title(for section: Int) -> String? {
        guard let section = Sections(rawValue: section) else { return nil }
        return section.name
    }
    
    func setup(_ cell: UITableViewCell, at indexPath: IndexPath) {
        guard let section = Sections(rawValue: indexPath.section) else { return }
        let index = indexPath.row
        let text: String
        let detail: String?
        
        switch section {
        case .stats:
            guard index < pokemon.stats.count else { return }
            let stat = pokemon.stats[index]
            text = stat.name
            detail = String(stat.baseStat)
        case .abilities:
            guard index < pokemon.abilities.count else { return }
            let ability = pokemon.abilities[index]
            text = ability.name
            detail = nil
        }
        
        cell.textLabel?.text = text.capitalized
        cell.detailTextLabel?.text = detail?.capitalized
    }
}

extension PokemonDetailsViewController.Sections: Nameable {
    var name: String {
        switch self {
        case .stats:
            return Strings.stats.localized
        case .abilities:
            return Strings.abilities.localized
        }
    }
}
