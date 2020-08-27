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
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var weightValueLabel: UILabel!
    @IBOutlet private weak var typesLabel: UILabel!
    @IBOutlet private weak var typesStack: UIStackView!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = presenter.screenTitle
        imageView.image = presenter.image
        nameLabel.text = presenter.name
        setupTypesDetails()
        setupWeightLabel()
        setupTableView()
    }
    
    private func setupWeightLabel() {
        let weightRepresentation = presenter.weight
        weightLabel.text = weightRepresentation.label
        weightValueLabel.text = weightRepresentation.value
    }
    
    private func setupTypesDetails() {
        typesLabel.text = presenter.typesLabel
        for type in presenter.types {
            let label = UILabel()
            label.text = type.capitalized
            label.textAlignment = .left
            typesStack.addArrangedSubview(label)
        }
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
    }
    
}
