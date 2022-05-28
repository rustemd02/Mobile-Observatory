//
//  SearchResultViewController.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 28.05.2022.
//

import Foundation
import UIKit

protocol SearchResultInput: AnyObject {
}

protocol SearchResultOutput {
    func viewDidLoad()
    func didSelectRow(at: Int)
    func getData(completion: @escaping () -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt (indexPath: IndexPath) -> Post
    func getPostsData() -> [Post]
    func savePost(post: Post, index: IndexPath?)
    func removePostFromSaved(post: Post, index: IndexPath?)
    func resetFeed()
}

class SearchResultDetailViewController: SearchResultInput {
    
}
