//
//  UIViewController+Extensions.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 11/11/24.
//

import UIKit
import Kingfisher
import NVActivityIndicatorView

extension UIViewController {
    func showLoader(indicatorColor: UIColor = .gray) {
        let window = LNIndicatorManager.shared.getWindow() ?? self.view
        LNIndicatorManager.shared.showIndicator(indicatorColor: indicatorColor,
                                                onView: window ?? self.view)
    }

    func hideLoader() {
        LNIndicatorManager.shared.hideIndicator()
    }

    func downloadImage(with urlString : String , imageCompletionHandler: @escaping (UIImage?) -> Void) {
        guard let url = URL.init(string: urlString) else {
            return  imageCompletionHandler(nil)
        }
        let resource = KF.ImageResource(downloadURL: url)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                imageCompletionHandler(value.image)
            case .failure:
                imageCompletionHandler(nil)
            }
        }
    }
}
