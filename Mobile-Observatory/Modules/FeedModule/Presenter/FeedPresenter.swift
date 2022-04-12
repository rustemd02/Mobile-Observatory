//
//  FeedPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 07.04.2022.
//

import Foundation

protocol FeedPresenterProtocol {
    func feedPrefethcing(indexPaths: [IndexPath])
}

class FeedPresenter: FeedPresenterProtocol {
    
    private let interactor: FeedInteractorProtocol
    weak var view: ViewControllerInput?
    
    
    
    init(interactor: FeedInteractorProtocol) {
        self.interactor = interactor
    }
    
    func feedPrefethcing(indexPaths: [IndexPath]) {
        //
        
    }
    
    
    
    
}

extension FeedPresenter: ViewControllerOutput {
    
    func getArticlesData() -> [Article] {
        return interactor.getArticlesData()
    }
    
    
    
    func viewDidLoad() {
        
    }
    
    func didSelectRow(at: Int) {
        
    }
    
    
    func getArticles(howManySkip: Int, completion: @escaping () -> ()) {
        return interactor.getArticles(howManySkip: howManySkip, completion: completion)
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return interactor.numberOfRowsInSection(section: section)
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Article {
        return interactor.cellForRowAt(indexPath: indexPath)
    }
    
    
    
    
    
}
