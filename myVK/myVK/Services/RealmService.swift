// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// База Данных
final class RealmService {
    // MARK: - Public Properties

    static let defaultRealmService = RealmService()

    // MARK: - Private Properties

    private let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    // MARK: - Public Methods

    func readData<T: Object>(type: T.Type) -> Results<T>? {
        var items: Results<T>?
        do {
            let realm = try Realm()
            items = realm.objects(T.self)
        } catch {
            print(error)
        }
        return items
    }

    func saveData<T: Object>(_ newItems: [T]) {
        do {
            let realm = try Realm(configuration: config)
            let oldItems = realm.objects(T.self)
            realm.beginWrite()
            realm.add(newItems, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
