// FriendPhotosCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Прототип Ячейки поста
final class FriendPhotosCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var photoImageView: UIImageView!

    // MARK: - Public Properties

    var photoNames: [String]?
    var currentPhotoIndex: Int?

    // MARK: - Public Methods

    func updateCell(imageName: String) {
        photoImageView.image = UIImage(named: imageName)
    }
}
