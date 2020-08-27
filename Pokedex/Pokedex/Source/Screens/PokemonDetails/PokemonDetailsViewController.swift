//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Martin Essuman on 24/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

final class PokemonDetailsViewController: BaseViewController<PokemonDetailsPresenterProtocol> {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typesStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = presenter.screenTitle
        imageView.image = presenter.image
        nameLabel.text = presenter.name
        setupTypesStack()
    }
    
    private func setupTypesStack() {
        for type in presenter.types {
            let label = UILabel()
            label.text = type.capitalized
            typesStack.addArrangedSubview(label)
        }
    }
    
}
