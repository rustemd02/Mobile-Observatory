//
//  ViewController.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import SnapKit
import UIKit

class SavedPostsViewController: UIViewController {
    private let output: SavedPostsViewControllerOutput
    var tableView = UITableView()
    
    init(output: SavedPostsViewControllerOutput) {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    private func setupView() {
        title = "Сохранённые"
        view.backgroundColor = .white
        
        self.navigationItem.title = "Сохранённые"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleTableViewCell")
        tableView.register(WeatherOnMarsTableViewCell.self, forCellReuseIdentifier: "WeatherOnMarsTableViewCell")
        tableView.register(PictureOfDayTableViewCell.self, forCellReuseIdentifier: "PictureOfDayTableViewCell")
        tableView.register(PictureFromMarsTableViewCell.self, forCellReuseIdentifier: "PictureFromMarsTableViewCell")
        tableView.snp.makeConstraints{ maker in
            maker.top.equalTo(view.safeAreaLayoutGuide)
            maker.left.right.bottom.equalToSuperview()
        }
    }
}

extension SavedPostsViewController: SavedPostsViewControllerInput {
    func updateView() {
        output.fetchSavedPosts()
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func showError() {
        
    }
}

extension SavedPostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = output.cellForRowAt(indexPath: indexPath)
        switch post.postType {
        case .article:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
                return UITableViewCell()
            }
            cell.article = post as? Article
            cell.configure(delegate: self, index: indexPath)
            return cell
        case .weatherOnMars:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherOnMarsTableViewCell", for: indexPath) as? WeatherOnMarsTableViewCell else {
                return UITableViewCell()
            }
            cell.weatherOnMars = post as? WeatherOnMarsInfo
            cell.configure(delegate: self, index: indexPath)
            return cell
        case .pictureOfDay:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PictureOfDayTableViewCell", for: indexPath) as?
                    PictureOfDayTableViewCell else {
                        return UITableViewCell()
                    }
            cell.pictureOfDay = post as? PictureOfDay
            cell.configure(delegate: self, index: indexPath)
            return cell
        case .pictureFromMars:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PictureFromMarsTableViewCell", for: indexPath) as? PictureFromMarsTableViewCell else {
                return UITableViewCell()
            }
            cell.picFromMars = post as? PictureFromMars
            cell.configure(delegate: self, index: indexPath)
            return cell
        case .pictureOfEarth: break
            //
        case .asteroid: break
            //
        case .planet: break
            //
        case .searchResult: break
            //
        case .none: break
        }
        return UITableViewCell()
    }
}

extension SavedPostsViewController: UITableViewDelegate {
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
        }
    }
}

extension SavedPostsViewController: SavePostButtonDelegate {
    func savePost(post: Post, index: IndexPath?) {
        output.savePost(post: post, indexPath: index)
    }
    
    func removePostFromSaved(post: Post, index: IndexPath?) {
        output.removePostFromSaved(post: post, indexPath: index)
    }
}
