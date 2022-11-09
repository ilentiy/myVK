// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// список друзей
final class FriendsTableViewController: UITableViewController {
    // MARK: Private Property

    private let friends = users.filter { user in
        guard let friend = ilentiy.friendIDs?.contains(user.ID) else { return false }
        return friend
    }

    private var sections: [Character: [User]] = [:]
    private var sectionTitles: [Character] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        alphabetSort()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == Constants.Identifier.Segue.photoSegue,
           let cell = sender as? FriendTableViewCell,
           let destination = segue.destination as? FriendPhotoCollectionViewController { destination.user = cell.user }
    }

    // MARK: - Private Methods

    private func alphabetSort() {
        for friend in friends {
            guard let firstLetter = friend.name.first else { return }
            if sections[firstLetter] != nil {
                sections[firstLetter]?.append(friend)
            } else {
                sections[firstLetter] = [friend]
            }
        }
        sectionTitles = Array(sections.keys).sorted()
    }
}

// MARK: - TableViewDataSource

extension FriendsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[sectionTitles[section]]?.count ?? 0
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitles.compactMap { String($0) }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sectionTitles[section])
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let view = view as? UITableViewHeaderFooterView else { return }
        view.contentView.backgroundColor = .black.withAlphaComponent(0.25)
        view.textLabel?.textColor = .tintColor
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let friend = sections[sectionTitles[indexPath.section]]?[indexPath.row],
              let cell = tableView.dequeueReusableCell(
                  withIdentifier: Constants.Identifier.TableViewCell.friend,
                  for: indexPath
              ) as? FriendTableViewCell else { return UITableViewCell() }
        cell.user = friend
        cell.updateDate(user: friend)
        return cell
    }
}
