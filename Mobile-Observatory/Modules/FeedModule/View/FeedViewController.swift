//
//  FeedViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 26.03.2022.
//

import UIKit

protocol ViewControllerInput: AnyObject {
    func updateView(with items: [Post])
    func showError()
    func loadArticles()
}

protocol ViewControllerOutput {
    func viewDidLoad()
    func didSelectRow(at: Int)
    func getArticles(howManySkip: Int, completion: @escaping () -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt (indexPath: IndexPath) -> Article
    func getArticlesData() -> [Article]
}

class FeedViewController: UIViewController, UIScrollViewDelegate {
    let api = NetworkService.shared
    private var output: ViewControllerOutput
    var howManyArticlesToSkip = 0
    private var isFetching = false
    var feedTableView = UITableView()
    
    
    init(output: ViewControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
        
        setupView()
        loadArticles()
        feedTableView.delegate = self
        feedTableView.prefetchDataSource = self
        self.feedTableView.register(UINib.init(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        self.feedTableView.register(UINib.init(nibName: "WeatherOnMarsTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherOnMarsTableViewCell")
        
        feedTableView.refreshControl = UIRefreshControl()
        feedTableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    private func setupView() {
        title = "Лента"
        view.backgroundColor = .white
        
        self.navigationItem.title = "Лента"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        feedTableView = UITableView(frame: view.bounds, style: .plain)
        feedTableView.delegate = self
        feedTableView.register(UINib.init(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        view.addSubview(feedTableView)
        feedTableView.snp.makeConstraints{ maker in
            maker.top.equalToSuperview().inset(100)
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        
    }
   
    
    @objc private func didPullToRefresh() {
        howManyArticlesToSkip = 0
        loadArticles()
        feedTableView.reloadData()
        self.feedTableView.refreshControl?.endRefreshing()
    }
    
    private func loadArticles() {
        isFetching = true
        output.getArticles(howManySkip: howManyArticlesToSkip) { [weak self] in
            self?.feedTableView.dataSource = self
            self?.feedTableView.reloadData()
        }
        isFetching = false
    }
    
    
}



extension FeedViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= (output.getArticlesData().count - 3) && !isFetching {
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
        return output.numberOfRowsInSection(section: section)
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
        let article = output.cellForRowAt(indexPath: indexPath)
        cell.configure(article: article)
        return cell
    }
    
    
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = output.cellForRowAt(indexPath: indexPath)
        let sb = UIStoryboard(name: "Feed", bundle: nil)
        // swiftlint:disable:next force_cast
        let vc = sb.instantiateViewController(identifier: "ArticleDetailViewController") as! ArticleDetailViewController
        vc.article = article
        navigationController?.pushViewController(vc, animated: true)
        //к аутпуту
    }
}
