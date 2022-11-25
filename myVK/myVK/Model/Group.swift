// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

///  Ответ запроса
struct GroupResult: Codable {
    let response: GroupResponse
}

/// Кол-во и список групп
struct GroupResponse: Codable {
    let count: Int
    let groups: [Group]

    enum CodingKeys: String, CodingKey {
        case count
        case groups = "items"
    }
}

/// Данные группы
final class Group: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var screenName: String
    @objc dynamic var avatar: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case avatar = "photo_200"
    }
}
