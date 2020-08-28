//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

class PokemonListViewController: BaseViewController<PokemonListPresenterProtocol> {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var emptyDataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = presenter.screenTitle
        setupCollectionView()
        setupEmptyDataLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchData()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        TitledImageCell.registerNib(for: collectionView)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didDragDownCollectionView), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc
    private func didDragDownCollectionView() {
        presenter.fetchData()
        collectionView.refreshControl?.endRefreshing()
    }
    
    private func setupEmptyDataLabel() {
        emptyDataLabel.isHidden = presenter.numberOfItems > 0
        emptyDataLabel.text = Strings.emptyDataMessage.localized
    }
    
    override func updateState() {
        collectionView.reloadData()
        setupEmptyDataLabel()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
}

extension PokemonListViewController: UICollectionViewDelegateFlowLayout {
    
    private var spacing: CGFloat { Constants.mediumSpacing }
    private var insets: UIEdgeInsets { .init(top: spacing, left: spacing, bottom: spacing, right: spacing) }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let _ = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        
        let horizontalSpacing = (spacing * CGFloat(presenter.itemsPerRow - 1))
        let horizontalSpace = collectionView.bounds.width - horizontalSpacing - (insets.left + insets.right)
        let itemWidth = horizontalSpace / presenter.itemsPerRow
        
        let verticalSpace = collectionView.bounds.height - (spacing * 2) - (insets.top + insets.bottom)
        let itemHeight = verticalSpace / presenter.itemsPerColumn
        
        return .init(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectCell(at: indexPath)
    }
}

extension PokemonListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitledImageCell.reuseIdentifier, for: indexPath) as? TitledImageCell else {
            return .init()
        }
        presenter.setup(cell: cell, at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.willDisplayCell(at: indexPath)
    }
}

