// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран  групп пользователя
final class UserGroupsTableViewController: UITableViewController {
    // MARK: - Private Properties

    private var myGroups: [Group] = []
    private let networkService = NetworkService()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        networkFetchUserGroup()
    }
}

// MARK: - TableViewDataSource

extension UserGroupsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Identifier.TableViewCell.groups,
            for: indexPath
        ) as? GroupTableViewCell else { return UITableViewCell() }
        cell.configure(group: myGroups[indexPath.row])
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            let currentGroup = myGroups.remove(at: indexPath.row)
        }
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}

// MARK: - Network Secrvice Method

extension UserGroupsTableViewController {
    // MARK: - Private Methods

    private func networkFetchUserGroup() {
        networkService.fetchUserGroups { groups in
            self.myGroups = groups
            self.tableView.reloadData()
        }
    }
}
