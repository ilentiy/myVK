// Model.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Пользователь
struct User {
    let ID: Int
    let name: String
    let avatarImageName: String
    let photoNames: [String]?
    let friendIDs: [Int]?

    static func getIlentiy() -> User {
        let user = User(
            ID: 0,
            name: "Илья Брыков",
            avatarImageName: "0",
            photoNames: [],
            friendIDs: [1, 2, 4, 3, 10, 9, 6, 7]
        )
        return user
    }

    static func getUsers() -> [User] {
        let users: [User] = [
            User(
                ID: 1,
                name: "Александра Ананьева",
                avatarImageName: "1",
                photoNames: ["1", "1 1", "1 2", "1 3"],
                friendIDs: []
            ),
            User(
                ID: 2,
                name: "Максим Сафонов",
                avatarImageName: "2",
                photoNames: ["2", "2 1", "2 2"],
                friendIDs: []
            ),
            User(
                ID: 3,
                name: "Елизавета Игнатьева",
                avatarImageName: "3",
                photoNames: ["3", "3 1", "3 2"],
                friendIDs: []
            ),
            User(
                ID: 4,
                name: "Борис Кочергин",
                avatarImageName: "4",
                photoNames: ["4", "4 1", "4 2", "4 3"],
                friendIDs: []
            ),
            User(
                ID: 5,
                name: "Наталья Козлова",
                avatarImageName: "5",
                photoNames: ["5", "2 1", "3 1"],
                friendIDs: []
            ),
            User(
                ID: 6,
                name: "Антон Михайлов",
                avatarImageName: "6",
                photoNames: ["6", "3 1", "4 3"],
                friendIDs: []
            ),
            User(
                ID: 7,
                name: "Николь Островская",
                avatarImageName: "7",
                photoNames: ["7"],
                friendIDs: []
            ),
            User(
                ID: 8,
                name: "Александр Бородин",
                avatarImageName: "8",
                photoNames: ["8", "1 2"],
                friendIDs: []
            ),
            User(
                ID: 9,
                name: "Артём Лебедев",
                avatarImageName: "9",
                photoNames: ["9", "3 1"],
                friendIDs: []
            ),
            User(
                ID: 10,
                name: "Александра Иванова",
                avatarImageName: "10",
                photoNames: ["10"],
                friendIDs: []
            ),
        ]
        return users
    }
}

/// Группа
struct Group: Equatable {
    let ID: Int
    let name: String
    let avatarImageName: String
    var subscribers: [Int]?

    static func getGroups() -> [Group] {
        let groups = [
            Group(
                ID: 0,
                name: "Айосеры",
                avatarImageName: "Swift",
                subscribers: [0, 1, 2]
            ),
            Group(
                ID: 1,
                name: "Андройдеры",
                avatarImageName: "Android",
                subscribers: [1, 4, 6]
            ),
            Group(
                ID: 2,
                name: "Новости",
                avatarImageName: "news",
                subscribers: [1, 0, 4]
            ),
            Group(
                ID: 3,
                name: "Котики",
                avatarImageName: "cat",
                subscribers: [1, 2, 3]
            ),
            Group(
                ID: 4,
                name: "Игры",
                avatarImageName: "game",
                subscribers: [1, 2, 0]
            ),
            Group(
                ID: 5,
                name: "Спорт",
                avatarImageName: "sport",
                subscribers: [1, 3, 5]
            ),
            Group(
                ID: 6,
                name: "Цитаты великих всех",
                avatarImageName: "DS",
                subscribers: [2, 4, 5]
            ),
        ]
        return groups
    }

    mutating func follow(id: Int) {
        subscribers?.append(id)
    }

    mutating func unfollow(id: Int) {
        subscribers = subscribers?.filter { $0 != id }
    }
}

/// Новости
struct News {
    let user: User
    let newsDateText: String
    let newsText: String
    let photoNames: String

    static func getNews() -> [News] {
        let news = [
            News(
                user: User.getUsers()[0],
                newsDateText: "03.11.2022",
                newsText: "Оцените фотку плииз",
                photoNames: "1 1"
            ),
            News(
                user: User.getUsers()[2],
                newsDateText: "01.11.2022",
                newsText: "Всем привет",
                photoNames: "1 2"
            ),
        ]
        return news
    }
}
