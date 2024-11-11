//
//  ArticleListViewController.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 10/11/24.
//

import UIKit
import ProgressHUD

class ArticleListViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchIconView: UIImageView!
    @IBOutlet weak var articleListContainerView: UIView!
    @IBOutlet weak var articleListTableView: UITableView!

    private let viewModel: ArticleListViewModel = ArticleListViewModel()
    private var refreshControl: UIRefreshControl!
    private var isFirst: Bool = true

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

        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        articleListTableView.addSubview(refreshControl)
    }

    @objc func refresh(sender _: AnyObject) {
        viewModel.getArticleList()
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

        self.viewModel.showLoader.bind { show in
            show ? ProgressHUD.progress("Loading...", 1.0) : ProgressHUD.succeed()
            self.refreshControl.endRefreshing()
            if !(self.isConnectedToInternet()) {
                Alert().showWarningAlert(
                    withTitle: "Network Disabled",
                    withMessage: "Please check your internet",
                    inView: self,
                    time: 4.0) {
                        self.refreshControl.endRefreshing()
                    }
            }
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
        let articleDetailController = self.storyboard?.instantiateViewController(
            withIdentifier: "articleListDetailViewController"
        ) as! ArticleListDetailViewController
        articleDetailController.articleData = viewModel.articlesList.value?[indexPath.row]
        articleDetailController.modalPresentationStyle = .fullScreen
        self.present(articleDetailController, animated: true, completion: nil)
    }
}
