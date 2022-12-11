// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Расширение для получения фото друга
extension UIImageView {
    func load(url: String?) {
        guard let url = url else { return }
        DispatchQueue.global().async {
            let image = PhotoCacheService.shared.getImage(url: url)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
