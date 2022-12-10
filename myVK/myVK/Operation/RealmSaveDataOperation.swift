// RealmSaveDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Операция передачи данных в контроллер
final class RealmSaveDataOperation: Operation {
    // MARK: - Public Methods

    override func main() {
        guard let parseData = dependencies.first as? ParseDataOperation else { return }
        let items = parseData.outputData
        RealmService.defaultRealmService.saveData(items)
    }
}
