// NewsImageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с картинкой поста
class NewsImageTableViewCell: NewsCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var postImageView: UIImageView!

    // MARK: Public Methods

    func configure(item: News) {
        postImageView.largeContentTitle = item.text
    }
}
