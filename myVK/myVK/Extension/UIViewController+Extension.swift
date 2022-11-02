// UIViewController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для создания AlertController
extension UIViewController {
    func showAlertController(alertTitle: String?, message: String?, actionTitle: String?) {
        let loginErrorAlertController = UIAlertController(
            title: alertTitle,
            message: message,
            preferredStyle: .alert
        )
        let okLoginErrorAlertControllerAction = UIAlertAction(
            title: actionTitle,
            style: .cancel
        )
        loginErrorAlertController.addAction(okLoginErrorAlertControllerAction)
        present(loginErrorAlertController, animated: true)
    }
}
