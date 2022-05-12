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
    func getData(completion: @escaping () -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt (indexPath: IndexPath) -> Post
    func getPostsData() -> [Post]
    func savePost(post: Post)
    func removePostFromSaved(post: Post)
    func resetFeed()
}

class FeedViewController: UIViewController, UIScrollViewDelegate {
    let api = NetworkService.shared
    private var output: FeedViewControllerOutput
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
        view.addSubview(feedTableView)
        
        feedTableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleTableViewCell")
        feedTableView.register(WeatherOnMarsTableViewCell.self, forCellReuseIdentifier: "WeatherOnMarsTableViewCell")
        feedTableView.register(PictureOfDayTableViewCell.self, forCellReuseIdentifier: "PictureOfDayTableViewCell")
        feedTableView.register(PictureFromMarsTableViewCell.self, forCellReuseIdentifier: "PictureFromMarsTableViewCell")
        feedTableView.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide)
            maker.left.right.bottom.equalToSuperview()
        }
        
    }
    
    @objc private func didPullToRefresh() {
        output.resetFeed()
        loadData()
        feedTableView.reloadData()
        self.feedTableView.refreshControl?.endRefreshing()
    }
    
    private func loadData() {
        isFetching = true
        output.getData() { [weak self] in
            self?.feedTableView.dataSource = self
            self?.feedTableView.reloadData()
        }
        isFetching = false
    }
}

extension FeedViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= (output.getPostsData().count - 3) && !isFetching {
                loadData()
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
            cell.article = post as? Article
            cell.configure(delegate: self)
            return cell
        case .weatherOnMars:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherOnMarsTableViewCell", for: indexPath) as? WeatherOnMarsTableViewCell else {
                return UITableViewCell()
            }
            cell.weatherOnMars = post as? WeatherOnMarsInfo
            cell.configure()
            return cell
        
        case .none: break
            //
        case .pictureOfDay:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PictureOfDayTableViewCell", for: indexPath) as?
                    PictureOfDayTableViewCell else {
                return UITableViewCell()
            }
            cell.pictureOfDay = post as? PictureOfDay
            cell.configure()
            return cell
        case .pictureFromMars: 
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PictureFromMarsTableViewCell", for: indexPath) as? PictureFromMarsTableViewCell else {
                return UITableViewCell()
            }
            cell.picFromMars = post as? PictureFromMars
            cell.configure()
            return cell
        case .pictureOfEarth: break
            //
        case .asteroid: break
            //
        case .planet: break
            //
        case .searchResult: break
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
            vc.weatherOnMars = post as? WeatherOnMarsInfo
            navigationController?.pushViewController(vc, animated: true)
        
        case .pictureOfDay:
            let vc: PictureOfDayDetailViewController = PictureOfDayDetailModuleBuilder().build()
            vc.picOfDay = post as? PictureOfDay
            navigationController?.pushViewController(vc, animated: true)
            
        case .pictureFromMars:
            let vc: PictureFromMarsDetailViewController = PictureFromMarsDetailModuleBuilder().build()
            vc.picFromMars = post as? PictureFromMars
            navigationController?.pushViewController(vc, animated: true)
            
        case .pictureOfEarth: break
            //
        case .asteroid: break
            //
        case .planet: break
            //
        case .searchResult: break
            //
            
        case .none: break
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
