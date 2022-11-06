// Model.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Пользователь
struct User {
    var ID: Int
    var name: String
    var avatarImageName: String
    var photoNames: [String]?
    var friendIDs: [Int]?
    var groupsIDs: [Int]?
}

/// Группа
struct Group: Equatable {
    var ID: Int
    var name: String
    var avatarImageName: String
    var subscribers: [Int]?
}
