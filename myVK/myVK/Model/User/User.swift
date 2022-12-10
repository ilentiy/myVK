// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Данные пользователя
final class User: Object, Codable {
    /// Идентификатор пользователя
    @Persisted(primaryKey: true) var id: Int

    /// Название аватара пользователя
    @Persisted var avatar: String

    /// Имя
    @Persisted var firstName: String

    /// Фамилия
    @Persisted var lastName: String

    enum CodingKeys: String, CodingKey {
        case id
        case avatar = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
