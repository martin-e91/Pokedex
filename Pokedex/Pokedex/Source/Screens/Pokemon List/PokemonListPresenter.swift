//
//  PokemonListPresenter.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

protocol PokemonListPresenterProtocol {
    var screenTitle: String { get }
    var numberOfItems: Int { get }
    var itemsPerRow: CGFloat { get }
    var itemsPerColumn: CGFloat { get }
    
    /// Setups the cell at the given indexPath.
    /// - Parameters:
    ///   - cell: The cell to be configured.
    ///   - indexPath: The indexPath for the cell.
    func setup(cell: TitledImageCell, at indexPath: IndexPath)
    
    /// Asks the presenter to fetch data.
    func fetchData()
}

final class PokemonListPresenter: BasePresenter<PokemonListViewController, AppCoordinator> {
    private let pokemonProvider: PokemonProvider
    private var pokemonReferences: [PokemonReference] = []
    
    required init(with coordinator: AppCoordinator, pokemonProvider: PokemonProvider) {
        self.pokemonProvider = pokemonProvider
        super.init(with: coordinator)
    }
    
    @available(*, unavailable)
    required public init(with coordinator: Nav) {
        fatalError("init(with:) has not been implemented")
    }
    
}

extension PokemonListPresenter: PokemonListPresenterProtocol {
    var screenTitle: String { "Pokèmon List" }
    
    var numberOfItems: Int { pokemonReferences.count }
        
    var itemsPerRow: CGFloat {
        isIpad ? 3 : 1
    }
    
    var itemsPerColumn: CGFloat {
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            return isIpad ? 2 : 3
        default:
            return isIpad ? 10 : 5
        }
    }
    
    private var isIpad: Bool {
        let sizeClasses = (view.traitCollection.horizontalSizeClass, view.traitCollection.verticalSizeClass)
        
        switch sizeClasses {
        case (.regular, .regular):
            return true
        default:
            return false
        }
    }
    
    func setup(cell: TitledImageCell, at indexPath: IndexPath) {
        let index = indexPath.row
        guard index < pokemonReferences.count else { return }
        let reference = pokemonReferences[index]
        let viewModel = TitledImageCellViewModel(model: reference, provider: pokemonProvider)
        cell.bind(to: viewModel)
    }
    
    func fetchData() {
        view.showHud()
        pokemonProvider.getPokemonReferences(startingIndex: 0, resultsPerPage: 30) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view.hideHud()
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let results):
                    self.pokemonReferences = results.results
                    self.view.updateState()
                }
            }
        }
    }
    
}
