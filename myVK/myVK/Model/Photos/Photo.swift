// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Данные фото
final class Photo: Object, Codable {
    /// Идентификатор фото
    @Persisted(primaryKey: true) var id: Int
    /// Идентификатор владельца фото
    @Persisted var ownerID: Int
    /// Список путей к фото
    @Persisted var photoUrls: List<PhotoUrl>

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case photoUrls = "sizes"
    }
}
