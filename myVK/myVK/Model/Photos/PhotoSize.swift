// PhotoSize.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

///  Ссылка на фото
final class Size: Object, Codable {
    @objc dynamic var url: String
}
