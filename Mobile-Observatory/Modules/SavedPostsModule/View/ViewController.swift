//
//  ViewController.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import UIKit

class SavedPostsViewController: UIViewController {

    private let output: ViewControllerOutput
    let tableView = UITableView()

    init(output: ViewControllerOutput) {
        self.output = output
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
    }

    private func setupView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaInsets, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaInsets, attribute: .top, multiplier: 1, constant: 0)
        ])
    }
}

extension SavedPostsViewController: ViewControllerInput {
    func updateView(with items: [String]) {
        <#code#>
    }

    func showError() {
        <#code#>
    }
}

extension SavedPostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

extension SavedPostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}
