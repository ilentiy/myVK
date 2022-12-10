// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Данные группы
final class Group: Object, Codable {
    /// Идетнификатор группы
    @Persisted(primaryKey: true) var id: Int
    /// Название группы
    @Persisted var name: String
    /// Экранное имя
    @Persisted var screenName: String
    /// путь к аватару группы
    @Persisted var avatar: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case avatar = "photo_200"
    }
}
