//
//  UIViewController+Extensions.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 11/11/24.
//

import UIKit
import Alamofire
import Kingfisher

extension UIViewController {

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

    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class Alert: NSObject {
    typealias CompletionHandler = (() -> Swift.Void)?
    func showWarningAlert(withTitle title: String, withMessage message: String, inView view: UIViewController, time: Double, completionHandler: CompletionHandler) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        view.present(alertController, animated: true, completion: {})
        let when = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: when) {
            alertController.dismiss(animated: true, completion: {
                completionHandler?()
            })
        }
    }
}
