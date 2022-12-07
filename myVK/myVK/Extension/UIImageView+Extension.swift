// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Расширение для получения фото друга
extension UIImageView {
    func load(url: String?) {
        guard let url = url else { return }
        DispatchQueue.global().async {
            let data = NetworkService.fetchPhotoData(url: url)
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
