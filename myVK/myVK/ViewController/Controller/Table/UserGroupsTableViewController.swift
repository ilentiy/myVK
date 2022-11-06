// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// список групп пользователя
class UserGroupsTableViewController: UITableViewController {
    // MARK: - Private Property

    private var myGroups = groups.filter { group in
        guard group.subscribers?.contains(ilentiy.ID) == true else { return false }
        return true
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBActions

    @IBAction private func addGroupAction(segue: UIStoryboardSegue) {
        guard
            segue.identifier == Constants.Identifier.Segue.unwind,
            let allGroupsController = segue.source as? AllGroupsTableViewController,
            let indexPath = allGroupsController.tableView.indexPathForSelectedRow
        else { return }
        allGroupsController.allGroups[indexPath.row].subscribers?.append(ilentiy.ID)
        let group = allGroupsController.allGroups[indexPath.row]
        if !myGroups.contains(where: { $0.ID == group.ID }) {
            myGroups.append(group)
            tableView.reloadData()
        }
    }
}

extension UserGroupsTableViewController {
    // MARK: - Table view data source

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
            for var group in groups where group == currentGroup {
                group.subscribers = currentGroup.subscribers?.filter { $0 != ilentiy.ID }
            }
        }
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}
