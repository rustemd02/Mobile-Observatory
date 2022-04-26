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
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }

    private func setupView() {
        title = "Saved posts"
        view.backgroundColor = .white
        
        self.navigationItem.title = "Saved posts"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        tableView.register(WeatherOnMarsTableViewCell.self, forCellReuseIdentifier: "WeatherOnMarsTableViewCell")
        tableView.register(PictureOfDayTableViewCell.self, forCellReuseIdentifier: "PictureOfDayTableViewCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ maker in
            maker.top.equalToSuperview().inset(100)
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
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
            cell.configure(delegate: self)
            return cell
        case .weatherOnMars:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherOnMarsTableViewCell", for: indexPath) as? WeatherOnMarsTableViewCell else {
                return UITableViewCell()
            }
            cell.weatherOnMars = post as? WeatherOnMarsInfo
            cell.configure(delegate: self)
            return cell
        case .pictureOfDay:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PictureOfDayTableViewCell", for: indexPath) as?
                    PictureOfDayTableViewCell else {
                return UITableViewCell()
            }
            cell.pictureOfDay = post as? PictureOfDay
            cell.configure()
            return cell
        case .pictureFromMars: break
            //
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
            navigationController?.pushViewController(vc, animated: true)
        case .some(.pictureOfDay):
            let vc: PictureOfDayDetailViewController = PictureOfDayDetailModuleBuilder().build()
            navigationController?.pushViewController(vc, animated: true)
            
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
        case .none: break
        }
    }
}

extension SavedPostsViewController: SavePostButtonDelegate {
    func savePost(post: Post) {
        output.savePost(post: post)
    }
    
    func removePostFromSaved(post: Post) {
        output.removePostFromSaved(post: post)
    }
}
