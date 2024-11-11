//
//  UIView+Extensions.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 11/11/24.
//

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    func dropShadowToImage() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 12
        layer.shadowPath = UIBezierPath(
            roundedRect: self.bounds, cornerRadius: 12
        ).cgPath
    }
}
