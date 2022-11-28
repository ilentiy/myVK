// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import RealmSwift

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

        static let baseParameters: Parameters = [
            Constants.ParametersKey.token: Constants.ParametersValue.token,
            Constants.ParametersKey.version: Constants.ParametersValue.version
        ]
    }

    enum ApiMethod {
        case getFriends
        case getPhotoAll(ownerID: Int)
        case getGroups
        case getSearchedGroups(query: String)

        var path: String {
            switch self {
            case .getFriends:
                return Constants.getFriendsPath
            case .getPhotoAll:
                return Constants.getPhotosPath
            case .getGroups:
                return Constants.getUserGroupPath
            case .getSearchedGroups:
                return Constants.getGroupPath
            }
        }

        var parametrs: Parameters {
            switch self {
            case .getFriends:
                return [
                    Constants.ParametersKey.userID: Constants.ParametersValue.userID,
                    Constants.ParametersKey.fields: Constants.ParametersValue.fields,
                ]
            case let .getPhotoAll(ownerID):
                return [Constants.ParametersKey.ownerID: ownerID]
            case .getGroups:
                return [
                    Constants.ParametersKey.userID: Constants.ParametersValue.userID,
                    Constants.ParametersKey.extended: Constants.ParametersValue.extended,
                ]
            case let .getSearchedGroups(query):
                return [Constants.ParametersKey.query: query]
            }
        }
    }

    // MARK: - Public Method

    static func fetchPhotoData(url: String) -> Data {
        guard let url = URL(string: url),
              let data = try? Data(contentsOf: url)
        else { return Data() }
        return data
    }

    func fetchFriends(completion: @escaping ([User]) -> Void) {
        request(.getFriends) { data in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(Response<User>.self, from: data)
                completion(response.items)
            } catch {
                completion([])
            }
        }
    }

    func fetchPhotos(ownerID: Int, completion: @escaping ([Photo]) -> Void) {
        request(.getPhotoAll(ownerID: ownerID)) { data in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(Response<Photo>.self, from: data)
                completion(response.items)
            } catch {
                completion([])
            }
        }
    }

    func fetchUserGroups(completion: @escaping ([Group]) -> Void) {
        request(.getGroups) { data in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(Response<Group>.self, from: data)
                completion(response.items)
            } catch {
                completion([])
            }
        }
    }

    func fetchGroup(query: String, completion: @escaping ([Group]) -> Void) {
        request(.getSearchedGroups(query: query)) { data in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(Response<Group>.self, from: data)
                completion(response.items)
            } catch {
                completion([])
            }
        }
    }

    // MARK: - Private Methods

    private func request(_ method: ApiMethod, completion: @escaping (Data?) -> Void) {
        let urlPath = "\(Constants.baseURL)\(method.path)"
        let parametrs = method.parametrs.merging(Constants.baseParameters) { _, _ in }
        AF.request(urlPath, parameters: parametrs).responseData { response in
            if let data = response.data {
                completion(data)
            }
        }
    }
}
