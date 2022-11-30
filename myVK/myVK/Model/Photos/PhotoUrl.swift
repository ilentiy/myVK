// PhotoUrl.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Ссылка на фото
final class PhotoUrl: Object, Codable {
    // MARK: - Public Properties

    @Persisted var url: String
}
