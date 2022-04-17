//
//  ViewController.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import SnapKit
import UIKit

class SavedPostsViewController: UIViewController {

    private let output: ViewControllerOutput
    var tableView = UITableView()
    var savedPosts: [Post]?

    init(output: ViewControllerOutput) {
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

    private func setupView() {
        title = "Saved posts"
        view.backgroundColor = .white
        
        self.navigationItem.title = "Saved posts"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ maker in
            maker.top.equalToSuperview().inset(100)
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview().inset(500)
        }
    }
}

extension SavedPostsViewController: ViewControllerInput {
    func updateView(with items: [Post]) {
        savedPosts = items
        tableView.dataSource = self
        tableView.reloadData()
    }

    func showError() {
        
    }
}

extension SavedPostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let posts = savedPosts else { return 0 }
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        let article = savedPosts?[indexPath.row]
        cell.configure(article: article as! Article)
        return cell
    }
}

extension SavedPostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = savedPosts?[indexPath.row]
        let sb = UIStoryboard(name: "Feed", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "ArticleDetailViewController") as! ArticleDetailViewController
        vc.article = article as? Article
        navigationController?.pushViewController(vc, animated: true)
    }
}
