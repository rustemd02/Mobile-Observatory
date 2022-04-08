//
//  FeedPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 07.04.2022.
//

import Foundation

protocol FeedPresenterProtocol {
    func loadArticles()
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
    
    func loadArticles() {
        
    }
    
}

extension FeedPresenter: ViewControllerOutput {
    func viewDidLoad() {
        
    }
    
    func didSelectRow(at: Int) {
        
    }
    
    
}
