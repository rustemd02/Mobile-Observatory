//
//  ViewProtocols.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import Foundation

protocol SavedPostsViewControllerInput: AnyObject {
    func updateView(with items: [Post])
    func showError()
}

protocol SavedPostsViewControllerOutput {
    func viewDidLoad()
    func didSelectRow(at: Int)
    func fetchSavedArticles()
}
