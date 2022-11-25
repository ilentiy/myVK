// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

///  Ответ запроса
struct UserResult: Codable {
    let response: UserResponse
}

/// Кол-во и список пользователей
struct UserResponse: Codable {
    let count: Int
    let users: [User]

    enum CodingKeys: String, CodingKey {
        case count
        case users = "items"
    }
}

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
