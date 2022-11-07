// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Прототип ячейки списка друзей
final class FriendTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var shadowView: ShadowView!

    // MARK: - Public Property

    var user: User?

    // MARK: - Public Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.configureShadow()
    }

    func updateDate(user: User) {
        nameLabel.text = user.name
        avatarImageView.image = UIImage(named: user.avatarImageName)
    }
}
