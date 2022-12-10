// PhotoUrl.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Ссылка на фото
final class PhotoUrl: Object, Codable {
    /// путь к фото
    @Persisted var url: String
}
