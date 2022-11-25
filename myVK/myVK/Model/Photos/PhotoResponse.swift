// PhotoResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Кол-во и список фото
struct PhotoResponse: Codable {
    let count: Int
    let photos: [Photo]

    enum CodingKeys: String, CodingKey {
        case count
        case photos = "items"
    }
}
