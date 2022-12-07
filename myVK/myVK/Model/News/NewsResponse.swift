// NewsResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ответ от сервера
/// - Properties
///     - news: список новостей
///     - users: список пользователей в ленте новостей
///     - groups: список групп в ленте новостей
struct NewsResponse: Decodable {
    let news: [News]
    let users: [User]
    let groups: [Group]

    enum CodingKeys: String, CodingKey {
        case response
        case users = "profiles"
        case groups
        case news = "items"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var responseContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        news = try responseContainer.decode([News].self, forKey: .news)
        users = try responseContainer.decode([User].self, forKey: .users)
        groups = try responseContainer.decode([Group].self, forKey: .groups)
    }
}
