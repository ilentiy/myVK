// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Данные пользователя
final class User: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var avatar: String
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String

    enum CodingKeys: String, CodingKey {
        case id
        case avatar = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
