// NewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Прототип новостей
final class NewsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var newsDataLabel: UILabel!
    @IBOutlet private var newsTextLabel: UILabel!
    @IBOutlet private var postImageView: UIImageView!

    // MARK: - Public Methods

    func updateDate(news: News) {
        nameLabel.text = news.user.name
        avatarImageView.image = UIImage(named: news.user.avatarImageName)
        newsDataLabel.text = news.newsDateText
        newsTextLabel.text = news.newsText
        postImageView.image = UIImage(named: news.photoNames)
    }
}
