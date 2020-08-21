//
//  NibLoadable.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

/// An object that can be loaded from a xib file.
public protocol NibLoadable: UIView {
    /// Returns a nib instance which is built based on the class name.
    static var nib: UINib { get }
    
    /// Returns the class name intended as name for the nib file.
    static var nibName: String { get }
}

extension UIView: NibLoadable {
    public static var nibName: String {
        return String(describing: self)
    }
    
    public var nibName: String { Self.nibName }
    
    public static var bundle: Bundle {
        return Bundle(for: self)
    }
    
    public var bundle: Bundle { Self.bundle }
    
    public static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
    
    func loadFromNib<T: UIView>() -> T {
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Error loading nib with name \(nibName)")
        }
        
        return view
    }
}
