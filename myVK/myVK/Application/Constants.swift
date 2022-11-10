// Constants.swift
// Copyright © RoadMap. All rights reserved.

/// Константы
enum Constants {
    enum Identifier {
        enum Segue {
            static let loginSegue = "login"
            static let photoSegue = "PhotoSegue"
            static let unwind = "Unwind"
        }

        enum TableViewCell {
            static let friend = "Friends"
            static let groups = "Groups"
            static let collection = "Photo"
            static let news = "News"
        }
    }

    enum Profile {
        static let login = "ilentiy"
        static let password = "111"
    }

    enum AlertText {
        static let errorTitle = "Ошибка!"
        static let errorText = "Введен неверный логин или пароль"
        static let actionText = "Повторить"
    }

    enum ImageNameText {
        static let logo = "logoVk1"
    }

    enum Text {
        static let searchBarPlaceholder = " Введите название группы"
    }

    enum KeyPath {
        static let opacity = "opacity"
    }
}
