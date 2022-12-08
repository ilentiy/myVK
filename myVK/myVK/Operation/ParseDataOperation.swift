// ParseDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Операция парсинга
class ParseDataOperation: Operation {
    // MARK: - Public Properties

    var outputData: [Group] = []

    // MARK: - Private Method

    override func main() {
        guard
            let getDataOperation = dependencies.first as? GetDataOperation,
            let data = getDataOperation.data
        else { return }
        do {
            let response = try JSONDecoder().decode(Response<Group>.self, from: data)
            outputData = response.items
        } catch {
            print(error)
        }
    }
}
