//
//  ArticleDetailPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 07.04.2022.
//

import Foundation

protocol ArticleDetailPresenterProtocol {
    
}

class ArticleDetailPresenter: ArticleDetailPresenterProtocol {
    private let interactor: ArticleDetailInteractorProtocol
    weak var view: ViewControllerInput?
    
    init(interactor: ArticleDetailInteractorProtocol) {
        self.interactor = interactor
    }
}

extension ArticleDetailPresenter: ArticleDetailViewControllerOutput {
    
}
