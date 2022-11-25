// UserResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Кол-во и список пользователей
struct UserResponse: Codable {
    let count: Int
    let users: [User]

    enum CodingKeys: String, CodingKey {
        case count
        case users = "items"
    }
}
