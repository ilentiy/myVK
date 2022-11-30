// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Данные группы
final class Group: Object, Codable {
    // MARK: - Public Properties

    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var screenName: String
    @Persisted var avatar: String

    // MARK: - Coding Keys

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case avatar = "photo_200"
    }
}
