// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// список групп пользователя
final class UserGroupsTableViewController: UITableViewController {
    // MARK: - Private Property

    private var myGroups = Group.getGroups().filter { group in
        guard group.subscribers?.contains(User.getIlentiy().ID) == true else { return false }
        return true
    }

    // MARK: - IBActions

    @IBAction private func addGroupAction(segue: UIStoryboardSegue) {
        guard
            segue.identifier == Constants.Identifier.Segue.unwind,
            let allGroupsController = segue.source as? AllGroupsTableViewController,
            let indexPath = allGroupsController.tableView.indexPathForSelectedRow
        else { return }
        let currentGroup = allGroupsController.searchedGroups[indexPath.row]
        for var group in Group.getGroups() where group == currentGroup {
            group.follow(id: User.getIlentiy().ID)
        }
        if !myGroups.contains(where: { $0.ID == currentGroup.ID }) {
            myGroups.append(currentGroup)
            tableView.reloadData()
        }
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
        cell.updateDate(group: myGroups[indexPath.row])
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            let currentGroup = myGroups.remove(at: indexPath.row)
            for var group in Group.getGroups() where group == currentGroup {
                group.unfollow(id: User.getIlentiy().ID)
            }
        }
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}
