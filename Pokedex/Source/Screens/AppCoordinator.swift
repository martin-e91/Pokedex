//
//  AppCoordinator.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    enum Destinations {
        
    }
    
    override init(with navigationController: UINavigationController) {
        super.init(with: navigationController)
        
        navigationController.navigationBar.isTranslucent = false
    }
    
    override func start() {
        
    }
    
    func navigate(to destination: Destinations) {
        
    }
}
