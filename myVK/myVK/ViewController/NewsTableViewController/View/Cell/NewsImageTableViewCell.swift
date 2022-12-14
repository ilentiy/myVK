// NewsImageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с картинкой поста
final class NewsImageTableViewCell: NewsCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var postImageView: UIImageView!

    // MARK: Public Methods

    func configure(item: News) {
        guard let imageName = item.attachments?.first?.photo?.photoUrls.last?.url else { return }
        DispatchQueue.main.async {
            self.postImageView.load(url: imageName)
        }
    }
}
