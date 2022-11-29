// FriendPhotoCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Экран профиля друга
final class FriendPhotoCollectionViewController: UICollectionViewController {
    // MARK: - Public Properties

    var user: User?
    var photos: [Photo] = []

    lazy var fullName: String = {
        guard let firstName = user?.firstName,
              let lastName = user?.lastName
        else { return "" }
        return "\(firstName)  \(lastName)"
    }()

    // MARK: - Private Properties

    private let networkService = NetworkService()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == Constants.Identifier.Segue.photoSegue,
              let cell = sender as? FriendPhotosCollectionViewCell,
              let destination = segue.destination as? FriendPhotosViewController
        else { return }
        destination.photos = photos
        destination.currentPhotoIndex = cell.currentPhotoIndex
    }

    // MARK: - Private Methods

    private func configureUI() {
        title = fullName
        loadRealmData(ownerID: user?.id ?? 0)
    }
}

// MARK: - UICollectionViewDataSource

extension FriendPhotoCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.Identifier.TableViewCell.collection,
                for: indexPath
            ) as? FriendPhotosCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configure(index: indexPath.row, photo: photos[indexPath.row])
        return cell
    }
}

// MARK: - Network Secrvice Method

extension FriendPhotoCollectionViewController {
    // MARK: - Private Methods

    private func loadRealmData(ownerID: Int) {
        do {
            let realm = try Realm()
            let items = Array(realm.objects(Photo.self).where { $0.ownerID == ownerID })
            if photos != items {
                photos = items
            } else {
                networkFetchPhotos(ownerID: ownerID)
            }
        } catch {
            print(error)
        }
        collectionView.reloadData()
    }

    private func networkFetchPhotos(ownerID: Int) {
        networkService.fetchPhotos(ownerID: ownerID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(photos):
                self.photos = photos
                self.collectionView.reloadData()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
