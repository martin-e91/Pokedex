//
//  BaseView.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

/// A UI element.
open class BaseView: UIView {
    
    /// The bottom-most view
    @objc open var nibView = UIView()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    private func initialSetup() {
        self.nibView = loadFromNib()
        self.addSubview(self.nibView)
        self.backgroundColor = .clear
        nibView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([nibView.topAnchor.constraint(equalTo: topAnchor),
                                     nibView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     nibView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     nibView.bottomAnchor.constraint(equalTo: bottomAnchor)])
        
        setup()
    }
    
    /// Setups this view after its initialization.
    open func setup() {
        
    }
}
