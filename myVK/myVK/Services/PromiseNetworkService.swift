// PromiseNetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import PromiseKit
import RealmSwift

///  Сетевой слой
final class PromiseNetworkService {
    // MARK: - Constants

    private enum Constants {
        static let baseURL = "https://api.vk.com/method/"
        static let getFriendsPath = "friends.get"
        static let getPhotosPath = "photos.getAll"
        static let getUserGroupPath = "groups.get"
        static let getGroupPath = "groups.search"
        static let getNewsFeedPath = "newsfeed.get"

        enum ParametersKey {
            static let userID = "user_ids"
            static let token = "access_token"
            static let fields = "fields"
            static let filters = "filters"
            static let version = "v"
            static let ownerID = "owner_id"
            static let extended = "extended"
            static let query = "q"
        }

        enum ParametersValue {
            static let userID = Session.shared.userID
            static let token = Session.shared.token
            static let fields = "photo_100"
            static let filters = "post"
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
        case getNews

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
            case .getNews:
                return Constants.getNewsFeedPath
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
            case .getNews:
                return [Constants.ParametersKey.filters: Constants.ParametersValue.filters]
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

    func fetchFriends() -> Promise<[User]> {
        fetchData(.getFriends)
    }

    func fetchPhotos(ownerID: Int) -> Promise<[Photo]> {
        fetchData(.getPhotoAll(ownerID: ownerID))
    }

    func fetchUserGroups() -> Promise<[Group]> {
        fetchData(.getGroups)
    }

    func fetchGroup(query: String) -> Promise<[Group]> {
        fetchData(.getSearchedGroups(query: query))
    }

    func fetchNews() -> Promise<NewsResponse> {
        let urlPath = "\(Constants.baseURL)\(ApiMethod.getNews.path)"
        let parametrs = ApiMethod.getNews.parametrs.merging(Constants.baseParameters) { _, _ in }
        let promise = Promise<NewsResponse> { resolver in
            AF.request(urlPath, parameters: parametrs).responseData { response in
                guard let data = response.data else { return }
                do {
                    let response = try JSONDecoder().decode(NewsResponse.self, from: data)
                    resolver.fulfill(response.self)
                } catch {
                    resolver.reject(error)
                }
            }
        }
        return promise
    }

    func getRequest(_ method: ApiMethod) -> DataRequest {
        let urlPath = "\(Constants.baseURL)\(method.path)"
        let parametrs = method.parametrs.merging(Constants.baseParameters) { _, _ in }
        return AF.request(urlPath, parameters: parametrs)
    }

    // MARK: - Private Methods

    private func getData(_ request: DataRequest) -> Data {
        var data = Data()
        request.responseData { response in
            guard let fetchData = response.data else { return }
            data = fetchData
        }
        return data
    }

    private func parseData<T: Decodable>(_ data: Data) -> [T] {
        do {
            let response = try JSONDecoder().decode(Response<T>.self, from: data)
            return response.items
        } catch {
            return []
        }
    }

    private func fetchData<T: Decodable>(_ method: ApiMethod) -> Promise<[T]> {
        let urlPath = "\(Constants.baseURL)\(method.path)"
        let parametrs = method.parametrs.merging(Constants.baseParameters) { _, _ in }
        let promise = Promise<[T]> { resolver in
            AF.request(urlPath, parameters: parametrs).responseData { response in
                guard let data = response.data else { return }
                do {
                    let response = try JSONDecoder().decode(Response<T>.self, from: data)
                    resolver.fulfill(response.items)
                } catch {
                    resolver.reject(error)
                }
            }
        }
        return promise
    }
}
