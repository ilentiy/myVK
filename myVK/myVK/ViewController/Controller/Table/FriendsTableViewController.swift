// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// список друзей
class FriendsTableViewController: UITableViewController {
    // MARK: Private Property

    private let friends = users.filter { user in
        guard let friend = ilentiy.friendIDs?.contains(user.ID) else { return false }
        return friend
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == Constants.Identifier.Segue.photoSegue,
           let cell = sender as? FriendTableViewCell,
           let destination = segue
           .destination as? FriendPhotoCollectionViewController { destination.user = cell.user }
    }
}

extension FriendsTableViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Identifier.TableViewCell.friend,
            for: indexPath
        ) as? FriendTableViewCell else { return UITableViewCell() }
        cell.user = friends[indexPath.row]
        cell.updateDate(user: friends[indexPath.row])
        return cell
    }
}
