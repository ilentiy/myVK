// AllGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Список всех групп
final class AllGroupsTableViewController: UITableViewController {
    // MARK: - Private Property

    var allGroups = groups.filter { group in
        guard group.subscribers?.contains(ilentiy.ID) == false else { return false }
        return true
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AllGroupsTableViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Identifier.TableViewCell.groups,
            for: indexPath
        ) as? GroupTableViewCell else { return UITableViewCell() }
        cell.updateDate(group: allGroups[indexPath.row])
        return cell
    }
}
