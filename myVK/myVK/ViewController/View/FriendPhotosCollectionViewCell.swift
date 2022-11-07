// FriendPhotosCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Прототип Ячейки поста
final class FriendPhotosCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet

    @IBOutlet var photoImageView: UIImageView!

    // MARK: - Public Methods

    func updateCell(imageName: String) {
        photoImageView.image = UIImage(named: imageName)
    }
}
