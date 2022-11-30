// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Экран списка друзей
final class FriendsTableViewController: UITableViewController {
    // MARK: Private Properties

    private let interactiveTransition = InteractiveTransition()
    private let networkService = NetworkService()
    private var users: Results<User>?
    private var sectionsMap: [Character: [User]] = [:]
    private var sectionTitles: [Character] = []
    private var notificationToken: NotificationToken?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
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
        guard let users = users else { return }
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

// MARK: - Secrvice Method

extension FriendsTableViewController {
    // MARK: - Private Methods

    private func addNotificationToken(result: Results<User>) {
        notificationToken = result.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            switch changes {
            case .initial:
                break
            case .update:
                self.users = result
                self.alphabetSort()
                self.tableView.reloadData()
            case let .error(error):
                print(error.localizedDescription)
            }
        }
    }

    private func loadData() {
        guard let items = RealmService.defaultRealmService.readData(type: User.self) else { return }
        addNotificationToken(result: items)
        if !items.isEmpty {
            users = items
        } else {
            networkFetchFriends()
        }
        alphabetSort()
        tableView.reloadData()
    }

    private func networkFetchFriends() {
        networkService.fetchFriends { [weak self] result in
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
