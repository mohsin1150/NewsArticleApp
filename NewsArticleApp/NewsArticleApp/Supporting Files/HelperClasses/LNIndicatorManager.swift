//
//  LNIndicatorManager.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 11/11/24.
//

import UIKit
import NVActivityIndicatorView

final class LNIndicatorManager {

    static let shared: LNIndicatorManager = LNIndicatorManager()

    private var indicatorView: NVActivityIndicatorView?
    private var containerView: UIView?

    private init() { }

    func getWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            return (
                UIApplication.shared.connectedScenes.first as? UIWindowScene
            )?.windows.first
        } else {
            return UIApplication.shared.keyWindow
        }
    }

    func showIndicator(indicatorColor: UIColor = .gray, size: CGFloat = 50, onView: UIView) {
        if containerView == nil {
            containerView = UIView()
            indicatorView = NVActivityIndicatorView(frame: .zero, type: .ballSpinFadeLoader, color: indicatorColor)

            guard let indicatorView = indicatorView else { return }
            guard let containerView = containerView else { return }

            containerView.addSubview(indicatorView)
            indicatorView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                indicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                indicatorView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                indicatorView.heightAnchor.constraint(equalToConstant: size),
                indicatorView.widthAnchor.constraint(equalToConstant: size)
            ])

            indicatorView.startAnimating()

            containerView.backgroundColor = .clear
            containerView.frame = onView.window?.bounds ?? onView.frame
            containerView.backgroundColor = .white.withAlphaComponent(0.5)
            onView.addSubview(containerView)
        }
    }

    func hideIndicator() {
        indicatorView?.removeFromSuperview()
        indicatorView = nil
        containerView?.removeFromSuperview()
        containerView = nil
    }
}
