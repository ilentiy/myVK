// Photos.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

///  Ответ запроса
struct PhotoResult: Codable {
    let response: PhotoResponse
}

/// Кол-во и список фото
struct PhotoResponse: Codable {
    let count: Int
    let photos: [Photo]

    enum CodingKeys: String, CodingKey {
        case count
        case photos = "items"
    }
}

/// Данные фото
final class Photo: Object, Codable {
    @objc dynamic var ownerID: Int
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case sizes
    }
}

///  Ссылка на фото
final class Size: Object, Codable {
    @objc dynamic var url: String
}
