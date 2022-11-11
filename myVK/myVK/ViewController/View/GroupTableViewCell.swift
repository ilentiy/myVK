// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Прототип ячейки списка друзей
final class GroupTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    // MARK: - Public Properties

    var group: Group?

    // MARK: - Public Methods

    func updateDate(group: Group) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(avatarAnimateAction))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(gesture)
        nameLabel.text = group.name
        avatarImageView.image = UIImage(named: group.avatarImageName)
    }

    // MARK: - Private Method

    @objc private func avatarAnimateAction() {
        let bounds = avatarImageView.bounds

        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 10,
            options: .curveEaseInOut
        ) {
            self.avatarImageView.bounds = CGRect(
                x: bounds.origin.x * 0.75,
                y: bounds.origin.y * 0.75,
                width: bounds.width / 0.75,
                height: bounds.height / 0.75
            )
        }
    }
}
