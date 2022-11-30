// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Данные фото
final class Photo: Object, Codable {
    // MARK: - Public Properties

    @Persisted(primaryKey: true) var id: Int
    @Persisted var ownerID: Int
    @Persisted var photoUrls: List<PhotoUrl>

    // MARK: - Coding Keys

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case photoUrls = "sizes"
    }
}
