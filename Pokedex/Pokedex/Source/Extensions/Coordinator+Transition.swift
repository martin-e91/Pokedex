//
//  Coordinator+Transition.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

public enum Transition {
    public typealias PresentationBlock = (_ presentedViewController: UIViewController) -> Void
    
    case push(animated: Bool)
    case pushFirst(animated: Bool)
    case presentCard(animated: Bool)
    case custom(block: PresentationBlock)
}

public extension Coordinator {
    
    func show(_ viewController: UIViewController, with transition: Transition) {
        switch transition {
        case .push(let animated):
            navigationController?.pushViewController(viewController, animated: animated)
        case .pushFirst(let animated):
            navigationController?.setViewControllers([viewController], animated: animated)
        case .presentCard(let animated):
            viewController.modalPresentationStyle = .pageSheet
            navigationController?.present(viewController, animated: animated)
        case .custom(let block):
            block(viewController)
        }
    }
    
}
