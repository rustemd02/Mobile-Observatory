//
//  ArticleDetailPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 07.04.2022.
//

import Foundation
import UIKit

protocol ArticleDetailPresenterProtocol {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
}

class ArticleDetailPresenter: ArticleDetailPresenterProtocol {
    
    private let interactor: ArticleDetailInteractorProtocol
    weak var view: ArticleDetailViewControllerInput?
    
    init(interactor: ArticleDetailInteractorProtocol) {
        self.interactor = interactor
    }
    
}

extension ArticleDetailPresenter: ArticleDetailViewControllerOutput {
    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
        return interactor.getImage(url: url, completion: completion)
    }
}
