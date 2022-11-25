// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import RealmSwift
import SwiftyJSON

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
            static let fields = "photo_100"
            static let extended = "1"
            static let version = "5.131"
        }
    }

    // MARK: - Public Method

    func fetchFriends(completion: @escaping ([User]) -> Void) {
        let urlPath = "\(Constants.baseURL)\(Constants.getFriendsPath)"
        let parametrs: Parameters = [
            Constants.ParametersKey.userID: Constants.ParametersValue.userID,
            Constants.ParametersKey.fields: Constants.ParametersValue.fields,
            Constants.ParametersKey.token: Constants.ParametersValue.token,
            Constants.ParametersKey.version: Constants.ParametersValue.version
        ]

        AF.request(urlPath, parameters: parametrs).responseData { [weak self] response in
            guard
                let data = response.value
            else { return }
            do {
                let response = try JSONDecoder().decode(UserResult.self, from: data).response
                let users = response.users
                completion(users)
            } catch {
                completion([])
            }
        }
    }

    func fetchPhotos(ownerID: Int, completion: @escaping ([Photo]) -> Void) {
        let urlPath = "\(Constants.baseURL)\(Constants.getPhotosPath)"
        let parametrs: Parameters = [
            Constants.ParametersKey.ownerID: ownerID,
            Constants.ParametersKey.token: Constants.ParametersValue.token,
            Constants.ParametersKey.version: Constants.ParametersValue.version
        ]
        AF.request(urlPath, parameters: parametrs).responseData { [weak self] response in
            guard
                let data = response.value
            else { return }
            do {
                let response = try JSONDecoder().decode(PhotoResult.self, from: data).response
                let photos = response.photos
                completion(photos)
            } catch {
                completion([])
            }
        }
    }

    func fetchUserGroups(completion: @escaping ([Group]) -> Void) {
        let urlPath = "\(Constants.baseURL)\(Constants.getUserGroupPath)"
        let parametrs: Parameters = [
            Constants.ParametersKey.userID: Constants.ParametersValue.userID,
            Constants.ParametersKey.extended: Constants.ParametersValue.extended,
            Constants.ParametersKey.token: Constants.ParametersValue.token,
            Constants.ParametersKey.version: Constants.ParametersValue.version
        ]
        AF.request(urlPath, parameters: parametrs).responseData { [weak self] response in
            guard
                let data = response.value
            else { return }
            do {
                let response = try JSONDecoder().decode(GroupResult.self, from: data).response
                let groups = response.groups
                completion(groups)
            } catch {
                completion([])
            }
        }
    }

    func fetchGroup(q searchText: String, completion: @escaping ([Group]) -> Void) {
        let urlPath = "\(Constants.baseURL)\(Constants.getGroupPath)"
        let parametrs: Parameters = [
            Constants.ParametersKey.query: searchText,
            Constants.ParametersKey.token: Constants.ParametersValue.token,
            Constants.ParametersKey.version: Constants.ParametersValue.version
        ]
        AF.request(urlPath, parameters: parametrs).responseData { [weak self] response in
            guard
                let data = response.value
            else { return }
            do {
                let response = try JSONDecoder().decode(GroupResult.self, from: data).response
                let groups = response.groups
                print(groups)
                completion(groups)
            } catch {
                completion([])
            }
        }
    }

    func saveUsersData(_ users: [User]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(users)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
