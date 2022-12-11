// PhotoCacheService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Кеширование изображений
final class PhotoCacheService {
    // MARK: - Private Enum

    private enum Constants {
        static let folderName = "ImagesFromVK"
        static let separatorCharacter = "/"
        static let defaultString: Substring = "default"
        static let pngText = ".png"
        static let defaultImageName = "photo"
    }

    // MARK: - Static Properties

    static let shared = PhotoCacheService()

    // MARK: - Public Properties

    var defaultImage: UIImage? = UIImage(systemName: Constants.defaultImageName)

    // MARK: - Private Properties

    private var imagesMap: [String: UIImage] = [:]

    // MARK: - Public Methods

    public func getImage(url: String) -> UIImage? {
        if let image = imagesMap[url] {
            return image
        } else if let image = getImageDrive(url: url) {
            return image
        } else {
            let image = loadImage(url: url)
            return image
        }
    }

    // MARK: - Private Methods

    private func getCacheFolderPath() -> URL? {
        guard let docsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
        let url = docsDirectory.appendingPathComponent(Constants.folderName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch {
                print(error)
            }
        }
        return url
    }

    private func getImagePath(url: String) -> String? {
        guard let folderUrl = getCacheFolderPath() else { return nil }
        let fileName = String(url.split(separator: Constants.separator).last ?? Constants.defaultString)
        return folderUrl.appendingPathComponent(fileName + Constants.png).path
    }

    private func getImageDrive(url: String) -> UIImage? {
        guard let filePath = getImagePath(url: url),
              let image = UIImage(contentsOfFile: filePath)
        else { return nil }
        return image
    }

    private func saveImageDrive(url: String, image: UIImage) {
        guard let filePath = getImagePath(url: url),
              let data = image.pngData()
        else { return }
        FileManager.default.createFile(atPath: filePath, contents: data)
    }

    private func loadImage(url: String) -> UIImage? {
        let data = NetworkService.fetchPhotoData(url: url)
        guard let image = UIImage(data: data) else { return defaultImage }
        imagesMap[url] = image
        saveImageDrive(url: url, image: image)
        return image
    }
}
