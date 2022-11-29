// FriendPhotosCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Прототип Ячейки поста
final class FriendPhotosCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var photoImageView: UIImageView!

    // MARK: - Public Properties

    private(set) var currentPhotoIndex = 0

    // MARK: - Public Methods

    func configure(index: Int, photo: Photo) {
        currentPhotoIndex = index
        guard let url = photo.photoUrl.last?.url else { return }
        photoImageView.load(url: url)
    }
}
