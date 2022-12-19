// NewsHeaderTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с заголовком поста
final class NewsHeaderTableViewCell: NewsCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var newsDataLabel: UILabel!

    // MARK: Public Methods

    func configure(item: News) {
        let date = DateFormatter.convert(item.date)
        newsDataLabel.text = "\(date)"
        nameLabel.text = item.name
        avatarImageView.load(url: item.avatar)
    }
}
