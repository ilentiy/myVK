// FriendPhotosViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Экран с перелистыванием фото
final class FriendPhotosViewController: UIViewController {
    // MARK: - Private Visual Components

    @IBOutlet private var photoImageView: UIImageView!

    // MARK: - Public Properties

    var photoNames: [String] = []
    var currentPhotoIndex = 0

    // MARK: - Private property

    private var interactiveAnimator: UIViewPropertyAnimator!

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        changeColorBars(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        changeColorBars(false)
    }

    // MARK: - Private Methods

    private func changeColorBars(_ isBlack: Bool) {
        if isBlack {
            tabBarController?.tabBar.isHidden = true
            navigationController?.navigationBar.backgroundColor = .black
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar
                .titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else {
            tabBarController?.tabBar.isHidden = false
            navigationController?.navigationBar.backgroundColor = .white
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar
                .titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }
    }

    private func configureTitle() {
        title = "\(currentPhotoIndex + 1) из \(photoNames.count)"
        let panGecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPanAction))
        view.addGestureRecognizer(panGecognizer)
        photoImageView.image = UIImage(named: photoNames[currentPhotoIndex])
    }

    private func createGesture() {}

    @objc func onPanAction(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveAnimator?.startAnimation()
            interactiveAnimator = UIViewPropertyAnimator(
                duration: 1,
                curve: .easeInOut,
                animations: {
                    self.photoImageView.alpha = 0.5
                }
            )
            interactiveAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: view)
            interactiveAnimator.pauseAnimation()

            interactiveAnimator.fractionComplete = abs(translation.x / 100)
            photoImageView.transform = CGAffineTransform(translationX: translation.x, y: 0)
                .concatenating(CGAffineTransform(
                    scaleX: 1 - abs(translation.x / 1000),
                    y: 1 - abs(translation.x / 1000)
                ))

        case .ended:
            interactiveAnimator.stopAnimation(true)
            var viewWidth = view.frame.width
            if recognizer.translation(in: view).x < 0 {
                currentPhotoIndex = currentPhotoIndex < photoNames.count - 1 ? currentPhotoIndex + 1 :
                    currentPhotoIndex
            } else {
                currentPhotoIndex = currentPhotoIndex != 0 ? currentPhotoIndex - 1 : currentPhotoIndex
                viewWidth *= -1
            }
            photoImageView.transform = CGAffineTransform(translationX: viewWidth, y: 0)
                .concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
            interactiveAnimator.addAnimations {
                self.photoImageView.alpha = 1
                self.photoImageView.transform = .identity
            }
            interactiveAnimator?.startAnimation()

        default: break
        }
        photoImageView.image = UIImage(named: photoNames[currentPhotoIndex])
        title = "\(currentPhotoIndex + 1) из \(photoNames.count)"
    }
}
