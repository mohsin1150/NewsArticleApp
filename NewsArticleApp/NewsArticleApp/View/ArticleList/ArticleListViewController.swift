//
//  ArticleListViewController.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 10/11/24.
//

import UIKit

class ArticleListViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchIconView: UIImageView!
    @IBOutlet weak var articleListContainerView: UIView!
    @IBOutlet weak var articleListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configTheme()
    }
}

extension ArticleListViewController {

    private func configTheme() {
        titleLabel.textColor = UIColor(named: "#000000")
        titleLabel.font = UIFont(name: "Roboto-Bold", size: 30)
        titleLabel.text = "Articles"
        searchIconView.image = UIImage(named: "searchIcon")
    }
}
