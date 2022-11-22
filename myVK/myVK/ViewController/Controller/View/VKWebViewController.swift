// VKWebViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Авторизация ВК
final class VKWebViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var webView: WKWebView! {
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
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
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
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }.reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        guard let token = params["access_token"],
              let userID = params["user_id"] else { return }
        session.userID = userID
        session.token = token
        decisionHandler(.cancel)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginViewController = storyboard
            .instantiateViewController(withIdentifier: "Login") as? LogInViewController else { return }
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)
    }
}
