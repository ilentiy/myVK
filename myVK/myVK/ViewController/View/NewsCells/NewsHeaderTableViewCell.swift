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
        let date = dateConvert(date: item.date)
        newsDataLabel.text = "\(date)"
        nameLabel.text = item.name
        avatarImageView.load(url: item.avatar)
    }

    // MARK: Private Methods

    private func dateConvert(date: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(date))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
}
