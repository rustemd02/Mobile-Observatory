//
//  ViewProtocols.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import Foundation

protocol SavedPostsViewControllerInput: AnyObject {
    func updateView()
    func showError()
}

protocol SavedPostsViewControllerOutput {
    func viewDidLoad()
    func didSelectRow(at: Int)
    func fetchSavedPosts()
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt (indexPath: IndexPath) -> Post
    func savePost(post: Post, indexPath: IndexPath?)
    func removePostFromSaved(post: Post, indexPath: IndexPath?)
}

protocol SavePostButtonDelegate {
    func savePost(post: Post, index: IndexPath?)
    func removePostFromSaved(post: Post, index: IndexPath?)
}
