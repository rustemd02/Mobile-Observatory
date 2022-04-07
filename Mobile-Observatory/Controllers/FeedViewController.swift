//
//  FeedViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 26.03.2022.
//

import UIKit

class FeedViewController: UIViewController, UIScrollViewDelegate {
    let api = NetworkService.shared
    var howManyArticlesToSkip = 100
    private var isFetching = false
    var flag: Bool = false
    private var articleFetch = ArticleFetchController()
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadArticles()
        
        self.feedTableView.register(UINib.init(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        self.feedTableView.register(UINib.init(nibName: "WeatherOnMarsTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherOnMarsTableViewCell")
        
        feedTableView.delegate = self
        feedTableView.prefetchDataSource = self
        
        feedTableView.refreshControl = UIRefreshControl()
        feedTableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc private func didPullToRefresh() {
        howManyArticlesToSkip = 0
        loadArticles()
        feedTableView.reloadData()
        self.feedTableView.refreshControl?.endRefreshing()
    }
    
    private func loadArticles() {
        isFetching = true
        articleFetch.getArticles(howManySkip: howManyArticlesToSkip) { [weak self] in
            self?.feedTableView.dataSource = self
            self?.feedTableView.reloadData()
        }
        isFetching = false
    }
    
    
}

extension FeedViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= (articleFetch.articlesData.count - 3) && !isFetching {
                howManyArticlesToSkip+=10
                print(howManyArticlesToSkip)
                loadArticles()
                break
            }
        }
    }
    
    
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleFetch.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherOnMarsTableViewCell", for: indexPath) as? WeatherOnMarsTableViewCell else {
        //            return UITableViewCell()
        //        }
        //        cell.backgroundImageView.layer.cornerRadius = 20
        //        cell.configure()
        //        return cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        let article = articleFetch.cellForRowAt(indexPath: indexPath)
        cell.configure(article: article)
        return cell
    }
    
    
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articleFetch.cellForRowAt(indexPath: indexPath)
        let sb = UIStoryboard(name: "Feed", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "ArticleDetailViewController") as! ArticleDetailViewController
        vc.article = article
        navigationController?.pushViewController(vc, animated: true)
    }
}
