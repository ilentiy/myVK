// ShadowView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// добавляет вью с тенью
@IBDesignable final class ShadowView: UIView {
    // MARK: - Layer Class

    override class var layerClass: AnyClass {
        CAShapeLayer.self
    }

    // MARK: - Private properties

    @IBInspectable private var shadowRadius: CGFloat = 5 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable private var shadowOpacity: Float = 0.6 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable private var shadowColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }

    // MARK: - Public Methods

    func configureShadow() {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }
}
