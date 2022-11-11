// LoaderView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью загрузки
final class LoaderView: UIView {
    // MARK: - Private Visual Components

    private var stackView: UIStackView?
    private lazy var pointImageViews: [UIImageView] = []

    // MARK: - PUblic Methods

    override func layoutSubviews() {
        stackView?.frame = bounds
    }

    func setupUI() {
        for _ in 0 ..< 3 {
            let view = UIImageView()
            view.image = UIImage(named: Constants.ImageNameText.logo)
            view.backgroundColor = .clear
            view.tintColor = .white
            view.alpha = 0.33
            view.heightAnchor.constraint(equalToConstant: bounds.height - 5).isActive = true
            view.layer.cornerRadius = (bounds.height - 5) / 2
            view.layer.masksToBounds = true
            pointImageViews.append(view)
        }
        configureStackView()
    }

    private func configureStackView() {
        stackView = UIStackView(arrangedSubviews: pointImageViews)
        guard let stackView = stackView else { return }
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        addSubview(stackView)
        animatePoints()
    }

    private func animatePoints() {
        var delay = 0.0
        pointImageViews.forEach { point in
            delay += 0.3
            self.makeOpacity(for: point, delay: delay)
        }
    }

    private func makeOpacity(for view: UIImageView, delay: Double) {
        let animation = CABasicAnimation(keyPath: Constants.KeyPath.opacity)
        animation.fromValue = 1
        animation.toValue = 0.33
        animation.duration = 0.7
        animation.beginTime = CACurrentMediaTime() + delay
        animation.repeatCount = .infinity
        animation.fillMode = .backwards
        animation.autoreverses = true
        view.layer.add(animation, forKey: nil)
    }
}
