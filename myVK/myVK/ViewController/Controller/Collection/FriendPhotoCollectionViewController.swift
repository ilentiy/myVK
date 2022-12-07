// FriendPhotoCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Экран профиля друга
final class FriendPhotoCollectionViewController: UICollectionViewController {
    // MARK: - Public Properties

    var user: User?
    var photos: Results<Photo>?

    // MARK: - Private Properties

    private var notificationToken: NotificationToken?

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
              let destination = segue.destination as? FriendPhotosViewController,
              let photos = photos
        else { return }
        destination.photos = Array(photos)
        destination.currentPhotoIndex = cell.currentPhotoIndex
    }

    // MARK: - Private Methods

    private func configureUI() {
        title = fullName
        loadData(ownerID: user?.id ?? 0)
    }
}

// MARK: - UICollectionViewDataSource

extension FriendPhotoCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos?.count ?? 0
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let currentPhoto = photos?[indexPath.row],
              let cell = collectionView.dequeueReusableCell(
                  withReuseIdentifier: Constants.Identifier.TableViewCell.collection,
                  for: indexPath
              ) as? FriendPhotosCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configure(index: indexPath.row, photo: currentPhoto)
        return cell
    }
}

// MARK: - Network Secrvice Method

extension FriendPhotoCollectionViewController {
    // MARK: - Private Methods

    private func addNotificationToken(result: Results<Photo>) {
        notificationToken = result.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            switch changes {
            case .initial:
                break
            case .update:
                self.photos = result
                self.collectionView.reloadData()
            case let .error(error):
                self.showAlertController(alertTitle: nil, message: error.localizedDescription, actionTitle: nil)
            }
        }
    }

    private func loadData(ownerID: Int) {
        guard let items = RealmService.defaultRealmService.readData(type: Photo.self)?.where({ $0.ownerID == ownerID })
        else { return }
        addNotificationToken(result: items)
        if !items.isEmpty {
            photos = items
        } else {
            networkFetchPhotos(ownerID: ownerID)
        }
        collectionView.reloadData()
    }

    private func networkFetchPhotos(ownerID: Int) {
        networkService.fetchPhotos(ownerID: ownerID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(items):
                RealmService.defaultRealmService.saveData(items)
            case let .failure(error):
                self.showAlertController(alertTitle: nil, message: error.localizedDescription, actionTitle: nil)
            }
        }
    }
}
