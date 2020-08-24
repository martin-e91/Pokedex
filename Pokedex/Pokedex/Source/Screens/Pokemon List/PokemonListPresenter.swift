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
    
    func willDisplayCell(at indexPath: IndexPath)
    
    /// Asks the presenter to fetch data starting from the given index.
    /// - Parameter startingIndex: starting position of the data to be fetched.
    func fetchData(from startingIndex: Int)
}

final class PokemonListPresenter: BasePresenter<PokemonListViewController, AppCoordinator> {
    private let pokemonProvider: PokemonProvider
    private let cache = Cache<Int, PokemonReference>()
    private var pokemonReferences: [PokemonReference] = []
    private var lastResults: PaginatedResult<PokemonReference> = .init(count: 0, next: nil, previous: nil, results: []) {
        didSet {
            pokemonReferences.append(contentsOf: lastResults.results)
            pokemonReferences.removeDuplicates()
            for (index, reference) in pokemonReferences.enumerated() {
                cache.insert(reference, forKey: index)
            }
        }
    }
    
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
    var screenTitle: String { Strings.pokemonListTitle.localized }
    
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
        
        let reference: PokemonReference
        if let cached = cache.value(forKey: index) {
            reference = cached
        } else {
            reference = pokemonReferences[index]
        }
        
        let viewModel = TitledImageCellViewModel(model: reference, provider: pokemonProvider)
        cell.bind(to: viewModel)
    }
    
    func willDisplayCell(at indexPath: IndexPath) {
        guard indexPath.row == (numberOfItems - 5),
            numberOfItems < lastResults.count else { return }
        fetchData(from: indexPath.row)
    }
    
    func fetchData(from startingIndex: Int) {
        view.showHud()
        pokemonProvider.getPokemonReferences(startingIndex: startingIndex, resultsPerPage: 30) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view.hideHud()
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let results):
                    DispatchQueue.main.async {
                        self.lastResults = results
                        self.view.updateState()
                    }
                }
            }
        }
    }
    
}
