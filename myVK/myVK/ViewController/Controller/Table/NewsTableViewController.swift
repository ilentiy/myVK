// NewsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Экран Новостей
final class NewsTableViewController: UITableViewController {}

// MARK: - Table view data source

extension NewsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        News.getNews().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Identifier.TableViewCell.news,
            for: indexPath
        ) as? NewsTableViewCell else { return UITableViewCell() }

        cell.configure(news: News.getNews()[indexPath.row])

        return cell
    }
}
