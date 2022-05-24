//
//  CrewDetailPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 23.05.2022.
//

import Foundation
import UIKit

protocol CrewDetailPresenterProtocol {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
}

class CrewDetailPresenter: CrewDetailPresenterProtocol {
    
    private let interactor: CrewDetailInteractorProtocol
    weak var view: CrewDetailViewControllerInput?
    
    init(interactor: CrewDetailInteractorProtocol) {
        self.interactor = interactor
    }
   
}

extension CrewDetailPresenter: CrewDetailViewControllerOutput {
    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
        return interactor.getImage(url: url, completion: completion)
    }
    
    
    
}
