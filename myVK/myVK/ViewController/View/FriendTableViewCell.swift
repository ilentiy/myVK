// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Прототип ячейки списка друзей
final class FriendTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var shadowView: ShadowView!

    // MARK: - Public Properties

    private(set) var user: User?

    // MARK: - Public Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.configureShadow()
    }

    func configure(user: User) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(avatarAnimateAction))
        self.user = user
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(gesture)
        nameLabel.text = user.name
        avatarImageView.image = UIImage(named: user.avatarImageName)
    }

    // MARK: - Private Methods

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
            self.shadowView.bounds = CGRect(
                x: bounds.origin.x * 0.75,
                y: bounds.origin.y * 0.75,
                width: bounds.width / 0.75,
                height: bounds.height / 0.75
            )
        }
    }
}
