// FriendPhotosCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Прототип Ячейки поста
final class FriendPhotosCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet

    @IBOutlet var photoImageVIew: UIImageView!

    // MARK: - Public Methods

    func updateCell(imageName: String) {
        photoImageVIew.image = UIImage(named: imageName)
    }
}
