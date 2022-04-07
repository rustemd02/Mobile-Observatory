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
    let tableView = UITableView()
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
        title = "Liked posts"
        view.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(tableView)
    }
}

extension SavedPostsViewController: ViewControllerInput {
    func updateView(with items: [Post]) {
        savedPosts = items
        print(savedPosts)
        tableView.dataSource = savedPosts as? UITableViewDataSource
        tableView.reloadData()
    }

    func showError() {
        
    }
}

extension SavedPostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension SavedPostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
