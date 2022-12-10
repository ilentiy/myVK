// NewsFooterTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с действиями к посту лайк поделиться комент
final class NewsFooterTableViewCell: NewsCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var viewsCountLabel: UILabel!
    @IBOutlet private var likeControl: LikeControl!

    // MARK: Public Methods

    func configure(item: News) {
        viewsCountLabel.text = "\(item.views?.count ?? 0)"
        likeControl.configure(item: item)
    }
}
