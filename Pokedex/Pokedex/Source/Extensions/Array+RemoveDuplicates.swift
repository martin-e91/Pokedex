//
//  Array+RemoveDuplicates.swift
//  Pokedex
//
//  Created by Martin Essuman on 23/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    mutating func removeDuplicates() {
        let set = NSOrderedSet(array: self)
        guard let array = set.array as? [Element] else {
            fatalError("Unexpected behavior")
        }
        self = array
    }
}
