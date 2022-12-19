// News.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Тип поста
enum PostTypeEnum: String, Codable {
    case post
    case wallPhoto = "wall_photo"
}

/// Элемент списка новостей
final class News: Codable {
    /// Айди источника поста (группа/пользователь)
    let sourceID: Int

    /// Дата поста
    let date: Int

    /// Тип поста
    let postType: PostTypeEnum?

    /// Текст поста
    let text: String?

    /// Вложения
    let attachments: [Attachment]?

    /// Лайки
    let likes: Likes?

    /// Просмотры
    let views: Views?

    /// Путь аватара пользователя/группы
    var avatar: String?

    /// Имя пользователя/группы
    var name: String?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case postType = "post_type"
        case text
        case attachments
        case likes
        case views
    }
}
