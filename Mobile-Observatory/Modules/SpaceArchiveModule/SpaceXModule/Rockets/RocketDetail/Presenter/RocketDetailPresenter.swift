//
//  RocketDetailPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 24.05.2022.
//
import UIKit

protocol RocketDetailPresenterProtocol {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
}

class RocketDetailPresenter: RocketDetailPresenterProtocol {
    
    private let interactor: RocketDetailInteractorProtocol
    weak var view: RocketDetailViewControllerInput?
    
    init(interactor: RocketDetailInteractorProtocol) {
        self.interactor = interactor
    }
   
}

extension RocketDetailPresenter: RocketDetailViewControllerOutput {
    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
        return interactor.getImage(url: url, completion: completion)
    }
    
    
    
}
