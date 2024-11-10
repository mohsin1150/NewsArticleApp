//
//  ArticleDataTableViewCell.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 10/11/24.
//

import UIKit

class ArticleDataTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageIconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        configTheme()
    }

    private func configTheme() {
        self.mainView.layer.cornerRadius = 12
        self.mainView.backgroundColor = UIColor(
            named: "#83D4EE78"
        )?.withAlphaComponent(0.47)
        self.mainView.layer.shadowOpacity = 0.5
        self.mainView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.mainView.layer.shadowRadius = 3.0
        self.mainView.layer.shadowColor = UIColor.black.cgColor
        self.mainView.layer.masksToBounds = false
    }
}
