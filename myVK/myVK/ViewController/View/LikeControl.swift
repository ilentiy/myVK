// LikeControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///   Счетчик лайков под фото
final class LikeControl: UIControl {
    // MARK: - Constants

    private enum Constants {
        static let heart = "heart"
        static let heartFill = "heart.fill"
    }

    // MARK: - IBOutlets

    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var likeNumberLabel: UILabel!
    @IBOutlet private var likeView: UIView?

    // MARK: - Private properties

    private var isLiked = false
    private var likesCount = 0

    // MARK: - IBActions

    @IBAction private func likeAction() {
        if isLiked == false {
            likeButton.setImage(UIImage(systemName: Constants.heartFill), for: .normal)
            likeAnimate()
            isLiked = true
            likeNumberLabel.text = "\(likesCount + 1)"
        } else {
            likeNumberLabel.text = "\(likesCount)"
            likeNumberLabel.textColor = .systemGray
            likeButton.setImage(UIImage(systemName: Constants.heart), for: .normal)
            likeButton.tintColor = .systemGray
            likeView?.backgroundColor = .systemGray.withAlphaComponent(0.75)
            isLiked = false
        }
    }

    func configure(item: News) {
        likesCount = item.likes?.count ?? 0
        likeNumberLabel.text = "\(likesCount)"
    }

    private func likeAnimate() {
        guard let bounds = likeButton.imageView?.bounds else { return }
        UIView.animate(withDuration: 1.0) {
            self.likeButton.tintColor = .systemRed
            self.likeView?.backgroundColor = .systemRed.withAlphaComponent(0.5)
        }

        UIView.animate(
            withDuration: 1.0,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 5,
            options: .curveEaseInOut
        ) {
            self.likeButton.bounds = CGRect(
                x: bounds.origin.x,
                y: bounds.origin.y * 0.95,
                width: bounds.width,
                height: bounds.height / 0.95
            )
        }

        UIView.transition(
            with: likeNumberLabel,
            duration: 0.5,
            options: .transitionFlipFromBottom
        ) {
            self.likeNumberLabel.text = String(self.likesCount + 1)
            self.likeNumberLabel.textColor = .systemRed
        }
    }
}
