//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Martin Essuman on 24/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

final class PokemonDetailsViewController: BaseViewController<PokemonDetailsPresenterProtocol> {
    enum Sections: Int, CaseIterable {
        case stats = 0
        case abilities
    }
    
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
        tableView.dataSource = self
        UITableViewCell.registerClass(for: tableView)
    }
    
}

extension PokemonDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numbersOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.title(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Sections(rawValue: indexPath.section) else { return .init() }
        let cell: UITableViewCell
        
        switch section {
        case .stats:
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: UITableViewCell.reuseIdentifier)
        case .abilities:
            cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        }
        presenter.setup(cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numbersOfRows(in: section)
    }
}
