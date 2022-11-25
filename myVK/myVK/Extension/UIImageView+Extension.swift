// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Расширение для получения фото друга
extension UIImageView {
    func load(url: String) {
        guard let url = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
