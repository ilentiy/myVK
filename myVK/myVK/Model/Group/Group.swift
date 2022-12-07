// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Данные группы
/// - Properies
///     - id: идентификатор группы
///     - name: название группы
///     - screenName: экранное имя
///     - avatar: название аватара группы
final class Group: Object, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var screenName: String
    @Persisted var avatar: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case avatar = "photo_200"
    }
}
