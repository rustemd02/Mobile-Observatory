//
//  FeedViewController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 26.03.2022.
//

import UIKit

protocol FeedViewControllerInput: AnyObject {
    func updateView(with items: [Post])
    func showError()
    func loadArticles()
}

protocol FeedViewControllerOutput {
    func viewDidLoad()
    func didSelectRow(at: Int)
    func getData(howManySkip: Int, sol: String, completion: @escaping () -> ())
//    func getArticles(howManySkip: Int, completion: @escaping () -> ())
//    func getWeatherOnMars(sol: Int, completion: @escaping () -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt (indexPath: IndexPath) -> Post
    func getPostsData() -> [Post]
    func savePost(post: Post)
    func removePostFromSaved(post: Post)
}

class FeedViewController: UIViewController, UIScrollViewDelegate {
    let api = NetworkService.shared
    private var output: FeedViewControllerOutput
    var howManyArticlesToSkip = 0
    private var isFetching = false
    var feedTableView = UITableView()
    
    
    init(output: FeedViewControllerOutput) {
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
        loadData()
        feedTableView.prefetchDataSource = self
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
        feedTableView.register(UINib.init(nibName: "WeatherOnMarsTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherOnMarsTableViewCell")
        view.addSubview(feedTableView)
        feedTableView.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide)
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        
    }
    
    @objc private func didPullToRefresh() {
        howManyArticlesToSkip = 0
        loadData()
        feedTableView.reloadData()
        self.feedTableView.refreshControl?.endRefreshing()
    }
    
    private func loadData() {
        isFetching = true
        output.getData(howManySkip: howManyArticlesToSkip, sol: "") { [weak self] in
            self?.feedTableView.dataSource = self
            self?.feedTableView.reloadData()
        }
        isFetching = false
    }
    
//    private func loadArticles() {
//        isFetching = true
//        output.getArticles(howManySkip: howManyArticlesToSkip) { [weak self] in
//            self?.feedTableView.dataSource = self
//            self?.feedTableView.reloadData()
//        }
//        isFetching = false
//    }
//
//    private func loadWeatherData() {
//        isFetching = true
//        randomSol = Int.random(in: 1...3000)
//        output.getWeatherOnMars(sol: randomSol) { [weak self] in
//            self?.feedTableView.dataSource = self
//            self?.feedTableView.reloadData()
//        }
//        isFetching = false
//    }
}

extension FeedViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= (output.getPostsData().count - 3) && !isFetching {
                howManyArticlesToSkip+=10
                print(howManyArticlesToSkip)
                loadData()
//                loadArticles()
//                loadWeatherData()
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
        let post = output.cellForRowAt(indexPath: indexPath)
        switch post.postType {
        case .article:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
                return UITableViewCell()
            }
            let article = output.cellForRowAt(indexPath: indexPath)
            cell.configure(article: article as! Article, delegate: self)
            return cell
        case .weatherOnMars:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherOnMarsTableViewCell", for: indexPath) as? WeatherOnMarsTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundImageView.layer.cornerRadius = 20
            cell.configure(sol: "")
            return cell
        
        case .none: break
            //
        case .some(.pictureOfDay): break
            //
        case .some(.pictureFromMars): break
            //
        case .some(.pictureOfEarth): break
            //
        case .some(.asteroid): break
            //
        case .some(.planet): break
            //
        case .some(.searchResult): break
            //
        }
        return UITableViewCell()
        
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = output.cellForRowAt(indexPath: indexPath)
        switch post.postType {
        case .article:
            let vc: ArticleDetailViewController = ArticleDetailModuleBuilder().build()
            vc.article = post as? Article
            navigationController?.pushViewController(vc, animated: true)
        case .weatherOnMars:
            let vc: WeatherOnMarsDetailViewController = WeatherOnMarsDetailModuleBuilder().build()
            navigationController?.pushViewController(vc, animated: true)
        
        case .none: break
            //
        case .some(.pictureOfDay): break
            //
        case .some(.pictureFromMars): break
            //
        case .some(.pictureOfEarth): break
            //
        case .some(.asteroid): break
            //
        case .some(.planet): break
            //
        case .some(.searchResult): break
            //
        }
        
        //к аутпуту
    }
}

extension FeedViewController: SavePostButtonDelegate {
    func savePost(post: Post) {
        output.savePost(post: post)
    }
    
    func removePostFromSaved(post: Post) {
        output.removePostFromSaved(post: post)
    }
}
