// PostCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка фото поста
class PostCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var photoImageView: UIImageView!

    func configure(photo: Photo) {
        guard let url = photo.photoUrls.last?.url else { return }
        photoImageView.load(url: url)
    }
}
