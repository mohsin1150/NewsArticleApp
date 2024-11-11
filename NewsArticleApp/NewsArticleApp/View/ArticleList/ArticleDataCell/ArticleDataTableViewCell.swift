//
//  ArticleDataTableViewCell.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 10/11/24.
//

import UIKit
import Reusable

class ArticleDataTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageIconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    var articleData: ArticleList? {
        didSet {
            titleLabel.text = articleData?.title ?? ""
            subTitleLabel.text = articleData?.description ?? ""
            let newFormatter = ISO8601DateFormatter()
            if let date = newFormatter.date(from: articleData?.publishedAt ?? "") {
                dateLabel.text = convertDateFormatter(date: "\(date)")
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        configTheme()
    }

    private func configTheme() {
        containerView.clipsToBounds = false
        containerView.layer.cornerRadius = 12
        mainView.layer.cornerRadius = 12
        mainView.clipsToBounds = true
        mainView.backgroundColor = UIColor(hex: "#83D4EE")
        mainView.dropShadow()

        titleLabel.textColor = UIColor(hex: "#000000")
        titleLabel.font = UIFont(name: "Roboto-Bold", size: 15)

        subTitleLabel.textColor = UIColor(hex: "#000000")
        subTitleLabel.font = UIFont(name: "Roboto-Regular", size: 8)

        dateLabel.textColor = UIColor(hex: "#9B9999")
        dateLabel.font = UIFont(name: "Roboto-Regular", size: 10)

        imageContainerView.clipsToBounds = false
        imageContainerView.layer.cornerRadius = 12
        imageContainerView.dropShadowToImage()

        imageIconView.contentMode = .scaleAspectFill
        imageIconView.clipsToBounds = true
        imageIconView.layer.cornerRadius = 12
    }
}
