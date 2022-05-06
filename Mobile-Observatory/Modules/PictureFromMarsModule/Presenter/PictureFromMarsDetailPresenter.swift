//
//  PictureFromMarsDetailPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 05.05.2022.
//

import Foundation

protocol PictureFromMarsDetailPresenterProtocol {
    
}

class PictureFromMarsDetailPresenter: PictureFromMarsDetailPresenterProtocol {
    private let interactor: PictureFromMarsDetailInteractorProtocol
    weak var view: PictureFromMarsDetailViewControllerInput?
    
    init(interactor: PictureFromMarsDetailInteractorProtocol) {
        self.interactor = interactor
    }
}

extension PictureFromMarsDetailPresenter: PictureFromMarsDetailViewControllerOutput {
    
}
