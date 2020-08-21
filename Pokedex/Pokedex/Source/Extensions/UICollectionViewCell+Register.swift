//
//  UICollectionViewCell.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

public extension UICollectionViewCell {
    
    /// Register this cell's nib to be used in the given collectionview.
    /// - Parameter collectionView: The collectionview registering the nib.
    static func registerNib(for collectionView: UICollectionView) {
        collectionView.register(nib, forCellWithReuseIdentifier: Self.reuseIdentifier)
    }
    
    /// Register this cell's class to be used in the given collectionview.
    /// - Parameter collectionView: The collectionview registering the class.
    static func registerClass(for collectionView: UICollectionView) {
        collectionView.register(Self.self, forCellWithReuseIdentifier: Self.reuseIdentifier)
    }

}
