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

    // MARK: - Private properties

    private var isLiked = false
    private var likesCount = 0

    // MARK: - IBActions

    @IBAction private func likeAction() {
        if isLiked == false {
            likeNumberLabel.text = String(likesCount + 1)
            likeButton.setImage(UIImage(systemName: Constants.heartFill), for: .normal)
            isLiked = true
        } else {
            likeNumberLabel.text = String(likesCount + 0)
            likeButton.setImage(UIImage(systemName: Constants.heart), for: .normal)
            isLiked = false
        }
    }
}
