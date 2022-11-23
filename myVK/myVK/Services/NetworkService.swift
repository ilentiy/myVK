// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

///  Сетевой слой
final class NetworkService {
    // MARK: - Constants

    private enum Constants {
        static let baseURL = "https://api.vk.com/method/"
        static let getFriendsPath = "friends.get"
        static let getPhotosPath = "photos.getAll"
        static let getUserGroupPath = "groups.get"
        static let getGroupPath = "groups.search"

        enum ParametersKey {
            static let userID = "user_ids"
            static let token = "access_token"
            static let fields = "fields"
            static let version = "v"
            static let ownerID = "owner_id"
            static let extended = "extended"
            static let query = "q"
        }

        enum ParametersValue {
            static let userID = Session.shared.userID
            static let token = Session.shared.token
            static let fields = "nickname"
            static let extended = "1"
            static let version = "5.131"
        }
    }

    // MARK: - Public Method

    func fetchFriends() {
        let urlPath = "\(Constants.baseURL)\(Constants.getFriendsPath)"
        let parametrs: Parameters = [
            Constants.ParametersKey.userID: Constants.ParametersValue.userID,
            Constants.ParametersKey.fields: Constants.ParametersValue.fields,
            Constants.ParametersKey.token: Constants.ParametersValue.token,
            Constants.ParametersKey.version: Constants.ParametersValue.version
        ]
        AF.request(urlPath, parameters: parametrs).responseJSON { response in
            print(response.value ?? "")
        }
    }

    func fetchPhotos() {
        let urlPath = "\(Constants.baseURL)\(Constants.getPhotosPath)"
        let parametrs: Parameters = [
            Constants.ParametersKey.ownerID: Constants.ParametersValue.userID,
            Constants.ParametersKey.token: Constants.ParametersValue.token,
            Constants.ParametersKey.version: Constants.ParametersValue.version
        ]
        AF.request(urlPath, parameters: parametrs).responseJSON { response in
            print(response.value ?? "")
        }
    }

    func fetchUserGroups() {
        let urlPath = "\(Constants.baseURL)\(Constants.getUserGroupPath)"
        let parametrs: Parameters = [
            Constants.ParametersKey.userID: Constants.ParametersValue.userID,
            Constants.ParametersKey.extended: Constants.ParametersValue.extended,
            Constants.ParametersKey.token: Constants.ParametersValue.token,
            Constants.ParametersKey.version: Constants.ParametersValue.version
        ]
        AF.request(urlPath, parameters: parametrs).responseJSON { response in
            print(response.value ?? "")
        }
    }

    func fetchGroup(q searchText: String) {
        let urlPath = "\(Constants.baseURL)\(Constants.getGroupPath)"
        let parametrs: Parameters = [
            Constants.ParametersKey.query: searchText,
            Constants.ParametersKey.token: Constants.ParametersValue.token,
            Constants.ParametersKey.version: Constants.ParametersValue.version
        ]
        AF.request(urlPath, parameters: parametrs).responseJSON { response in
            print(response.value ?? "")
        }
    }
}
