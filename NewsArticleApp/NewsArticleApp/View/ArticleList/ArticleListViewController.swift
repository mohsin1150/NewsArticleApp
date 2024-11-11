//
//  ArticleListViewController.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 10/11/24.
//

import UIKit
import RxSwift

class ArticleListViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchIconView: UIImageView!
    @IBOutlet weak var articleListContainerView: UIView!
    @IBOutlet weak var articleListTableView: UITableView!

    private let viewModel: ArticleListViewModel = ArticleListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configTheme()
        addBindsToViewModel()
        setUpTableView()
        fetchDataFromAPI()
    }
}

extension ArticleListViewController {

    private func configTheme() {
        titleLabel.textColor = UIColor(hex: "#000000")
        titleLabel.font = UIFont(name: "Roboto-Bold", size: 30)
        titleLabel.text = "Articles"
        searchIconView.image = UIImage(named: "searchIcon")
    }

    private func setUpTableView() {
        articleListTableView.register(cellType: ArticleDataTableViewCell.self)
        articleListTableView.separatorStyle = .none
        articleListTableView.backgroundColor = .clear
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
    }

    private func fetchDataFromAPI() {
        viewModel.getArticleList()
    }

    private func addBindsToViewModel() {

        self.viewModel.showLoader.bind { [weak self] show in
            show ? self?.showLoader() : self?.hideLoader()
        }

        self.viewModel.articlesList.bind { [weak self] _ in
            self?.articleListTableView.reloadData()
        }
    }
}

extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articlesList.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ArticleDataTableViewCell.self)
        cell.articleData = viewModel.articlesList.value?[indexPath.row]
        self.downloadImage(with: viewModel.articlesList.value?[indexPath.row].urlToImage ?? "") { image in
            if let image = image {
                cell.imageIconView.image = image
            } else {
                cell.imageIconView.image = UIImage(named: "Placeholder Image")
            }
        }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Data: \(viewModel.articlesList.value?[indexPath.row].urlToImage ?? "")")
    }
}
