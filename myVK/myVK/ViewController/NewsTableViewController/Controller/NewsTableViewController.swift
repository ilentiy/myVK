// NewsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран Новостей
final class NewsTableViewController: UITableViewController {
    enum NewsCellType: Int, CaseIterable {
        case header
        case content
        case footer
    }

    // MARK: - Private Propertieas

    private let networkService = NetworkService()
    private var news: [News] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        networkFetchNews()
    }
}

// MARK: - Table view data source

extension NewsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NewsCellType.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = news[indexPath.section]
        var identifier = ""
        guard let cellType = NewsCellType(rawValue: indexPath.row) else { return UITableViewCell() }
        switch cellType {
        case .header:
            identifier = Constants.Identifier.TableViewCell.newsHeader
        case .content:
            identifier = Constants.Identifier.TableViewCell.newsPost
        case .footer:
            identifier = Constants.Identifier.TableViewCell.newsFooter
        }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
        ) as? NewsCell else { return UITableViewCell() }
        cell.configure(item: item)
        return cell
    }
}

// MARK: - Secrvice Method

extension NewsTableViewController {
    // MARK: - Private Methods

    private func networkFetchNews() {
        networkService.fetchNews { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.newsFilter(response: response)
            case let .failure(error):
                self.showAlertController(alertTitle: nil, message: error.localizedDescription, actionTitle: nil)
            }
        }
    }

    private func newsFilter(response: NewsResponse) {
        response.news.forEach { news in
            if news.sourceID < 0 {
                guard let group = response.groups.filter({ group in
                    group.id == news.sourceID * -1
                }).first else { return }
                news.name = group.name
                news.avatar = group.avatar
            } else {
                guard let user = response.users.filter({ user in
                    user.id == news.sourceID
                }).first else { return }
                news.name = "\(user.firstName) \(user.lastName)"
                news.avatar = user.avatar
            }
        }
        DispatchQueue.main.async {
            self.news = response.news
            self.tableView.reloadData()
        }
    }
}
