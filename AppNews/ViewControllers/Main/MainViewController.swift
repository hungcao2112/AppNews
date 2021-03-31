//
//  MainViewController.swift
//  AppNews
//
//  Created by Hung Cao on 31/03/2021.
//

import UIKit
import MJRefresh

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var articles: [Article] = []
    private var page: Int = 1
    
    private var articleService = ArticleService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPullToRefresh()
        setupLoadMore()
        getArticles(page: page)
    }
    
    private func setupTableView() {
        tableView.register(UINib(resource: R.nib.newsTableViewCell), forCellReuseIdentifier: R.reuseIdentifier.newsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func getArticles(page: Int , isShowLoading: Bool = true) {
        isShowLoading ? self.showLoading() : ()
        articleService.getArticles(page: page) { (articles) in
            guard let articles = articles else {
                return
            }
            self.articles.append(contentsOf: articles)
            self.tableView.reloadData()
            self.hideAllLoading()
        } onFailure: { (error) in
            if let error = error as? BaseError {
                self.showErrorAlert(error.message)
            }
            if let error = error as? ApiErrorType {
                self.showErrorAlert(error.localizedDescription)
            }
            else {
                self.showErrorAlert(error?.localizedDescription)
            }
            self.hideAllLoading()
        }
    }
    
    private func hideAllLoading() {
        self.hideLoading()
        self.tableView.mj_header?.endRefreshing()
        self.tableView.mj_footer?.endRefreshing()
    }
    
    private func setupPullToRefresh() {
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.onPullToRefresh))
        header.stateLabel?.isHidden = true
        header.lastUpdatedTimeLabel?.isHidden = true
        self.tableView.mj_header = header
    }
    
    private func setupLoadMore() {
        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.onLoadMore))
        footer.stateLabel?.isHidden = true
        footer.isRefreshingTitleHidden = true
        self.tableView.mj_footer = footer
    }
    
    @objc private func onPullToRefresh() {
        self.page = 1
        getArticles(page: page, isShowLoading: false)
    }
    
    @objc private func onLoadMore() {
        self.page += 1
        getArticles(page: page, isShowLoading: false)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.newsTableViewCell, for: indexPath)!
        cell.article = articles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = R.storyboard.main.detailViewController()!
        detailVC.article = articles[indexPath.row]
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
