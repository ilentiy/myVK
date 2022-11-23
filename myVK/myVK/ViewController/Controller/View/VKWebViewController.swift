// VKWebViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

import WebKit

/// Авторизация ВК
final class VKWebViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        enum ComponentsURL {
            static let scheme = "https"
            static let host = "oauth.vk.com"
            static let authorizePath = "/authorize"
            static let queryItems = [
                URLQueryItem(
                    name: "client_id",
                    value: "51484172"
                ),
                URLQueryItem(
                    name: "redirect_uri",
                    value: "https://oauth.vk.com/blank.html"
                ),
                URLQueryItem(
                    name: "display",
                    value: "mobile"
                ),
                URLQueryItem(
                    name: "scope",
                    value: "262150"
                ),
                URLQueryItem(
                    name: "response_type",
                    value: "token"
                ),
                URLQueryItem(
                    name: "v",
                    value: "5.68"
                )
            ]
            static let blankPath = "/blank.html"
            static let ampersant = "&"
            static let equals = "="
            static let accessTokenName = "access_token"
            static let userIdName = "user_id"
        }

        static let uIStoryboardName = "Main"
        static let storyboardIdentifier = "Login"
    }

    // MARK: - Private IBOutlets

    @IBOutlet  private var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    // MARK: - Private Properties

    private let session = Session.shared
    private var urlComponents = URLComponents()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        authorize()
    }

    // MARK: - Private Methods

    private func authorize() {
        urlComponents.scheme = Constants.ComponentsURL.scheme
        urlComponents.host = Constants.ComponentsURL.host
        urlComponents.path = Constants.ComponentsURL.authorizePath
        urlComponents.queryItems = Constants.ComponentsURL.queryItems
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension VKWebViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse:
        WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard let url = navigationResponse.response.url, url.path == Constants.ComponentsURL.blankPath,
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: Constants.ComponentsURL.ampersant)
            .map { $0.components(separatedBy: Constants.ComponentsURL.equals) }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        guard let token = params[Constants.ComponentsURL.accessTokenName],
              let userID = params[Constants.ComponentsURL.userIdName] else { return }
        session.userID = userID
        session.token = token
        decisionHandler(.cancel)
        let storyboard = UIStoryboard(name: Constants.uIStoryboardName, bundle: nil)
        guard let loginViewController = storyboard
            .instantiateViewController(withIdentifier: Constants.storyboardIdentifier) as? LogInViewController
        else { return }
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)
    }
}
