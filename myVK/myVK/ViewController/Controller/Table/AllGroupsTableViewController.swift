// AllGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Список всех групп
final class AllGroupsTableViewController: UITableViewController {
    // MARK: - Private Visual Components

    private let searchBar = UISearchBar()

    // MARK: - Private Property

    private var allGroups = Group.getGroups().filter { group in
        guard group.subscribers?.contains(User.getIlentiy().ID) == false else { return false }
        return true
    }

    private(set) var searchedGroups: [Group] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Private Methods

    private func setupSearchBar() {
        searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 70)
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = Constants.Text.searchBarPlaceholder
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchedGroups = allGroups
    }
}

// MARK: - TableViewDataSource

extension AllGroupsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchedGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Identifier.TableViewCell.groups,
            for: indexPath
        ) as? GroupTableViewCell else { return UITableViewCell() }
        cell.updateDate(group: searchedGroups[indexPath.row])
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension AllGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedGroups = searchText.isEmpty ? allGroups : allGroups.filter { $0.name.contains(searchText) }
        tableView.reloadData()
    }
}
