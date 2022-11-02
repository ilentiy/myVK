// LogInViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран Авторизации
final class LogInViewController: UIViewController {
    // MARK: IBOutlets

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotificationCenter()
    }

    // MARK: - Public Methods

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Constants.Identifier.segueIdentifier {
            if checkLogin() {
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
        return false
    }

    // MARK: - Private methods

    private func setupUI() {
        installNotificationCenter()
        loginTextField.setLeftPaddingPoints(10)
        passwordTextField.setLeftPaddingPoints(10)
    }

    private func checkLogin() -> Bool {
        guard let loginText = loginTextField.text,
              let passwordText = passwordTextField.text
        else { return false }
        guard loginText == Constants.Profile.login,
              passwordText == Constants.Profile.password
        else { return false }
        return true
    }
}

/// Расширение для работы с клавиатурой
extension LogInViewController {
    // MARK: - Private methods

    private func installNotificationCenter() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        scrollView.addGestureRecognizer(tapGesture)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShownAction(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideAction(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeNotificationCenter() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShownAction(notification: Notification) {
        guard
            let info = notification.userInfo as? NSDictionary
        else { return }
        guard
            let keyboardHeight = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue
            .size.height
        else { return }
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight, right: 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }

    @objc private func keyboardWillHideAction(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    @objc private func hideKeyboardAction() {
        scrollView.endEditing(true)
    }
}
