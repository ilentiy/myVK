// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Прототип ячейки списка друзей
final class GroupTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    // MARK: - Public Property

    var group: Group?

    // MARK: - Public Methods

    func updateDate(group: Group) {
        nameLabel.text = group.name
        avatarImageView.image = UIImage(named: group.avatarImageName)
    }
}
