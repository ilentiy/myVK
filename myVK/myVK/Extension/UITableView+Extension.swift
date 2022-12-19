// UITableView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Добавляет сообщение о пустой или не пустой таблице
extension UITableView {
    func showEmptyMessage(_ message: String) {
        let messageLabel = UILabel()
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        backgroundView = messageLabel
    }

    func hideEmptyMessage() {
        backgroundView = nil
    }
}
