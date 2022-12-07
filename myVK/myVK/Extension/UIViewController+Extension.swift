// UIViewController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для создания AlertController
extension UIViewController {
    func showAlertController(alertTitle: String?, message: String?, actionTitle: String?) {
        let errorAlertController = UIAlertController(
            title: alertTitle,
            message: message,
            preferredStyle: .alert
        )
        let okErrorAlertControllerAction = UIAlertAction(
            title: actionTitle,
            style: .cancel
        )
        errorAlertController.addAction(okErrorAlertControllerAction)
        present(errorAlertController, animated: true)
    }
}
