// FriendPhotoCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// экран с фотографиями друга
final class FriendPhotoCollectionViewController: UICollectionViewController {
    // MARK: - Private Methods

    var user: User?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
        title = user?.name
    }
}

/// UICollectionViewDataSource
extension FriendPhotoCollectionViewController {
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let itemsCount = user?.photoNames?.count else { return 0 }
        return itemsCount
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let userPhotoNames = user?.photoNames,
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.Identifier.TableViewCell.collection,
                for: indexPath
            ) as? FriendPhotosCollectionViewCell
        else { return UICollectionViewCell() }
        cell.updateCell(imageName: userPhotoNames[indexPath.row])
        return cell
    }
}
