// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные текущей сессии
final class Session {
    static let shared = Session()
    var token = ""
    var userID = ""
    private init() {}
}
