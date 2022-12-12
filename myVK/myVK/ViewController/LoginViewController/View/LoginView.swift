// LoginView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class LoginView: UIView {
    // MARK: - Private IBOutlets

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var loaderView: LoaderView!

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Public methods

    func checkLogin() -> Bool {
        guard let loginText = loginTextField.text,
              let passwordText = passwordTextField.text
        else { return false }
        guard loginText == Constants.Profile.login,
              passwordText == Constants.Profile.password
        else { return false }
        return true
    }

    // MARK: - Private methods

    private func setupUI() {
        loginTextField.setLeftPaddingPoints(10)
        passwordTextField.setLeftPaddingPoints(10)
    }
}

/// Keyboard Notification Center
extension LoginView {
    // MARK: - Public methods

    func installNotificationCenter() {
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

    func removeNotificationCenter() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: - Private methods

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
