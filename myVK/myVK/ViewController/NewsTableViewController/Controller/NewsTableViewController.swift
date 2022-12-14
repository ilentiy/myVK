// NewsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран Новостей
final class NewsTableViewController: UITableViewController {
    enum NewsCellType: Int, CaseIterable {
        case header
        case post
        case content
        case footer
    }

    // MARK: - Private Properties

    private let networkService = NetworkService()
    private var news: [News] = []
    private var isLoading = false
    private var mostFreshDate: Double?
    private var nextFrom = ""

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        networkFetchNews()
        setupPullToRefresh()
    }

    // MARK: - Private Methods

    private func setupPullToRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControl?.tintColor = .red
        refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }

    @objc private func refreshAction() {
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
        case .post:
            identifier = Constants.Identifier.TableViewCell.newsPost
        case .content:
            identifier = Constants.Identifier.TableViewCell.newsImage
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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1:
            guard let item = news[indexPath.section].text,
                  !item.isEmpty
            else { return 0.0 }
        case 2:
            if let item = news[indexPath.section].attachments {
                let tableWidth = tableView.bounds.width
                let news = item.first?.photo?.photoUrls.last
                let cellHeigt = tableWidth * (news?.aspectRatio ?? 0.0)
                return cellHeigt
            } else {
                return 0.0
            }
        default:
            return UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }
}

// MARK: - Table View Data Source Prefetching

extension NewsTableViewController {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map(\.section).max() else { return }
        if maxSection > news.count - 3, !isLoading {
            isLoading = true
            networkService.fetchNews(startTime: mostFreshDate ?? 0.0, nextFrom: nextFrom) { [weak self] response in
                guard let self = self else { return }
                switch response {
                case let .success(response):
                    let indexSet = IndexSet(integersIn: self.news.count ..< self.news.count + response.news.count)
                    self.news.append(contentsOf: self.news)
                    self.tableView.insertSections(indexSet, with: .automatic)
                    self.isLoading = false
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

// MARK: - Secrvice Method

extension NewsTableViewController {
    // MARK: - Private Methods

    private func networkFetchNews() {
        if let first = news.first {
            mostFreshDate = Double(first.date) + 1
        }
        networkService.fetchNews(startTime: mostFreshDate ?? 0.0, nextFrom: nextFrom) { [weak self] result in
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
            self.refreshControl?.endRefreshing()
        }
    }
}
