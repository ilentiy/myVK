// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран списка друзей
final class FriendsTableViewController: UITableViewController {
    // MARK: Private Properties

    private var users: [User] = []
    private let interactiveTransition = InteractiveTransition()
    private let networkService = NetworkService()
    private var sectionsMap: [Character: [User]] = [:]
    private var sectionTitles: [Character] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        networkFetchFriends()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == Constants.Identifier.Segue.pageSegue,
           let cell = sender as? FriendTableViewCell,
           let destination = segue.destination as? FriendPhotoCollectionViewController { destination.user = cell.user }
    }

    // MARK: - Private Methods

    private func alphabetSort() {
        for user in users {
            guard let firstLetter = user.firstName.first else { return }
            if sectionsMap[firstLetter] != nil {
                sectionsMap[firstLetter]?.append(user)
            } else {
                sectionsMap[firstLetter] = [user]
            }
        }
        sectionTitles = Array(sectionsMap.keys).sorted()
    }
}

// MARK: - TableViewDataSource

extension FriendsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionsMap.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionsMap[sectionTitles[section]]?.count ?? 0
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
        guard let user = sectionsMap[sectionTitles[indexPath.section]]?[indexPath.row],
              let cell = tableView.dequeueReusableCell(
                  withIdentifier: Constants.Identifier.TableViewCell.friend,
                  for: indexPath
              ) as? FriendTableViewCell else { return UITableViewCell() }
        cell.configure(user: user)
        return cell
    }
}

// MARK: - Network Secrvice Method

extension FriendsTableViewController {
    // MARK: - Private Methods

    private func networkFetchFriends() {
        networkService.fetchFriends { [weak self] users in
            guard let self = self else { return }
            self.users = users
            self.alphabetSort()
            self.tableView.reloadData()
        }
    }
}
