//
//  BaseViewController.swift
//  Pokedex
//
//  Created by Martin Essuman on 27/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import UIKit

extension View {
    
    /// Shows an error dialog with the given title, message and actions.
    /// - Parameters:
    ///   - title: title of the dialog.
    ///   - message: message of the dialog.
    ///   - actions: actions of the dialog. Default value is a confirm action.
    func showErrorAlert(with title: String?,
                   message: String? = nil,
                   actions: [UIAlertAction]? = [UIAlertAction(title: Strings.ok.localized,
                                                             style: .default,
                                                             handler: nil)
        ]
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach(alert.addAction(_:))
        self.present(alert, animated: true, completion: nil)
    }
}

extension BasePresenter {
    
    /// Asks the view to show a simple dialog for the given error.
    /// - Parameters:
    ///   - error: error to be shown.
    ///   - actions: actions for the dialog. Default value is a confirm action.
    func handleError(_ error: Error, actions: [UIAlertAction]? = [UIAlertAction(title: Strings.ok.localized,
                                                                               style: .default,
                                                                               handler: nil)]) {
        self.view.showErrorAlert(with: Strings.error.localized,
                            message: error.localizedDescription,
                            actions: actions)
    }
}
