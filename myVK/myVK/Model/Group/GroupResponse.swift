// GroupResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Кол-во и список групп
struct GroupResponse: Codable {
    let count: Int
    let groups: [Group]

    enum CodingKeys: String, CodingKey {
        case count
        case groups = "items"
    }
}
