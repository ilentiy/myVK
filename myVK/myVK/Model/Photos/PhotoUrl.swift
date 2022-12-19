// PhotoUrl.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Ссылка на фото
final class PhotoUrl: Object, Codable {
    /// Высота
    let height: Int
    /// Ширина
    let width: Int
    /// Путь к фото
    @Persisted var url: String
    /// Соотношение сторон
    var aspectRatio: CGFloat { CGFloat(height) / CGFloat(width) }
}
