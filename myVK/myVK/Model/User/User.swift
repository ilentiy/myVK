// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Данные пользователя
/// - Properies
///     - id: идентификатор пользователя
///     - firstName: имя
///     - lastName: фамилия
///     - avatar: название аватара пользователя
final class User: Object, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var avatar: String
    @Persisted var firstName: String
    @Persisted var lastName: String

    enum CodingKeys: String, CodingKey {
        case id
        case avatar = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
