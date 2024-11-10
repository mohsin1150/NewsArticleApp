//
//  Alert.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 10/11/24.
//

import UIKit
class Alert: NSObject {
    typealias CompletionHandler = (() -> Swift.Void)?
    func showWarningAlert(
        withTitle title: String,
        withMessage message: String,
        inView view: UIViewController,
        time: Double,
        completionHandler: CompletionHandler) {
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