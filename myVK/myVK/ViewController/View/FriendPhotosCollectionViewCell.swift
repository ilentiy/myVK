// FriendPhotosCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Прототип Ячейки поста
final class FriendPhotosCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var photoImageView: UIImageView!

    // MARK: - Public Properties

    private(set) var photoNames: [String]?
    private(set) var currentPhotoIndex: Int?

    // MARK: - Public Methods

    func configure(photoNameIndex: Int, photoNames: [String]) {
        self.photoNames = photoNames
        photoImageView.image = UIImage(named: photoNames[photoNameIndex])
    }
}
