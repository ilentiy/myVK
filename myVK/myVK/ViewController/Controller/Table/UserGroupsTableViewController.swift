// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Экран  групп пользователя
final class UserGroupsTableViewController: UITableViewController {
    // MARK: - Private Properties

    private var myGroups: Results<Group>?
    private let networkService = NetworkService()
    private var notificationToken: NotificationToken?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRealmData()
    }
}

// MARK: - TableViewDataSource

extension UserGroupsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myGroups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentGroup = myGroups?[indexPath.row],
              let cell = tableView.dequeueReusableCell(
                  withIdentifier: Constants.Identifier.TableViewCell.groups,
                  for: indexPath
              ) as? GroupTableViewCell else { return UITableViewCell() }
        cell.configure(group: currentGroup)
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}

// MARK: - Secrvice Method

extension UserGroupsTableViewController {
    // MARK: - Private Methods

    private func addNotificationToken(result: Results<Group>) {
        notificationToken = result.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            switch changes {
            case .initial:
                break
            case .update:
                self.myGroups = result
                self.tableView.reloadData()
            case let .error(error):
                print(error.localizedDescription)
            }
        }
    }

    private func loadRealmData() {
        do {
            let realm = try Realm()
            let items = realm.objects(Group.self)
            addNotificationToken(result: items)
            if !items.isEmpty {
                myGroups = items
            } else {
                networkFetchUserGroup()
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
    }

    private func networkFetchUserGroup() {
        networkService.fetchUserGroups { [weak self] result in
            switch result {
            case let .success:
                break
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
