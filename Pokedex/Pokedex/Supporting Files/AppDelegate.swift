//
//  AppDelegate.swift
//  Pokedex
//
//  Created by Martin Essuman on 19/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var appCoordinator: AppCoordinator!
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navController = UINavigationController()

        let injector = makeInjector()
        appCoordinator = AppCoordinator(with: navController, injector: injector)
        appCoordinator.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func makeInjector() -> Injector {
        let injector = ConcreteInjector()
        injector.register(type: PokemonProvider.self, instance: PokemonDataProvider())
        return injector
    }
    
}

