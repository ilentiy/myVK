// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные текущей сессии
final class Session {
    // MARK: Public Properties

    static let shared = Session()
    var token = ""
    var userID = ""

    // MARK: - Pivate Init

    private init() {}
}
