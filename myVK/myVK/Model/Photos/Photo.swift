// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Данные фото
final class Photo: Object, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var ownerID: Int
    @Persisted var photoUrl: List<PhotoUrl>

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case photoUrl = "sizes"
    }
}
