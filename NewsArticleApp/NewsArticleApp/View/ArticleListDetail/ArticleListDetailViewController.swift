//
//  ArticleListDetailViewController.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 11/11/24.
//

import UIKit
import SafariServices

class ArticleListDetailViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backIconView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var heartIconView: UIImageView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleHeading: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    private var isfilled: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()


        configTheme()
        addGestureBackView()
        addGestureImageView()
    }

    var articleData: ArticleList?
}

extension ArticleListDetailViewController {

    private func configTheme() {
        topView.backgroundColor = UIColor(hex: "#8A2F76")
        backIconView.image = UIImage(named: "Back")
        heartIconView.image = UIImage(named: "heart")

        textView.textColor = UIColor(hex: "#8C8E98")
        textView.font = UIFont(name: "Roboto-Regular", size: 14)
        textView.text = articleData?.content ?? ""

        headerTitleLabel.textColor = UIColor(hex: "#FFFFFF")
        headerTitleLabel.font = UIFont(name: "Roboto-Regular", size: 16)
        headerTitleLabel.text = articleData?.author ?? ""

        titleHeading.textColor = UIColor(hex: "#FFFFFF")
        titleHeading.font = UIFont(name: "Roboto-Bold", size: 24)
        titleHeading.text = articleData?.title ?? ""

        dateLabel.textColor = UIColor(hex: "#A7AEC1")
        dateLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        let newFormatter = ISO8601DateFormatter()
        if let date = newFormatter.date(from: articleData?.publishedAt ?? "") {
            dateLabel.text = convertDateFormatter(date: "\(date)")
        }

        imageContainerView.clipsToBounds = false
        imageContainerView.layer.cornerRadius = 12
        imageContainerView.dropShadowToImage()

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12

        downloadImage(with: articleData?.urlToImage ?? "") { [weak self] image in
            if let image = image {
                self?.imageView.image = image
            } else {
                self?.imageView.image = UIImage(
                    named: "Placeholder Image"
                )
            }
        }
    }
}

extension ArticleListDetailViewController {

    private func addGestureBackView() {
         let viewTap = UITapGestureRecognizer(
             target: self,
             action: #selector(self.dismiss(_:))
         )
        self.backIconView.isUserInteractionEnabled = true
         self.backIconView.addGestureRecognizer(viewTap)
     }

    @objc func dismiss(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }

    private func addGestureImageView() {
         let viewTap = UITapGestureRecognizer(
             target: self,
             action: #selector(self.openURL(_:))
         )
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(viewTap)
     }

    @objc func openURL(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: articleData?.url ?? "") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let safariController = SFSafariViewController(url: url, configuration: config)
            safariController.title = articleData?.title ?? ""
            self.present(safariController, animated: true)
        }
    }
}
