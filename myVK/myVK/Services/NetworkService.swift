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
            static let startTime = "start_time"
            static let nextFrom = "next_from"
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
        case getNews(startTime: Double, nextFrom: String = "")

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
            case let .getNews(startTime, nextFrom):
                return [
                    Constants.ParametersKey.startTime: startTime,
                    Constants.ParametersKey.nextFrom: nextFrom,
                    Constants.ParametersKey.filters: Constants.ParametersValue.filters
                ]
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

    func fetchFriends(completion: @escaping (Result<[User], Error>) -> Void) {
        fetchData(.getFriends, completion: completion)
    }

    func fetchPhotos(ownerID: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        fetchData(.getPhotoAll(ownerID: ownerID), completion: completion)
    }

    func fetchUserGroups(completion: @escaping (Result<[Group], Error>) -> Void) {
        fetchData(.getGroups, completion: completion)
    }

    func fetchGroup(query: String, completion: @escaping (Result<[Group], Error>) -> Void) {
        fetchData(.getSearchedGroups(query: query), completion: completion)
    }

    func fetchNews(
        startTime: Double,
        nextFrom: String = "",
        completion: @escaping (Result<NewsResponse, Error>) -> Void
    ) {
        let urlPath = "\(Constants.baseURL)\(ApiMethod.getNews(startTime: startTime, nextFrom: nextFrom).path)"
        let parametrs = ApiMethod.getNews(startTime: startTime, nextFrom: nextFrom).parametrs
            .merging(Constants.baseParameters) { _, _ in }
        AF.request(urlPath, parameters: parametrs).responseData { response in
            guard let data = response.data else { return }
            do {
                let response = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
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

    private func fetchData<T: Decodable>(_ method: ApiMethod, completion: @escaping (Result<[T], Error>) -> Void) {
        let urlPath = "\(Constants.baseURL)\(method.path)"
        let parametrs = method.parametrs.merging(Constants.baseParameters) { _, _ in }
        AF.request(urlPath, parameters: parametrs).responseData { response in
            guard let data = response.data else { return }
            do {
                let response = try JSONDecoder().decode(Response<T>.self, from: data)
                completion(.success(response.items))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
