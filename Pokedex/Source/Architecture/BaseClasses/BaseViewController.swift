//
//  BaseViewController.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

/// A concrete base implementation for a ViewController backed by a Presenter.
open class BaseViewController<P>: UIViewController, View {
    
    /// This viewcontroller's presenter
    public var presenter: P
    
    /// The hud to be shown while loading data.
    private lazy var hud = makeActivityIndicator()
    
    required public init(with presenter: P) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeActivityIndicator() -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .large)
        view.addSubview(spinner)
        spinner.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: view.topAnchor),
            spinner.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spinner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        return spinner
    }
    
    /// Shows a loading hud.
    public func showHud() {
        DispatchQueue.main.async {
            self.hud.startAnimating()
        }
    }
    
    /// Hides any hud in this viewcontroller's view hierarchy.
    public func hideHud() {
        DispatchQueue.main.async {
            let huds = self.view.subviews.compactMap { $0 as? UIActivityIndicatorView }
             huds.forEach { $0.stopAnimating() }
        }
    }
    
    /// Forces UI data update.
    open func updateState() {
        
    }
    
}

