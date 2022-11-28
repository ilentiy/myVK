// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Данные фото
final class Photo: Object, Codable {
    @objc dynamic var ownerID: Int
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case sizes
    }
}
