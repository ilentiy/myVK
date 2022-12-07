// AllGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран всех групп
final class AllGroupsTableViewController: UITableViewController {
    // MARK: - Private Visual Components

    private let searchBar = UISearchBar()

    // MARK: - Private Properties

    private let networkService = NetworkService()
    private var searchedGroups: [Group] = []

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
        cell.configure(group: searchedGroups[indexPath.row])
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension AllGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        networkFetchGroup(searchText: searchText)
    }
}

// MARK: - Network Secrvice Method

extension AllGroupsTableViewController {
    // MARK: - Private Methods

    private func networkFetchGroup(searchText: String) {
        networkService.fetchGroup(query: searchText) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(groups):
                self.searchedGroups = groups
                self.tableView.reloadData()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
