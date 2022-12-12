// LogInViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран Авторизации
final class LogInViewController: UIViewController {
    // MARK: - Properties

    private var loginView = LoginView()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loginView.removeNotificationCenter()
    }

    // MARK: - Public Methods

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == Constants.Identifier.Segue.loginSegue else { return false }
        if loginView.checkLogin() {
            return true
        } else {
            showAlertController(
                alertTitle: Constants.AlertText.errorTitle,
                message: Constants.AlertText.errorText,
                actionTitle: Constants.AlertText.actionText
            )
            return false
        }
    }

    // MARK: - Private methods

    private func configure() {
        guard let contentView = view as? LoginView else { return }
        loginView = contentView
        loginView.installNotificationCenter()
    }
}
