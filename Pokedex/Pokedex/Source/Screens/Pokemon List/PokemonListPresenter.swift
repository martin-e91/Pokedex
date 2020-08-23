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
}

final class PokemonListPresenter: BasePresenter<PokemonListViewController, AppCoordinator> {
    private let pokemonProvider: PokemonProvider
    
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
    
    var numberOfItems: Int { 10 }
        
    var itemsPerRow: CGFloat {
        isIpad ? 3 : 1
    }
    
    var itemsPerColumn: CGFloat {
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            return isIpad ? 2 : 1
        default:
            return isIpad ? 5 : 3
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
}
