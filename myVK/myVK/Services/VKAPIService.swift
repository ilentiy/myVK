// VKAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire

import Foundation

///  Сетевой слой
final class VKAPIService {
    // MARK: - Constants

    private enum Constants {
        static let baseURL = "https://api.vk.com/method/"

        enum GetFriends {
            static let path = "friends.get?"
            static let parametrs: Parameters = [
                "user_ids": Session.shared.userID,
                "fields": "nickname",
                "access_token": Session.shared.token,
                "v": "5.131"
            ]
        }

        enum GetPhotos {
            static let path = "photos.getAll?"
            static let parametrs: Parameters = [
                "owner_id": Session.shared.userID,
                "access_token": Session.shared.token,
                "v": "5.131"
            ]
        }

        enum GetGroups {
            static let path = "groups.get"
            static let parametrs: Parameters = [
                "user_ids": Session.shared.userID,
                "extended": "1",
                "access_token": Session.shared.token,
                "v": "5.131"
            ]
        }

        enum GetSearchGroups {
            static let path = "groups.search"
            static let parametrs: Parameters = [
                "q": "",
                "access_token": Session.shared.token,
                "v": "5.131"
            ]
        }
    }

    // MARK: - Public Method

    func fetchFriends() {
        let path = Constants.GetFriends.path
        let parametrs = Constants.GetFriends.parametrs
        let urlPath = Constants.baseURL + path
        AF.request(urlPath, parameters: parametrs).responseJSON { response in
            print(response.value ?? "NO JSON")
        }
    }

    func fetchPhotos() {
        let path = Constants.GetPhotos.path
        let parametrs = Constants.GetPhotos.parametrs
        let urlPath = Constants.baseURL + path
        AF.request(urlPath, parameters: parametrs).responseJSON { response in
            print(response.value ?? "NO JSON")
        }
    }

    func fetchUserGroups() {
        let path = Constants.GetGroups.path
        let parametrs = Constants.GetGroups.parametrs
        let urlPath = Constants.baseURL + path
        AF.request(urlPath, parameters: parametrs).responseJSON { response in
            print(response.value ?? "NO JSON")
        }
    }

    func fetchGroup(q searchText: String) {
        let path = Constants.GetSearchGroups.path
        var parametrs = Constants.GetSearchGroups.parametrs
        parametrs["q"] = searchText
        let urlPath = Constants.baseURL + path
        AF.request(urlPath, parameters: parametrs).responseJSON { response in
            print(response.value ?? "NO JSON")
        }
    }
}
