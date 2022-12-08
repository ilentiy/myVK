// News.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Тип поста
enum PostTypeEnum: String, Codable {
    case post
    case wallPhoto = "wall_photo"
}

/// Элемент списка новостей
///  - Properties
///     - sourceID: айди источника поста (группа/пользователь)
///     - date: дата поста
///     - postType: тип поста
///     - text: текст поста
///     - likes: лайки
///     - views: просмотры
final class News: Codable {
    let sourceID: Int
    let date: Int
    let postType: PostTypeEnum?
    let text: String?
    let likes: Likes?
    let views: Views?

    var avatar: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case postType = "post_type"
        case text
        case likes
        case views
    }
}
