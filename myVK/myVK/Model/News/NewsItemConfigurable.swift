// NewsItemConfigurable.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

typealias NewsCell = UITableViewCell & NewsItemConfigurable

protocol NewsItemConfigurable {
    func configure(item: News)
}
