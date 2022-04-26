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
    func savePost(post: Post)
    func removePostFromSaved(post: Post)
}

protocol SavePostButtonDelegate {
    func savePost(post: Post)
    func removePostFromSaved(post: Post)
}
