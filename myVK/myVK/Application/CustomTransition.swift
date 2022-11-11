// CustomTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомные анимации для перехода между контроллерами.

final class PushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        1
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }

        let containerViewFrame = transitionContext.containerView.frame
        let destinationViewFrame = CGRect(
            x: 0,
            y: 0,
            width: containerViewFrame.width,
            height: containerViewFrame.height
        )

        let sourceViewFrame = destination.view.frame

        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(source.view)

        destination.view.transform = CGAffineTransform(rotationAngle: -(.pi / 2))
        destination.view.frame = CGRect(
            x: containerViewFrame.width,
            y: 0,
            width: containerViewFrame.height,
            height: containerViewFrame.width
        )
        UIView.animate(
            withDuration: 1,
            animations: {
                destination.view
                    .transform = CGAffineTransform(rotationAngle: .pi / 2)
                source.view.frame = destinationViewFrame
                destination.view.transform = .identity
                destination.view.frame = sourceViewFrame
            },
            completion: { finished in
                transitionContext.completeTransition(finished)
            }
        )
    }
}

final class PopTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        1
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }

        let containerViewFrame = transitionContext.containerView.frame
        let sourceiewFrame = containerViewFrame

        let destinationViewFrame = CGRect(
            x: containerViewFrame.height,
            y: 0,
            width: containerViewFrame.height,
            height: containerViewFrame.width
        )

        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)

        UIView.animate(
            withDuration: 1,
            animations: {
                source.view.frame = destinationViewFrame
                source.view.transform = CGAffineTransform(rotationAngle: -(.pi / 2))

                destination.view.transform = .identity
                destination.view.frame = sourceiewFrame
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            }
        )
    }
}

/// Отслеживание жеста
final class InteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Visual Component

    var viewController: UIViewController? {
        didSet {
            let gesture = UIScreenEdgePanGestureRecognizer(
                target: self,
                action: #selector(handleScreenEdgeGestureAction)
            )
            gesture.edges = [.left]
            viewController?.view.addGestureRecognizer(gesture)
        }
    }

    // MARK: - PUblic Properties

    var isStarted = false
    var isFinish = false

    // MARK: Private Methods

    @objc private func handleScreenEdgeGestureAction(
        _ recognizer:
        UIScreenEdgePanGestureRecognizer
    ) {
        switch recognizer.state {
        case .began:
            isStarted = true
            viewController?.navigationController?.popViewController(
                animated:
                true
            )
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.y / (
                recognizer.view?.bounds.width
                    ?? 1
            )
            let progress = max(0, min(1, relativeTranslation))
            isStarted = progress > 0.33
            update(progress)
        case .ended:
            isStarted = false
            if isFinish { finish()
            } else {
                cancel()
            }
        case .cancelled:
            isStarted = false
            cancel()
        default: return
        }
    }
}
