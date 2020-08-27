//
//  UITableViewCell+Register.swift
//  Pokedex
//
//  Created by Martin Essuman on 27/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    /// Register this cell's nib to be used in the given tableView.
    /// - Parameter collectionView: The tableView registering the nib.
    static func registerNib(for tableView: UITableView) {
        tableView.register(nib, forCellReuseIdentifier: Self.reuseIdentifier)
    }
    
    /// Register this cell's class to be used in the given tableView.
    /// - Parameter collectionView: The tableView registering the class.
    static func registerClass(for tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: Self.reuseIdentifier)
    }

}

