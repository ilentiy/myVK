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
}
