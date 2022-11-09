// Data.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// MARK: - Данные пользователей групп и поста

var ilentiy = User.getIlentiy()
var users = User.getUsers()
var groups = Group.getGroups()
var news = [News(user: users[0], newsDateText: "03.11.2022", newsText: "Оцените фотку плииз", photoNames: "1 1")]
