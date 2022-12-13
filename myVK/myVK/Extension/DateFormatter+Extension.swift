// DateFormatter+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// MARK: Private Methods

extension DateFormatter {
    static func convert(_ date: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy, HH:mm "
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
}
