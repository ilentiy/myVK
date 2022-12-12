// NewsPostTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка С текстом поста
final class NewsPostTableViewCell: NewsCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var newsTextLabel: UILabel!

    // MARK: Public Methods

    func configure(item: News) {
        newsTextLabel.text = item.text
    }
}
